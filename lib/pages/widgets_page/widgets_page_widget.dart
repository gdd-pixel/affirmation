import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widget_status.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/widget_tutorial/widget_tutorial_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

/// Page « Widgets » : aperçu de l'affirmation affichée par le widget, état
/// d'installation et choix de la source des affirmations.
///
/// Si le widget n'est pas installé, une pop-up invite à l'installer.
class WidgetsPageWidget extends StatefulWidget {
  const WidgetsPageWidget({super.key});

  static String routeName = 'widgets';
  static String routePath = '/widgets';

  @override
  State<WidgetsPageWidget> createState() => _WidgetsPageWidgetState();
}

class _WidgetSource {
  const _WidgetSource(this.mode, this.title, this.subtitle, this.image);

  final String mode;
  final String title;
  final String subtitle;
  final String image;
}

const _sources = [
  _WidgetSource(
    'general',
    'Affirmations générales',
    'Une sélection positive choisie automatiquement',
    'assets/images/Untitled_design_(58).png',
  ),
  _WidgetSource(
    'favorites',
    'Mes favoris',
    'Affiche les affirmations que tu as aimées',
    'assets/images/Untitled_design_(73).png',
  ),
  _WidgetSource(
    'myAffirmations',
    'Mes manifestations',
    'Affiche les affirmations que tu souhaites manifester',
    'assets/images/Untitled_design_-_2026-05-19T152640.565.png',
  ),
];

