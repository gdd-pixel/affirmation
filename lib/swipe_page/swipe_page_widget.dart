import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/components/app_themes.dart';
import '/components/avantsettings_widget.dart';
import '/components/category_meta.dart';
import '/components/category_widget.dart';
import '/components/nolikeyet_widget.dart';
import '/components/phil_nav_bar.dart';
import '/components/popupexo_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'swipe_page_model.dart';
export 'swipe_page_model.dart';

/// Page principale : fil d'affirmations « Pour toi » (catégories choisies)
/// et « Favoris », avec la barre de navigation en bas.
class SwipePageWidget extends StatefulWidget {
  const SwipePageWidget({super.key});

  static String routeName = 'swipePage';
  static String routePath = '/swipePage';

  @override
  State<SwipePageWidget> createState() => _SwipePageWidgetState();
}

enum _Feed { forYou, favorites }

/// Debug uniquement : rejoue l'introduction de la première visite.
/// Ex. : flutter run --dart-define=FIRST_VISIT=true
const bool kDebugForceFirstVisit =
    kDebugMode && bool.fromEnvironment('FIRST_VISIT');

/// Écran d'introduction de la première visite.
class _IntroSlide {
  const _IntroSlide(this.text,
      {this.icon, this.caption, this.likeable = false});

  final String text;
  final PhilNavDestination? icon;

  /// Petit texte en haut de l'écran.
  final String? caption;

  /// Affiche un cœur à toucher.
  final bool likeable;
}

const _introSlides = [
  _IntroSlide('Bienvenue dans Phil\'O !'),
  _IntroSlide('Rendez-vous ici chaque jour pour faire le plein'),
  _IntroSlide('Deviens la meilleure version de toi même'),
  _IntroSlide('Je vais devenir la personne qui réussit mes objectifs'),
  _IntroSlide('Je suis assez'),
  _IntroSlide(
    'Je mérite d\'être aimé.e',
    caption: 'Like des affirmations pour\ncalibrer ton feed !',
    likeable: true,
  ),
  _IntroSlide(
    'Découvre les affirmations sélectionnées pour toi dans ton feed',
    icon: PhilNavDestination.home,
  ),
  _IntroSlide(
    'Choisis les catégories selon ton humeur du moment',
    icon: PhilNavDestination.categories,
  ),
  _IntroSlide(
    'Manifeste la vie que tu souhaites',
    icon: PhilNavDestination.manifest,
  ),
  _IntroSlide(
    'Installe ton widget pour recevoir tes affirmations et manifestations',
    icon: PhilNavDestination.widgets,
  ),
  _IntroSlide('Prêt.e pour ton évolution ?'),
];

/// Cartes de l'introduction visées par l'animation du like.
const _introLikeTarget = 'intro-like';
const _introAffirmationTarget = 'intro-affirmation';

/// Première affirmation du fil, sur laquelle se termine l'introduction.
const _introAffirmation = 'Tout ce que je cherche est déjà en moi';
const _introAffirmationCategory = Category.confiance;

class _SwipePageWidgetState extends State<SwipePageWidget> {
  late SwipePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  _Feed _feed = _Feed.forYou;
  final _forYouController = PageController();
  final _favoritesController = PageController();

  // Ordre aléatoire du fil « Pour toi », stable pendant toute la session.
  final int _shuffleSeed = Random().nextInt(1 << 30);

  Stream<List<AffirmationRecord>>? _forYouStream;
  String? _forYouStreamKey;
  late final Stream<List<FavoritesRecord>> _favoritesStream;

  bool _togglingLike = false;

  /// Vrai une fois vérifié que l'onboarding est terminé. Avant, on affiche
  /// l'écran de démarrage : sinon la page apparaît une fraction de seconde
  /// avant la redirection vers l'onboarding.
  bool _accessChecked = false;

  // Incrémenté à chaque like : relance l'animation du cœur depuis le début.
  int _likeAnimationId = 0;
  String? _likeAnimationTarget;

