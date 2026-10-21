import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Barre de navigation de la page principale : Accueil, Catégories,
/// Je manifeste, Widgets.
class PhilNavBar extends StatelessWidget {
  const PhilNavBar({
    super.key,
    required this.onHome,
    required this.onCategories,
    required this.onManifest,
    required this.onWidgets,
    this.labelColor,
  });

  /// Couleur des libellés sous les boutons (par défaut le marron de l'app).
  final Color? labelColor;

  final VoidCallback onHome;
  final VoidCallback onCategories;
  final VoidCallback onManifest;
  final VoidCallback onWidgets;

  static const double buttonSize = 54.0;

  /// Marge de côté de la barre. La barre est découpée en 4 colonnes de même
  /// largeur : le bouton profil, en haut, utilise la même grille pour être
  /// aligné sur le bouton Widgets.
  static const double horizontalPadding = 8.0;
  static const int columns = 4;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Row(
        children: [
          for (final item in [
            _NavItem(
                destination: PhilNavDestination.home,
                label: 'Accueil',
                onTap: onHome,
                labelColor: labelColor),
            _NavItem(
                destination: PhilNavDestination.categories,
                label: 'Catégories',
                onTap: onCategories,
                labelColor: labelColor),
            _NavItem(
                destination: PhilNavDestination.manifest,
                label: 'Je manifeste',
                onTap: onManifest,
                labelColor: labelColor),
            _NavItem(
                destination: PhilNavDestination.widgets,
                label: 'Widgets',
                onTap: onWidgets,
                labelColor: labelColor),
          ])
            Expanded(child: Center(child: item)),
        ],
      ),
    );
  }
}

enum PhilNavDestination { home, categories, manifest, widgets }

/// Bouton rond de la barre de navigation, avec son icône.
class PhilNavButton extends StatelessWidget {
  const PhilNavButton({
    super.key,
    required this.destination,
    this.size = PhilNavBar.buttonSize,
  });

  final PhilNavDestination destination;
  final double size;

  @override
  Widget build(BuildContext context) {
    final color = FlutterFlowTheme.of(context).secondary;
    final scale = size / PhilNavBar.buttonSize;
    switch (destination) {
      case PhilNavDestination.home:
        return NavRoundButton(
          size: size,
          child: Icon(Icons.home_rounded, color: color, size: 30.0 * scale),
        );
      case PhilNavDestination.categories:
        return NavRoundButton(
          size: size,
          child: Transform.scale(scale: scale, child: _GridIcon(color: color)),
        );
      case PhilNavDestination.manifest:
        return NavRoundButton(
          size: size,
          child: Transform.translate(
            offset: Offset(0.0, -1.5 * scale),
            child: CustomPaint(
              size: Size.square(29.0 * scale),
              painter: _ManifestIconPainter(color),
            ),
          ),
        );
      case PhilNavDestination.widgets:
        return NavRoundButton(
          size: size,
          clip: true,
          child: PhoneWidgetIcon(color: color, size: size),
        );
    }
  }
}

/// Bouton rond blanc, contour marron et ombre pleine en bas à droite.
class NavRoundButton extends StatelessWidget {
  const NavRoundButton({
    super.key,
    required this.size,
    required this.child,
    this.clip = false,
  });

  final double size;
  final Widget child;

  /// Coupe le contenu au cercle (icône qui touche le bord).
  final bool clip;

  @override
  Widget build(BuildContext context) {
    final color = FlutterFlowTheme.of(context).secondary;
    final border = size * 0.045;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: color, width: border),
        boxShadow: [
          BoxShadow(color: color, offset: Offset(size * 0.07, size * 0.06)),
        ],
      ),
      child: clip ? ClipOval(child: child) : Center(child: child),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.destination,
    required this.label,
    required this.onTap,
    this.labelColor,
  });

  final PhilNavDestination destination;
  final String label;
  final VoidCallback onTap;
  final Color? labelColor;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PhilNavButton(destination: destination),
          const SizedBox(height: 6.0),
          Text(
            label,
            style: GoogleFonts.poppins(
              color: labelColor ?? theme.secondary,
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    );
  }
}

/// Icône « Je manifeste » : carré arrondi ouvert en haut à droite, d'où
/// sort un crayon en diagonale.
class _ManifestIconPainter extends CustomPainter {
  const _ManifestIconPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width;
    final stroke = s * 0.09;