class _WidgetsPageWidgetState extends State<WidgetsPageWidget>
    with WidgetsBindingObserver {
  String? _preview;
  bool? _installed;
  String _mode = 'general';
  bool _changing = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    logFirebaseEvent('screen_view', parameters: {'screen_name': 'widgets'});
    final storedMode = valueOrDefault(currentUserDocument?.widgetMode, '');
    if (_sources.any((s) => s.mode == storedMode)) {
      _mode = storedMode;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // L'utilisateur revient souvent de l'écran verrouillé après avoir
    // installé le widget : on met l'état à jour.
    if (state == AppLifecycleState.resumed) {
      _refreshInstalled();
    }
  }

  Future<void> _load() async {
    await actions.syncWidgetContent();
    final preview = await currentWidgetAffirmation();
    final installed = await isAffirmationWidgetInstalled();
    if (!mounted) {
      return;
    }
    setState(() {
      _preview = preview;
      _installed = installed;
    });
    if (installed == false) {
      await _showInstallPopup();
    }
  }

  Future<void> _refreshInstalled() async {
    final installed = await isAffirmationWidgetInstalled();
    if (mounted) {
      setState(() => _installed = installed);
    }
  }

  Future<void> _changeAffirmation() async {
    if (_changing) {
      return;
    }
    setState(() => _changing = true);
    final text = await actions.changeWidgetAffirmation();
    if (!mounted) {
      return;
    }
    setState(() {
      _changing = false;
      if (!text.startsWith('error:')) {
        _preview = text;
      }
    });
  }

  Future<void> _selectSource(String mode) async {
    if (mode == _mode) {
      return;
    }
    HapticFeedback.selectionClick();
    setState(() => _mode = mode);
    await currentUserReference!.update(createUsersRecordData(widgetMode: mode));
    await actions.syncWidgetContent();
    final preview = await currentWidgetAffirmation();
    if (mounted) {
      setState(() => _preview = preview);
    }
  }

  void _openTutorial() {
    context.pushNamed(WidgetTutorialWidget.routeName);
  }

  Future<void> _showInstallPopup() async {
    final install = await showDialog<bool>(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.35),
      builder: (context) => const _InstallWidgetDialog(),
    );
    if (install == true && mounted) {
      _openTutorial();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);

    return Scaffold(
      backgroundColor: theme.primary,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 32.0),
          children: [
            _PageHeader(title: 'Widgets', onBack: () => context.safePop()),
            const SizedBox(height: 18.0),
            const _SectionTitle(
              title: 'En ce moment sur ton widget',
              subtitle:
                  'Voici l\'affirmation qui s\'affichera sur ton écran verrouillé',
            ),
            const SizedBox(height: 16.0),
            Center(
              child: Container(
                width: MediaQuery.sizeOf(context).width * 0.66,
                constraints: const BoxConstraints(minHeight: 90.0),
                padding: const EdgeInsets.all(18.0),
                decoration: BoxDecoration(
                  color: theme.secondary,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                alignment: Alignment.center,
                child: Text(
                  _preview ?? '…',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12.0),
            Center(
              child: GestureDetector(
                onTap: _changeAffirmation,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14.0, vertical: 7.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100.0),
                    border: Border.all(color: const Color(0xFFE3D6D2)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.sync_rounded,
                          size: 15.0, color: theme.secondary),
                      const SizedBox(width: 6.0),
                      Text(
                        'Changer d\'affirmation',
                        style: GoogleFonts.poppins(
                          color: theme.secondary,
                          fontSize: 11.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (_installed != null) ...[
              const SizedBox(height: 28.0),
              _InstallStatusCard(
                installed: _installed!,
                onTap: _installed! ? null : _openTutorial,
              ),
            ],
            const SizedBox(height: 28.0),
            const _SectionTitle(
              title: 'Choisis le contenu de ton widget',
              subtitle: 'Sélectionne la source des affirmations à afficher',
            ),
            const SizedBox(height: 14.0),
            for (final source in _sources)
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: _SourceCard(
                  source: source,
                  selected: source.mode == _mode,
                  onTap: () => _selectSource(source.mode),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _PageHeader extends StatelessWidget {
  const _PageHeader({required this.title, required this.onBack});

  final String title;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final color = FlutterFlowTheme.of(context).secondary;
    return Row(
      children: [
        GestureDetector(
          onTap: onBack,
          child: Icon(Icons.arrow_back_rounded, color: color, size: 26.0),
        ),
        const SizedBox(width: 12.0),
        Text(
          title,
          style: GoogleFonts.poppins(
            color: color,
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            color: theme.secondary,
            fontSize: 15.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          subtitle,
          style: GoogleFonts.poppins(
            color: theme.secondaryText,
            fontSize: 11.0,
          ),
        ),
      ],
    );
  }
}

/// Carte d'état : « widget pas encore installé » ou « Widget installé ».
class _InstallStatusCard extends StatelessWidget {
  const _InstallStatusCard({required this.installed, this.onTap});

  final bool installed;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16.0, 14.0, 16.0, 0.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: const Color(0xFFE3D6D2)),
        ),
        // Le texte est centré verticalement dans la carte, l'illustration reste
        // posée sur le bord bas.
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const LockScreenIllustration(width: 110.0, cropped: true),
                    Positioned(
                      right: -10.0,
                      top: -8.0,
                      child: Icon(
                        installed
                            ? Icons.check_circle_rounded
                            : Icons.warning_rounded,
                        color: installed
                            ? const Color(0xFF67B547)
                            : theme.secondary,
                        size: 22.0,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  // Compense la marge du haut de la carte (14) pour être centré
                  // sur toute sa hauteur.
                  padding: const EdgeInsets.only(bottom: 14.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        installed
                            ? 'Widget installé'
                            : 'widget pas\nencore installé',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          color: theme.secondary,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                          height: 1.25,
                        ),
                      ),
                      if (!installed)
                        Text(
                          'Voir comment l\'installer',
                          style: GoogleFonts.poppins(
                            color: theme.tertiary,
                            fontSize: 11.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SourceCard extends StatelessWidget {
  const _SourceCard({
    required this.source,
    required this.selected,
    required this.onTap,
  });

  final _WidgetSource source;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: selected ? theme.secondary : const Color(0xFFE3D6D2),
            width: selected ? 1.5 : 1.0,
          ),
        ),
        child: Row(
          children: [
            Image.asset(source.image, width: 46.0, height: 46.0),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    source.title,
                    style: GoogleFonts.poppins(
                      color: theme.secondary,
                      fontSize: 13.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    source.subtitle,
                    style: GoogleFonts.poppins(
                      color: theme.secondaryText,
                      fontSize: 10.0,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              selected
                  ? Icons.radio_button_checked_rounded
                  : Icons.radio_button_unchecked_rounded,
              color: theme.secondary,
              size: 22.0,
            ),
          ],
        ),
      ),
    );
  }
}

/// Pop-up qui invite à installer le widget. Renvoie `true` si l'utilisateur
/// choisit « Installer le widget ».
class _InstallWidgetDialog extends StatelessWidget {
  const _InstallWidgetDialog();

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 22.0),
      child: Container(
        padding: const EdgeInsets.fromLTRB(26.0, 22.0, 26.0, 18.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(26.0),
          boxShadow: const [
            BoxShadow(color: Color(0x33473026), offset: Offset(6.0, 6.0)),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/Untitled_design_(58).png',
              width: 46.0,
              height: 46.0,
            ),
            const LockScreenIllustration(width: 150.0, cropped: true),
            const SizedBox(height: 18.0),
            Text(
              'Installe ton widget sur ton écran de verrouillage',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: theme.secondary,
                fontSize: 17.0,
                fontWeight: FontWeight.w800,
                height: 1.25,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              'Suis les étapes pour installer le widget et recevoir des '
              'affirmations et tes manifestations personnalisées',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: theme.secondaryText,
                fontSize: 11.0,
                height: 1.45,
              ),
            ),
            const SizedBox(height: 18.0),
            SizedBox(
              width: double.infinity,
              height: 46.0,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.secondary,
                  elevation: 0,
                  shape: const StadiumBorder(),
                ),
                child: Text(
                  'Installer le widget',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(
                'plus tard',
                style: GoogleFonts.poppins(
                  color: theme.secondaryText,
                  fontSize: 12.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Haut d'un iPhone en écran verrouillé, avec l'heure et un widget.
class LockScreenIllustration extends StatelessWidget {
  const LockScreenIllustration({
    super.key,
    required this.width,
    this.cropped = false,
  });

  final double width;

  /// Sans bord inférieur : seul le haut du téléphone est dessiné.
  final bool cropped;

  @override
  Widget build(BuildContext context) {
    final color = FlutterFlowTheme.of(context).secondary;
    final stroke = width * 0.028;
    final side = BorderSide(color: color, width: stroke);
    return Container(
      width: width,
      padding: EdgeInsets.fromLTRB(
          width * 0.1, width * 0.07, width * 0.1, width * 0.08),
      decoration: BoxDecoration(
        border: cropped
            ? Border(top: side, left: side, right: side)
            : Border.fromBorderSide(side),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(width * 0.2),
          bottom: Radius.circular(cropped ? 0 : width * 0.2),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: width * 0.24,
            height: width * 0.05,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(100.0),
            ),
          ),
          SizedBox(height: width * 0.05),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              '13 : 00',
              style: GoogleFonts.poppins(
                color: color,
                fontSize: width * 0.2,
                fontWeight: FontWeight.w800,
                height: 1.0,
              ),
            ),
          ),
          SizedBox(height: width * 0.06),
          Container(
            width: double.infinity,
            height: width * 0.17,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(width * 0.05),
            ),
            alignment: Alignment.center,
            child: Icon(
              Icons.add_circle_rounded,
              color: Colors.white,
              size: width * 0.09,
            ),
          ),
        ],
      ),
    );
  }
}