  // Introduction de la première visite.
  final _introController = PageController();
  bool _debugFirstVisit = kDebugForceFirstVisit;
  bool _introLiked = false;
  bool _revealStarted = false;
  bool _introCompleted = false;

  /// 0 : introduction, 1 : barre de navigation visible, 2 : haut de l'écran
  /// visible.
  int _revealStage = 0;

  /// Écran « Like » de l'introduction : 0 rien, 1 légende, 2 cœur.
  int _likeSlideStage = 0;
  bool _introScrollLocked = false;
  bool _introAdvancing = false;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SwipePageModel());
    _favoritesStream = queryFavoritesRecord(
      parent: currentUserReference,
      queryBuilder: (favorites) =>
          favorites.orderBy('createdAt', descending: true),
    );

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'swipePage'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (await _hasFinishedOnboarding()) {
        safeSetState(() => _accessChecked = true);
        HapticFeedback.vibrate();
        await actions.handlePushNavigation(
          context,
        );
        _model.isliked = false;
        safeSetState(() {});
        await actions.syncWidgetContent();
        if ((dateTimeFormat(
                  "d/M/y",
                  currentUserDocument?.lastOpenAt,
                  locale: FFLocalizations.of(context).languageCode,
                ) !=
                dateTimeFormat(
                  "d/M/y",
                  getCurrentTimestamp,
                  locale: FFLocalizations.of(context).languageCode,
                )) &&
            (dateTimeFormat(
                  "d/M/y",
                  getCurrentTimestamp,
                  locale: FFLocalizations.of(context).languageCode,
                ) !=
                dateTimeFormat(
                  "d/M/y",
                  currentUserDocument?.createdTime,
                  locale: FFLocalizations.of(context).languageCode,
                ))) {
          await showModalBottomSheet(
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            enableDrag: false,
            context: context,
            builder: (context) {
              return GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                child: Padding(
                  padding: MediaQuery.viewInsetsOf(context),
                  child: Container(
                    height: double.infinity,
                    child: PopupexoWidget(),
                  ),
                ),
              );
            },
          ).then((value) => safeSetState(() {}));
        }

        await currentUserReference!.update(createUsersRecordData(
          nextNotificationAt: functions.nextday8AM(),
          nextNotificationType: 'daily',
          lastOpenAt: getCurrentTimestamp,
        ));
      } else {
        context.goNamed(InscriptionWidget.routeName);
      }
    });
  }

  /// Onboarding terminé (abonnement pris) ?
  ///
  /// `currentUserDocument` est une copie locale mise à jour en arrière-plan :
  /// juste après l'achat ou au démarrage, elle peut ne pas être encore à jour.
  /// On relit donc le compte dans la base avant de renvoyer vers l'onboarding.
  Future<bool> _hasFinishedOnboarding() async {
    if (valueOrDefault<bool>(currentUserDocument?.comptefini, false)) {
      return true;
    }
    final ref = currentUserReference;
    if (ref == null) {
      return false;
    }
    try {
      return (await UsersRecord.getDocumentOnce(ref)
              .timeout(const Duration(seconds: 4)))
          .comptefini;
    } catch (_) {
      // Lecture impossible ou trop lente : on ne renvoie pas un abonné vers
      // l'onboarding.
      return true;
    }
  }

  @override
  void dispose() {
    _model.dispose();
    _forYouController.dispose();
    _favoritesController.dispose();
    _introController.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------------------------
  // Données

  List<Category> get _selectedCategories {
    final selected = (currentUserDocument?.selectedCategories ?? const [])
        .map(deserializeEnum<Category>)
        .whereType<Category>()
        .toList();
    return selected.isEmpty ? kDefaultCategories : selected;
  }

  /// Flux des affirmations des catégories choisies, recréé seulement quand
  /// la sélection change.
  Stream<List<AffirmationRecord>> _forYouAffirmations() {
    final categories = _selectedCategories.map((c) => c.serialize()).toList()
      ..sort();
    final key = categories.join(',');
    if (_forYouStream == null || key != _forYouStreamKey) {
      _forYouStreamKey = key;
      _forYouStream = queryAffirmationRecord(
        queryBuilder: (affirmations) =>
            affirmations.where('category', whereIn: categories),
      );
    }
    return _forYouStream!;
  }

  List<AffirmationRecord> _shuffled(List<AffirmationRecord> records) =>
      [...records]..sort((a, b) => (a.reference.id.hashCode ^ _shuffleSeed)
          .compareTo(b.reference.id.hashCode ^ _shuffleSeed));

  Future<void> _toggleLike({
    required DocumentReference? affirmationRef,
    required String text,
    required List<FavoritesRecord> existing,
    required String animationTarget,
  }) async {
    if (_togglingLike) {
      return;
    }
    _togglingLike = true;
    HapticFeedback.lightImpact();
    try {
      if (existing.isNotEmpty) {
        // Déliker : on retire l'affirmation des favoris (et ses doublons).
        for (final favorite in existing) {
          await favorite.reference.delete();
        }
      } else {
        await FavoritesRecord.createDoc(currentUserReference!)
            .set(createFavoritesRecordData(
          affirmationRef: affirmationRef,
          createdAt: getCurrentTimestamp,
          text: text,
        ));
        _playLikeAnimation(animationTarget);
      }
    } finally {
      _togglingLike = false;
    }
    unawaited(actions.syncWidgetContent());
  }

  /// Joue l'animation du like sur la carte [target] uniquement.
  void _playLikeAnimation(String target) {
    final id = ++_likeAnimationId;
    _likeAnimationTarget = target;
    _model.showanimation = true;
    safeSetState(() {});
    unawaited(Future.delayed(const Duration(milliseconds: 2000), () {
      if (id == _likeAnimationId) {
        _stopLikeAnimation();
      }
    }));
  }

  /// Arrête l'animation du like (fin de l'animation ou changement de carte).
  void _stopLikeAnimation() {
    if (!_model.showanimation) {
      return;
    }
    _likeAnimationId++;
    _likeAnimationTarget = null;
    _model.showanimation = false;
    safeSetState(() {});
  }

  /// Identifiant d'animation à passer à la carte [target], ou null si
  /// l'animation ne la concerne pas.
  int? _likeAnimationFor(String target) =>
      _model.showanimation && _likeAnimationTarget == target
          ? _likeAnimationId
          : null;

  // ---------------------------------------------------------------------------
  // Introduction de la première visite

  /// Debug : relance l'introduction depuis le premier écran.
  void _replayIntro() {
    setState(() {
      _debugFirstVisit = true;
      _introCompleted = false;
      _revealStarted = false;
      _revealStage = 0;
      _introLiked = false;
      _likeSlideStage = 0;
      _introScrollLocked = false;
      _introAdvancing = false;
    });
    if (_introController.hasClients) {
      _introController.jumpToPage(0);
    }
  }

  /// Écran « Like » : la légende puis le cœur apparaissent en douceur ;
  /// l'utilisateur ne peut pas défiler pendant cette apparition.
  Future<void> _revealLikeSlide() async {
    if (_likeSlideStage > 0) {
      return;
    }
    setState(() {
      _introScrollLocked = true;
      _likeSlideStage = 0;
    });
    await Future.delayed(const Duration(milliseconds: 400));
    safeSetState(() => _likeSlideStage = 1);
    await Future.delayed(const Duration(milliseconds: 900));
    safeSetState(() => _likeSlideStage = 2);
    await Future.delayed(const Duration(milliseconds: 900));
    safeSetState(() => _introScrollLocked = false);
  }

  /// Like sur l'écran « Like » : animation du cœur, puis écran suivant.
  Future<void> _likeIntroSlide() async {
    if (_introAdvancing || _introScrollLocked) {
      return;
    }
    HapticFeedback.lightImpact();
    setState(() {
      _introLiked = true;
      _introAdvancing = true;
    });
    _playLikeAnimation(_introLikeTarget);
    await Future.delayed(const Duration(milliseconds: 1100));
    if (mounted && _introController.hasClients) {
      await _introController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
    // Redessiner pour débloquer le défilement sur l'écran suivant.
    safeSetState(() => _introAdvancing = false);
  }

  /// Dernier écran atteint : on bloque le défilement, puis la barre de
  /// navigation apparaît, puis le haut de l'écran. L'app devient normale.
  Future<void> _startReveal() async {
    if (_revealStarted) {
      return;
    }
    _revealStarted = true;
    safeSetState(() {});
    await Future.delayed(const Duration(milliseconds: 700));
    safeSetState(() => _revealStage = 1);
    await Future.delayed(const Duration(milliseconds: 1600));
    safeSetState(() => _revealStage = 2);
    await Future.delayed(const Duration(milliseconds: 1200));
    if (!mounted) {
      return;
    }
    setState(() {
      _introCompleted = true;
      _debugFirstVisit = false;
    });
    await currentUserReference!.update(createUsersRecordData(
      accountfinished: false,
    ));
  }

  Widget _buildIntro(_ThemeLook look, List<FavoritesRecord> favorites) {
    return PageView.builder(
      controller: _introController,
      scrollDirection: Axis.vertical,
      // Pendant l'apparition des éléments, l'utilisateur ne peut pas défiler.
      physics: _revealStarted || _introScrollLocked || _introAdvancing
          ? const NeverScrollableScrollPhysics()
          : null,
      itemCount: _introSlides.length + 1,
      onPageChanged: (page) {
        HapticFeedback.lightImpact();
        _stopLikeAnimation();
        if (page < _introSlides.length && _introSlides[page].likeable) {
          _revealLikeSlide();
        }
        if (page == _introSlides.length) {
          _startReveal();
        }
      },
      itemBuilder: (context, index) {
        if (index == _introSlides.length) {
          return _buildIntroAffirmationCard(look, favorites,
              revealed: _revealStage >= 2);
        }
        final slide = _introSlides[index];
        return _AffirmationCard(
          look: look,
          text: slide.text,
          // Texte un peu plus petit sur les écrans avec une icône.
          textScale: slide.icon == null ? 1.0 : 0.85,
          caption: slide.caption,
          headerVisible: !slide.likeable || _likeSlideStage >= 1,
          likeVisible: !slide.likeable || _likeSlideStage >= 2,
          aboveText: slide.icon == null
              ? null
              : Padding(
                  padding: const EdgeInsets.only(bottom: 32.0),
                  child: PhilNavButton(destination: slide.icon!, size: 76.0),
                ),
          showLike: slide.likeable,
          liked: _introLiked,
          likeAnimationId: _likeAnimationFor(_introLikeTarget),
          onLike: _likeIntroSlide,
          pulseLike: slide.likeable,
          // Incitation au défilement sur les 3 premiers écrans seulement.
          showChevron: index < 3,
          animateChevron: true,
          chevronHint: index == 0 ? 'Scroll pour découvrir' : null,
        );
      },
    );
  }

  /// « Tout ce que je cherche est déjà en moi » : dernier écran de
  /// l'introduction puis première affirmation du fil.
  Widget _buildIntroAffirmationCard(
    _ThemeLook look,
    List<FavoritesRecord> favorites, {
    bool revealed = true,
  }) {
    final meta = categoryMetaFor(_introAffirmationCategory);
    final existing = favorites
        .where((f) => f.affirmationRef == null && f.text == _introAffirmation)
        .toList();
    return _AffirmationCard(
      look: look,
      text: _introAffirmation,
      label: meta?.label,
      image: meta?.image,
      headerVisible: revealed,
      showLike: true,
      likeVisible: revealed,
      liked: existing.isNotEmpty,
      likeAnimationId: _likeAnimationFor(_introAffirmationTarget),
      onLike: () => _toggleLike(
        affirmationRef: null,
        text: _introAffirmation,
        existing: existing,
        animationTarget: _introAffirmationTarget,
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Navigation

  Future<dynamic> _openSheet(Widget child) => showModalBottomSheet<dynamic>(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        enableDrag: false,
        context: context,
        builder: (context) => GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Padding(
            padding: MediaQuery.viewInsetsOf(context),
            child: child,
          ),
        ),
      );

  void _showFeed(_Feed feed) {
    if (_feed == feed) {
      return;
    }
    HapticFeedback.selectionClick();
    _stopLikeAnimation();
    setState(() => _feed = feed);
  }

  Future<void> _openCategories() async {
    HapticFeedback.heavyImpact();
    final result = await _openSheet(const CategoryWidget());
    if (result == kOpenFavoritesResult) {
      _showFeed(_Feed.favorites);
    }
    safeSetState(() {});
  }

  // ---------------------------------------------------------------------------
  // Interface

  @override
  Widget build(BuildContext context) {
    if (!_accessChecked) {
      // Même image que l'écran de démarrage (voir FFRoute dans nav.dart).
      return Container(
        color: FlutterFlowTheme.of(context).primary,
        child: Image.asset(
          'assets/images/#fff1ef_(1).gif',
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    }
    return AuthUserStreamWidget(
      builder: (context) {
        final look = _ThemeLook.of(context);
        // `accountfinished` vaut true tant que l'introduction n'a pas été vue.
        final intro = !_introCompleted &&
            (valueOrDefault<bool>(
                    currentUserDocument?.accountfinished, false) ||
                _debugFirstVisit);
        final navVisible = !intro || _revealStage >= 1;
        final topVisible = !intro || _revealStage >= 2;

        return StreamBuilder<List<FavoritesRecord>>(
          stream: _favoritesStream,
          builder: (context, favoritesSnapshot) {
            final favorites = favoritesSnapshot.data;

            return GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Scaffold(
                key: scaffoldKey,
                backgroundColor: look.background,
                body: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  decoration: look.decoration,
                  child: SafeArea(
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            _FadeIn(
                              visible: topVisible,
                              child: _buildHeader(look),
                            ),
                            Expanded(
                              child: favorites == null
                                  ? Center(
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                look.text),
                                      ),
                                    )
                                  : intro
                                      ? _buildIntro(look, favorites)
                                      : _feed == _Feed.forYou
                                          ? _buildForYouFeed(look, favorites)
                                          : _buildFavoritesFeed(
                                              look, favorites),
                            ),
                            _FadeIn(
                              visible: navVisible,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, bottom: 12.0),
                                child: PhilNavBar(
                                  // Même couleur que le texte des affirmations.
                                  labelColor: look.text,
                                  onHome: () => _showFeed(_Feed.forYou),
                                  onCategories: _openCategories,
                                  onManifest: () => context
                                      .pushNamed(SwipePageOwnWidget.routeName),
                                  onWidgets: () => context
                                      .pushNamed(WidgetsPageWidget.routeName),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildHeader(_ThemeLook look) {
    Widget tab(String label, _Feed feed) {
      final selected = _feed == feed;
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => _showFeed(feed),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: GoogleFonts.poppins(
              color: selected ? look.text : look.text.withValues(alpha: 0.55),
              fontSize: 13.0,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
            ),
            child: Text(label),
          ),
        ),
      );
    }

    final theme = FlutterFlowTheme.of(context);
    final profileButton = GestureDetector(
      onTap: () async {
        HapticFeedback.heavyImpact();
        final result = await _openSheet(AvantsettingsWidget());
        if (result == kReplayIntroResult) {
          _replayIntro();
        }
        safeSetState(() {});
      },
      child: NavRoundButton(
        size: 38.0,
        child: Icon(Icons.person_rounded, color: theme.secondary, size: 22.0),
      ),
    );

    // Onglets centrés sur l'écran ; bouton profil au centre de la dernière
    // colonne de la barre de navigation, donc aligné sur le bouton Widgets.
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              tab('Pour toi', _Feed.forYou),
              tab('Favoris', _Feed.favorites),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: PhilNavBar.horizontalPadding),
            child: Row(
              children: [
                const Spacer(flex: PhilNavBar.columns - 1),
                Expanded(child: Center(child: profileButton)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForYouFeed(_ThemeLook look, List<FavoritesRecord> favorites) {
    return StreamBuilder<List<AffirmationRecord>>(
      stream: _forYouAffirmations(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox.shrink();
        }
        final affirmations = _shuffled(snapshot.data!);
        if (affirmations.isEmpty) {
          return _EmptyFeed(
            look: look,
            text: 'Aucune affirmation pour le moment dans tes catégories.',
          );
        }
        // Juste après l'introduction, le fil commence par l'affirmation sur
        // laquelle elle s'est terminée.
        final offset = _introCompleted ? 1 : 0;
        return PageView.builder(
          controller: _forYouController,
          scrollDirection: Axis.vertical,
          onPageChanged: (_) {
            HapticFeedback.lightImpact();
            _stopLikeAnimation();
          },
          itemBuilder: (context, index) {
            if (index < offset) {
              return _buildIntroAffirmationCard(look, favorites);
            }
            final affirmation =
                affirmations[(index - offset) % affirmations.length];
            final existing = favorites
                .where((f) => f.affirmationRef == affirmation.reference)
                .toList();
            final meta = categoryMetaFor(affirmation.category);
            return _AffirmationCard(
              look: look,
              text: affirmation.text,
              label: meta?.label,
              image: meta?.image,
              liked: existing.isNotEmpty,
              showLike: true,
              likeAnimationId: _likeAnimationFor('forYou-$index'),
              onLike: () => _toggleLike(
                affirmationRef: affirmation.reference,
                text: affirmation.text,
                existing: existing,
                animationTarget: 'forYou-$index',
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildFavoritesFeed(_ThemeLook look, List<FavoritesRecord> favorites) {
    if (favorites.isEmpty) {
      return const Center(child: NolikeyetWidget());
    }
    return PageView.builder(
      controller: _favoritesController,
      scrollDirection: Axis.vertical,
      onPageChanged: (_) {
        HapticFeedback.lightImpact();
        _stopLikeAnimation();
      },
      itemBuilder: (context, index) {
        final favorite = favorites[index % favorites.length];
        return _AffirmationCard(
          look: look,
          text: favorite.text,
          label: kFavoritesLabel,
          image: kFavoritesImage,
          liked: true,
          showLike: true,
          likeAnimationId: _likeAnimationFor('favorites-$index'),
          onLike: () => _toggleLike(
            affirmationRef: favorite.affirmationRef,
            text: favorite.text,
            existing: [favorite],
            animationTarget: 'favorites-$index',
          ),
        );
      },
    );
  }
}

/// Une affirmation du fil : catégorie (mascotte + libellé) en haut, texte
/// au centre de l'écran et cœur en dessous.
///
/// Le texte est encadré par deux emplacements de même hauteur : celui du
/// dessus accueille l'animation du like (ou une icône), celui du dessous le
/// cœur et la flèche. Le texte reste ainsi exactement centré.
class _AffirmationCard extends StatelessWidget {
  const _AffirmationCard({
    required this.look,
    required this.text,
    required this.liked,
    required this.showLike,
    required this.onLike,
    this.label,
    this.image,
    this.caption,
    this.aboveText,
    this.likeAnimationId,
    this.headerVisible = true,
    this.likeVisible = true,
    this.showChevron = false,
    this.pulseLike = false,
    this.textScale = 1.0,
    this.animateChevron = false,
    this.chevronHint,
  });

  final _ThemeLook look;
  final String text;
  final bool liked;
  final bool showLike;
  final VoidCallback onLike;

  /// Catégorie affichée en haut (mascotte + libellé).
  final String? label;
  final String? image;

  /// Petit texte en haut, à la place de la catégorie.
  final String? caption;

  /// Élément juste au-dessus du texte (ex. icône de l'introduction).
  final Widget? aboveText;

  /// Non nul pendant l'animation du like.
  final int? likeAnimationId;

  /// Apparition en fondu de la catégorie et du cœur.
  final bool headerVisible;
  final bool likeVisible;

  /// Flèche « fais défiler » de l'introduction.
  final bool showChevron;

  /// Cœur qui bat pour inciter au like (introduction).
  final bool pulseLike;

  /// Taille du texte par rapport au style du thème.
  final double textScale;

  /// La flèche rebondit pour inciter à faire défiler.
  final bool animateChevron;

  /// Petit texte sous la flèche.
  final String? chevronHint;

  Widget _chevron() {
    final icon = CustomPaint(
      size: const Size(33.0, 24.0),
      painter: _ThinChevronsPainter(look.text),
    );
    if (!animateChevron) {
      return icon;
    }
    return icon
        .animate(onPlay: (controller) => controller.repeat(reverse: true))
        .moveY(
          begin: -3.0,
          end: 5.0,
          duration: 750.ms,
          curve: Curves.easeInOut,
        );
  }

  static const double _slotHeight = 110.0;

  @override
  Widget build(BuildContext context) {
    Widget? top;
    if (caption != null) {
      top = Padding(
        padding: const EdgeInsets.only(top: 40.0),
        child: Text(
          caption!,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(color: look.text, fontSize: 13.5),
        ),
      );
    } else if (image != null) {
      top = Padding(
        padding: const EdgeInsets.only(top: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(image!, width: 56.0, height: 56.0),
            const SizedBox(height: 4.0),
            Text(
              label ?? '',
              style: GoogleFonts.poppins(
                color: look.text,
                fontSize: 10.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      );
    }

    Widget? aboveSlot;
    if (likeAnimationId != null) {
      aboveSlot = _LikeBurst(key: ValueKey(likeAnimationId), color: look.text);
    } else if (aboveText != null) {
      aboveSlot = aboveText;
    }

    return Stack(
      children: [
        if (showChevron)
          Align(
            alignment: const Alignment(0.0, 0.78),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _chevron(),
                const SizedBox(height: 22.0),
                Visibility(
                  visible: chevronHint != null,
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  child: Text(
                    chevronHint ?? ' ',
                    style: GoogleFonts.poppins(
                      color: look.text,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        if (top != null)
          Align(
            alignment: Alignment.topCenter,
            child: _FadeIn(visible: headerVisible, child: top),
          ),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: _slotHeight,
                  child: aboveSlot == null
                      ? null
                      : likeAnimationId != null
                          // L'animation du like peut dépasser vers le haut.
                          ? OverflowBox(
                              maxWidth: 200.0,
                              maxHeight: 200.0,
                              alignment: Alignment.bottomCenter,
                              child: aboveSlot,
                            )
                          : Align(
                              alignment: Alignment.bottomCenter,
                              child: aboveSlot,
                            ),
                ),
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: look.affirmationStyle.copyWith(
                    fontSize:
                        (look.affirmationStyle.fontSize ?? 20.0) * textScale,
                  ),
                ),
                SizedBox(
                  height: _slotHeight,
                  child: Stack(
                    children: [
                      if (showLike)
                        Align(
                          alignment: const Alignment(0.0, -0.05),
                          child: _FadeIn(
                            visible: likeVisible,
                            child: IconButton(
                              onPressed: onLike,
                              icon: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 200),
                                transitionBuilder: (child, animation) =>
                                    ScaleTransition(
                                        scale: animation, child: child),
                                child: _HeartBeat(
                                  key: ValueKey(liked),
                                  enabled: pulseLike && !liked,
                                  child: Icon(
                                    liked
                                        ? Icons.favorite_rounded
                                        : Icons.favorite_border_rounded,
                                    color: look.text,
                                    size: 32.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Double flèche vers le bas en traits fins.
class _ThinChevronsPainter extends CustomPainter {
  const _ThinChevronsPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final w = size.width;
    final h = size.height;
    for (final top in [h * 0.08, h * 0.45]) {
      canvas.drawPath(
        Path()
          ..moveTo(w * 0.04, top)
          ..lineTo(w * 0.5, top + h * 0.42)
          ..lineTo(w * 0.96, top),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_ThinChevronsPainter oldDelegate) =>
      oldDelegate.color != color;
}

/// Battement de cœur : deux pulsations rapides puis une pause, en boucle.
class _HeartBeat extends StatelessWidget {
  const _HeartBeat({super.key, required this.enabled, required this.child});

  final bool enabled;
  final Widget child;

  static double _scaleAt(double t) {
    // Sur un cycle de 1,4 s : pulsation forte, pulsation légère, repos.
    double pulse(double start, double length, double amplitude) {
      if (t < start || t > start + length) {
        return 0.0;
      }
      final x = (t - start) / length;
      return amplitude * sin(pi * x);
    }

    return 1.0 + pulse(0.0, 0.18, 0.22) + pulse(0.2, 0.16, 0.12);
  }

  @override
  Widget build(BuildContext context) {
    if (!enabled) {
      return child;
    }
    return child.animate(onPlay: (controller) => controller.repeat()).custom(
          duration: 1400.ms,
          builder: (context, value, child) =>
              Transform.scale(scale: _scaleAt(value), child: child),
        );
  }
}

/// Apparition et disparition en fondu ; invisible, l'élément ne réagit pas
/// au toucher.
class _FadeIn extends StatelessWidget {
  const _FadeIn({required this.visible, required this.child});

  final bool visible;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !visible,
      child: AnimatedOpacity(
        opacity: visible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 900),
        curve: Curves.easeInOut,
        child: child,
      ),
    );
  }
}

/// Animation du cœur au like, recolorée avec la couleur du texte de
/// l'affirmation (quel que soit le thème).
class _LikeBurst extends StatelessWidget {
  const _LikeBurst({super.key, required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      'assets/jsons/Like.json',
      width: 150.0,
      height: 150.0,
      repeat: false,
      delegates: LottieDelegates(
        values: [
          ValueDelegate.color(const ['**'], value: color),
          ValueDelegate.strokeColor(const ['**'], value: color),
        ],
      ),
    );
  }
}

class _EmptyFeed extends StatelessWidget {
  const _EmptyFeed({required this.look, required this.text});

  final _ThemeLook look;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(color: look.text, fontSize: 15.0),
        ),
      ),
    );
  }
}

/// Couleurs, police et fond de la page selon le thème choisi par
/// l'utilisateur (`currentheme`, voir `lib/components/app_themes.dart`).
class _ThemeLook {
  const _ThemeLook({
    required this.background,
    required this.decoration,
    required this.text,
    required this.affirmationStyle,
  });

  final Color background;
  final BoxDecoration decoration;
  final Color text;
  final TextStyle affirmationStyle;

  /// Taille des affirmations (police Motter Corpus ; les autres polices
  /// sont ajustées dans `PhilTheme.textStyle`).
  static const double affirmationSize = 20.0;

  factory _ThemeLook.of(BuildContext context) {
    final theme =
        philThemeById(valueOrDefault(currentUserDocument?.currentheme, ''));
    return _ThemeLook(
      background: theme.color ??
          theme.gradient?.first ??
          FlutterFlowTheme.of(context).primary,
      decoration: theme.decoration(),
      text: theme.textColor,
      affirmationStyle: theme.textStyle(affirmationSize),
    );
  }
}