    // Carré : tracé au milieu du trait, ouvert dans le coin haut droit.
    const left = 0.065, top = 0.205, right = 0.795, bottom = 0.905;
    const r = 0.13;
    final square = Path()
      ..moveTo(0.45 * s, top * s)
      ..lineTo((left + r) * s, top * s)
      ..arcToPoint(Offset(left * s, (top + r) * s),
          radius: Radius.circular(r * s), clockwise: false)
      ..lineTo(left * s, (bottom - r) * s)
      ..arcToPoint(Offset((left + r) * s, bottom * s),
          radius: Radius.circular(r * s), clockwise: false)
      ..lineTo((right - r) * s, bottom * s)
      ..arcToPoint(Offset(right * s, (bottom - r) * s),
          radius: Radius.circular(r * s), clockwise: false)
      ..lineTo(right * s, 0.52 * s);
    canvas.drawPath(
      square,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = stroke
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );

    // Crayon : repère local avec x le long du crayon (0 = pointe).
    const tip = Offset(0.26, 0.74);
    const end = Offset(0.98, 0.03);
    final axis = (end - tip) * s;
    final length = axis.distance;
    final half = s * 0.095;
    canvas.save();
    canvas.translate(tip.dx * s, tip.dy * s);
    canvas.rotate(axis.direction);

    final fill = Paint()..color = color;
    final white = Paint()..color = Colors.white;
    final cone = length * 0.25;

    // Pointe : triangle marron, bois blanc à l'intérieur, mine marron.
    canvas.drawPath(
      Path()
        ..moveTo(0, 0)
        ..lineTo(cone, -half)
        ..lineTo(cone, half)
        ..close(),
      fill,
    );
    final inset = stroke * 0.55;
    canvas.drawPath(
      Path()
        ..moveTo(length * 0.08, 0)
        ..lineTo(cone - inset * 0.3, -half + inset)
        ..lineTo(cone - inset * 0.3, half - inset)
        ..close(),
      white,
    );
    canvas.drawPath(
      Path()
        ..moveTo(length * 0.08, 0)
        ..lineTo(length * 0.13, -half * 0.22)
        ..lineTo(length * 0.13, half * 0.22)
        ..close(),
      fill,
    );

    // Corps, trait blanc, gomme arrondie.
    canvas.drawRect(
        Rect.fromLTRB(cone - 0.5, -half, length * 0.82, half), fill);
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTRB(length * 0.86, -half, length, half),
        topRight: Radius.circular(half * 0.7),
        bottomRight: Radius.circular(half * 0.7),
      ),
      fill,
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(_ManifestIconPainter oldDelegate) =>
      oldDelegate.color != color;
}

/// Quatre carrés pleins aux coins arrondis.
class _GridIcon extends StatelessWidget {
  const _GridIcon({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    Widget square() => Container(
          width: 11.0,
          height: 11.0,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3.5),
          ),
        );
    Widget row() => Row(
          mainAxisSize: MainAxisSize.min,
          children: [square(), const SizedBox(width: 3.0), square()],
        );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [row(), const SizedBox(height: 3.0), row()],
    );
  }
}

/// Haut d'un téléphone en écran verrouillé (encoche, « 13:00 » et widget),
/// qui descend jusqu'au bord du bouton rond.
class PhoneWidgetIcon extends StatelessWidget {
  const PhoneWidgetIcon({super.key, required this.color, required this.size});

  final Color color;

  /// Diamètre du bouton qui contient l'icône.
  final double size;

  @override
  Widget build(BuildContext context) {
    final phoneWidth = size * 0.66;
    final stroke = size * 0.035;
    final side = BorderSide(color: color, width: stroke);

    // Taille fixe : le dessin ne dépend pas de l'espace donné par le parent.
    return SizedBox.square(
      dimension: size,
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Positioned(
            left: (size - phoneWidth) / 2 - size * 0.045,
            top: size * 0.13,
            width: phoneWidth,
            // Dépasse en bas : le cercle coupe le téléphone.
            height: size,
            child: Container(
              padding: EdgeInsets.fromLTRB(
                  phoneWidth * 0.1, phoneWidth * 0.07, phoneWidth * 0.1, 0.0),
              decoration: BoxDecoration(
                border: Border(top: side, left: side, right: side),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(phoneWidth * 0.24),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: phoneWidth * 0.2,
                    height: stroke,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                  ),
                  SizedBox(height: phoneWidth * 0.05),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      '13 : 00',
                      style: GoogleFonts.poppins(
                        color: color,
                        fontSize: phoneWidth * 0.2,
                        fontWeight: FontWeight.w700,
                        height: 1.0,
                      ),
                    ),
                  ),
                  SizedBox(height: phoneWidth * 0.06),
                  Container(
                    width: double.infinity,
                    height: phoneWidth * 0.22,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(phoneWidth * 0.06),
                    ),
                    alignment: Alignment.center,
                    child: Container(
                      width: phoneWidth * 0.09,
                      height: phoneWidth * 0.09,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: Colors.white, width: phoneWidth * 0.02),
                      ),
                      alignment: Alignment.center,
                      child: Container(
                        width: phoneWidth * 0.03,
                        height: phoneWidth * 0.03,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
