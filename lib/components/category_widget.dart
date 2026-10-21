import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/components/category_meta.dart';
import '/components/paypaycompo_widget.dart';
import '/components/paywall_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/revenue_cat_util.dart' as revenue_cat;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'category_model.dart';
export 'category_model.dart';

/// Feuille « Catégories » : toucher une catégorie la coche ou la décoche.
/// Les catégories cochées alimentent le fil « Pour toi » de la page
/// principale (champ `selectedCategories` du compte).
class CategoryWidget extends StatefulWidget {
  const CategoryWidget({super.key});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  late CategoryModel _model;

  /// Sélection affichée, mise à jour tout de suite au toucher.
  late Set<Category> _selected;

  bool get _isPremium =>
      revenue_cat.activeEntitlementIds.contains('accespremium');

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CategoryModel());
    final stored = (currentUserDocument?.selectedCategories ?? const [])
        .map(deserializeEnum<Category>)
        .whereType<Category>()
        .toSet();
    _selected = stored.isEmpty ? kDefaultCategories.toSet() : stored;
  }

  @override
  void dispose() {
    _model.maybeDispose();
    super.dispose();
  }

  Future<void> _openPaywall(Widget paywall, {bool closeFirst = false}) async {
    if (closeFirst) {
      Navigator.pop(context);
    }
    await showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      enableDrag: false,
      context: context,
      builder: (context) => Padding(
        padding: MediaQuery.viewInsetsOf(context),
        child: paywall,
      ),
    );
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _toggle(CategoryMeta meta) async {
    if (meta.premium && !_isPremium) {
      await _openPaywall(PaypaycompoWidget());
      return;
    }
    final selected = {..._selected};
    if (!selected.remove(meta.category)) {
      selected.add(meta.category);
    }
    // Au moins une catégorie reste cochée, sinon le fil serait vide.
    if (selected.isEmpty) {
      HapticFeedback.heavyImpact();
      return;
    }
    HapticFeedback.selectionClick();
    setState(() => _selected = selected);
    await currentUserReference!.update({
      'selectedCategories': selected.map((c) => c.serialize()).toList(),
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final columns = MediaQuery.sizeOf(context).width > 600 ? 3 : 2;
    final topInset = MediaQueryData.fromView(View.of(context)).padding.top;

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: theme.primary,
      child: SafeArea(
        // La feuille modale retire la marge du haut de MediaQuery : on reprend
        // celle de l'écran pour passer sous l'heure et la Dynamic Island.
        top: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16.0, topInset + 8.0, 16.0, 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close_rounded,
                        color: theme.secondary, size: 28.0),
                  ),
                  const SizedBox(width: 12.0),
                  Text(
                    'Catégories',
                    style: TextStyle(
                      fontFamily: 'Motter Corpus',
                      color: theme.secondary,
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              if (!_isPremium) ...[
                _PremiumBanner(
                  onTap: () => _openPaywall(PaywallWidget(), closeFirst: true),
                ),
                const SizedBox(height: 16.0),
              ],
              _ShadowCard(
                onTap: () => context.pushNamed(SwipePageOwnWidget.routeName),
                child: SizedBox(
                  height: 90.0,
                  child: Row(
                    children: [
                      const SizedBox(width: 20.0),
                      Expanded(
                        child: Text(
                          'Mes manifestations',
                          style: GoogleFonts.poppins(
                            color: theme.secondary,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Image.asset(
                        'assets/images/Untitled_design_-_2026-05-19T152640.565.png',
                        width: 90.0,
                        height: 90.0,
                      ),
                      const SizedBox(width: 12.0),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Coche les catégories de ton fil « Pour toi »',
                  style: GoogleFonts.poppins(
                    color: theme.secondaryText,
                    fontSize: 12.0,
                  ),
                ),
              ),
              GridView.count(
                crossAxisCount: columns,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.only(right: 5.0, bottom: 5.0),
                children: [
                  _CategoryCard(
                    label: kCategories.first.label,
                    image: kCategories.first.image,
                    selected: _selected.contains(kCategories.first.category),
                    onTap: () => _toggle(kCategories.first),
                  ),
                  _CategoryCard(
                    label: kFavoritesLabel,
                    image: kFavoritesImage,
                    onTap: () => Navigator.pop(context, kOpenFavoritesResult),
                  ),
                  for (final meta in kCategories.skip(1))
                    _CategoryCard(
                      label: meta.label,
                      image: meta.image,
                      selected: _selected.contains(meta.category),
                      locked: meta.premium && !_isPremium,
                      onTap: () => _toggle(meta),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PremiumBanner extends StatelessWidget {
  const _PremiumBanner({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120.0,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [const Color(0xFF542A18), theme.secondary],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(24.0),
          boxShadow: const [
            BoxShadow(
                blurRadius: 8.0,
                color: Color(0x33000000),
                offset: Offset(0.0, 2.0)),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Débloque toutes les catégories',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Accède aux affirmations premium',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 11.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                color: const Color(0x4DFFFFFF),
                borderRadius: BorderRadius.circular(20.0),
              ),
              alignment: Alignment.center,
              child: const FaIcon(FontAwesomeIcons.crown,
                  color: Colors.white, size: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}

/// Carte blanche avec bordure et ombre pleine décalée, style de l'app.
class _ShadowCard extends StatelessWidget {
  const _ShadowCard({
    required this.onTap,
    required this.child,
    this.radius = 24.0,
    this.color = Colors.white,
  });

  final VoidCallback onTap;
  final Widget child;
  final double radius;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(color: theme.secondary, width: 2.0),
          boxShadow: [
            BoxShadow(color: theme.secondary, offset: const Offset(5.0, 4.0)),
          ],
        ),
        child: child,
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({
    required this.label,
    required this.image,
    required this.onTap,
    this.selected,
    this.locked = false,
  });

  final String label;
  final String image;
  final VoidCallback onTap;

  /// `null` : carte sans sélection (ex. « Mes favoris »).
  final bool? selected;
  final bool locked;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final isSelected = selected == true;

    return _ShadowCard(
      onTap: onTap,
      radius: 32.0,
      color: isSelected ? const Color(0xFFFFF6F3) : Colors.white,
      child: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(image, width: 80.0, height: 80.0),
                  const SizedBox(height: 8.0),
                  Text(
                    label,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: theme.secondary,
                      fontSize: 13.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (selected != null)
            Positioned(
              top: 12.0,
              left: 12.0,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 22.0,
                height: 22.0,
                decoration: BoxDecoration(
                  color: isSelected ? theme.secondary : Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected
                        ? theme.secondary
                        : theme.secondary.withValues(alpha: 0.35),
                    width: 1.5,
                  ),
                ),
                child: isSelected
                    ? const Icon(Icons.check_rounded,
                        color: Colors.white, size: 15.0)
                    : null,
              ),
            ),
          if (locked)
            const Positioned(
              top: 14.0,
              right: 14.0,
              child: FaIcon(FontAwesomeIcons.crown,
                  color: Color(0xFFE2AB85), size: 15.0),
            ),
        ],
      ),
    );
  }
}
