import '/components/app_themes.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

/// Grille de thèmes en 3 colonnes, utilisée par « Sélectionner un thème » et
/// par l'onboarding.
class ThemeGrid extends StatelessWidget {
  const ThemeGrid({
    super.key,
    required this.themes,
    required this.selectedId,
    required this.isPremium,
    required this.onSelect,
    this.padding = EdgeInsets.zero,
    this.shrinkWrap = false,
  });

  final List<PhilTheme> themes;
  final String selectedId;
  final bool isPremium;
  final ValueChanged<PhilTheme> onSelect;
  final EdgeInsets padding;

  /// Grille dans une autre zone de défilement (onboarding).
  final bool shrinkWrap;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: padding,
      shrinkWrap: shrinkWrap,
      physics: shrinkWrap ? const NeverScrollableScrollPhysics() : null,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        childAspectRatio: 0.62,
      ),
      itemCount: themes.length,
      itemBuilder: (context, index) {
        final theme = themes[index];
        return ThemeCard(
          theme: theme,
          selected: theme.id == selectedId,
          locked: !theme.free && !isPremium,
          showFreeBadge: theme.free && !isPremium,
          onTap: () => onSelect(theme),
        );
      },
    );
  }
}

/// Aperçu d'un thème : son fond, une affirmation dans sa police et sa
/// couleur, et le cœur du fil.
class ThemeCard extends StatelessWidget {
  const ThemeCard({
    super.key,
    required this.theme,
    required this.selected,
    required this.locked,
    required this.showFreeBadge,
    required this.onTap,
  });

  final PhilTheme theme;
  final bool selected;
  final bool locked;
  final bool showFreeBadge;
  final VoidCallback onTap;

  static const _radius = 16.0;

  @override
  Widget build(BuildContext context) {
    final app = FlutterFlowTheme.of(context);

    Widget badge(String label) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.92),
            borderRadius: BorderRadius.circular(100.0),
          ),
          child: Text(
            label,
            style: GoogleFonts.poppins(
              color: app.secondary,
              fontSize: 10.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        );

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(selected ? 2.5 : 1.0),
        decoration: BoxDecoration(
          color: selected ? app.secondary : const Color(0xFFE3D6D2),
          borderRadius: BorderRadius.circular(_radius),
        ),
        child: Container(
          decoration: theme.decoration(
            borderRadius: BorderRadius.circular(_radius - 1.0),
          ),
          child: Stack(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'Phil\'O',
                    textAlign: TextAlign.center,
                    style: theme.textStyle(15.0),
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(0.0, 0.72),
                child: Icon(
                  Icons.favorite_border_rounded,
                  color: theme.textColor,
                  size: 20.0,
                ),
              ),
              if (selected)
                Positioned(
                  top: 8.0,
                  left: 8.0,
                  child: Container(
                    width: 22.0,
                    height: 22.0,
                    decoration: BoxDecoration(
                      color: app.secondary,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1.5),
                    ),
                    child: const Icon(Icons.check_rounded,
                        color: Colors.white, size: 14.0),
                  ),
                )
              else if (theme.isNew)
                Positioned(top: 8.0, left: 8.0, child: badge('Nouveau')),
              if (locked)
                Positioned(
                  top: 8.0,
                  right: 8.0,
                  child: Container(
                    width: 24.0,
                    height: 24.0,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.92),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: const FaIcon(FontAwesomeIcons.crown,
                        color: Color(0xFFE2AB85), size: 11.0),
                  ),
                )
              else if (showFreeBadge)
                Positioned(top: 8.0, right: 8.0, child: badge('Gratuit')),
            ],
          ),
        ),
      ),
    );
  }
}
