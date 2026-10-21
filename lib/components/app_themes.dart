import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Familles de thèmes, utilisées comme filtres dans « Sélectionner un thème ».
enum ThemeFamily { nouveau, nature, colore, minimal }

const kThemeFamilyLabels = {
  ThemeFamily.nouveau: 'Nouveau',
  ThemeFamily.nature: 'Nature',
  ThemeFamily.colore: 'Coloré',
  ThemeFamily.minimal: 'Minimal',
};

/// Police des affirmations d'un thème.
enum ThemeFont { motter, lilita, abril, bellota }

/// Thème de la page principale : fond, couleur et police des affirmations.
///
/// `id` est la valeur enregistrée dans `users.currentheme`.
class PhilTheme {
  const PhilTheme({
    required this.id,
    required this.name,
    required this.families,
    required this.textColor,
    this.image,
    this.gradient,
    this.color,
    this.font = ThemeFont.motter,
    this.free = false,
  });

  final String id;
  final String name;
  final Set<ThemeFamily> families;

  /// Couleur du texte des affirmations, des libellés et du cœur.
  final Color textColor;

  /// Fond : une image, un dégradé ou une couleur unie.
  final String? image;
  final List<Color>? gradient;
  final Color? color;

  final ThemeFont font;

  /// Accessible sans abonnement.
  final bool free;

  bool get isNew => families.contains(ThemeFamily.nouveau);

  /// Texte clair sur fond sombre (valeur `darkmode` du compte).
  bool get isDark => textColor.computeLuminance() > 0.5;

  /// Décoration de fond, à utiliser en plein écran comme en miniature.
  BoxDecoration decoration({BorderRadius? borderRadius}) => BoxDecoration(
        color: color,
        borderRadius: borderRadius,
        gradient: gradient == null
            ? null
            : LinearGradient(
                colors: gradient!,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
        image: image == null
            ? null
            : DecorationImage(image: AssetImage(image!), fit: BoxFit.cover),
      );

  /// Style des affirmations pour une taille donnée.
  TextStyle textStyle(double fontSize) =>
      _baseTextStyle(fontSize).copyWith(shadows: _shadows);

  /// Sur les photos, une ombre douce garde le texte lisible.
  List<Shadow>? get _shadows => image == null
      ? null
      : [
          Shadow(
            color: Colors.black.withValues(alpha: isDark ? 0.35 : 0.12),
            blurRadius: 14.0,
          ),
        ];

  TextStyle _baseTextStyle(double fontSize) {
    switch (font) {
      case ThemeFont.lilita:
        return GoogleFonts.lilitaOne(
            color: textColor, fontSize: fontSize + 2.0);
      case ThemeFont.abril:
        return GoogleFonts.abrilFatface(
            color: textColor, fontSize: fontSize - 1.0);
      case ThemeFont.bellota:
        return GoogleFonts.bellota(
          color: textColor,
          fontSize: fontSize + 1.0,
          fontWeight: FontWeight.w900,
        );
      case ThemeFont.motter:
        return TextStyle(
          fontFamily: 'Motter Corpus',
          color: textColor,
          fontSize: fontSize,
          height: 1.25,
        );
    }
  }
}

const _brown = Color(0xFF473026);
const _cream = Color(0xFFFFF1EF);
const _white = Color(0xFFFFFFFF);
const _plum = Color(0xFF370924);
const _forest = Color(0xFF14301D);

/// Tous les thèmes, dans l'ordre d'affichage.
const kPhilThemes = <PhilTheme>[
  // Thèmes de base, gratuits.
  PhilTheme(
    id: 'base1',
    name: 'Crème',
    families: {ThemeFamily.minimal},
    color: _cream,
    textColor: _brown,
    free: true,
  ),
  PhilTheme(
    id: 'base2',
    name: 'Cacao',
    families: {ThemeFamily.minimal},
    color: _brown,
    textColor: _cream,
    free: true,
  ),

  // Nouveaux dégradés, dans les teintes de l'app.
  PhilTheme(
    id: 'peche',
    name: 'Pêche',
    families: {ThemeFamily.nouveau, ThemeFamily.colore},
    gradient: [Color(0xFFFFEDE4), Color(0xFFF8C9AE), Color(0xFFEFA584)],
    textColor: _brown,
  ),
  PhilTheme(
    id: 'aube',
    name: 'Aube',
    families: {ThemeFamily.nouveau, ThemeFamily.colore},
    gradient: [Color(0xFFFFF3EE), Color(0xFFF6D3DC), Color(0xFFD4DDF0)],
    textColor: _brown,
  ),
  PhilTheme(
    id: 'lavande',
    name: 'Lavande',
    families: {ThemeFamily.nouveau, ThemeFamily.colore},
    gradient: [Color(0xFFF6EEF8), Color(0xFFDCCBEA), Color(0xFFB9A3D6)],
    textColor: Color(0xFF3A2747),
  ),
  PhilTheme(
    id: 'terracotta',
    name: 'Terracotta',
    families: {ThemeFamily.nouveau, ThemeFamily.colore},
    gradient: [Color(0xFFEEA27E), Color(0xFFC96B4A), Color(0xFF8E4430)],
    textColor: _white,
  ),
  PhilTheme(
    id: 'sable',
    name: 'Sable',
    families: {ThemeFamily.nouveau, ThemeFamily.minimal},
    gradient: [Color(0xFFFAF4EC), Color(0xFFEBDCCB), Color(0xFFD9C2A7)],
    textColor: _brown,
  ),
  PhilTheme(
    id: 'nuit',
    name: 'Nuit',
    families: {ThemeFamily.nouveau, ThemeFamily.minimal},
    gradient: [Color(0xFF5A4036), Color(0xFF2E201B), Color(0xFF17100D)],
    textColor: _cream,
  ),

  // Photos.
  PhilTheme(
    id: 'beach',
    name: 'Plage',
    families: {ThemeFamily.nature},
    image: 'assets/images/themes/beach.jpg',
    textColor: _white,
  ),
  PhilTheme(
    id: 'lac',
    name: 'Horizon',
    families: {ThemeFamily.nature},
    image: 'assets/images/themes/lac.jpg',
    textColor: _white,
  ),
  PhilTheme(
    id: 'nuage',
    name: 'Nuages',
    families: {ThemeFamily.nature},
    image: 'assets/images/themes/nuage.jpg',
    textColor: _white,
    font: ThemeFont.bellota,
  ),
  PhilTheme(
    id: 'nuagerose',
    name: 'Ciel rose',
    families: {ThemeFamily.nature, ThemeFamily.colore},
    image: 'assets/images/themes/nuagerose.jpg',
    textColor: _white,
  ),
  PhilTheme(
    id: 'ble',
    name: 'Blé',
    families: {ThemeFamily.nature, ThemeFamily.minimal},
    image: 'assets/images/themes/ble.jpg',
    textColor: _forest,
    font: ThemeFont.abril,
  ),
  PhilTheme(
    id: 'canyon',
    name: 'Canyon',
    families: {ThemeFamily.nature},
    image: 'assets/images/themes/canyon.jpg',
    textColor: _white,
    font: ThemeFont.bellota,
  ),
  PhilTheme(
    id: 'fall',
    name: 'Automne',
    families: {ThemeFamily.nature},
    image: 'assets/images/themes/fall.jpg',
    textColor: _white,
    font: ThemeFont.abril,
  ),
  PhilTheme(
    id: 'soir',
    name: 'Nuit étoilée',
    families: {ThemeFamily.nature},
    image: 'assets/images/themes/soir.jpg',
    textColor: _white,
    font: ThemeFont.lilita,
  ),
  PhilTheme(
    id: 'fleur',
    name: 'Marguerites',
    families: {ThemeFamily.colore, ThemeFamily.nature},
    image: 'assets/images/themes/fleur.jpg',
    textColor: _plum,
    font: ThemeFont.abril,
  ),
  PhilTheme(
    id: 'palmier',
    name: 'Palmier',
    families: {ThemeFamily.colore},
    image: 'assets/images/themes/palmier.jpg',
    textColor: _white,
    font: ThemeFont.bellota,
  ),
  PhilTheme(
    id: 'abstrait1',
    name: 'Pétale',
    families: {ThemeFamily.colore, ThemeFamily.minimal},
    image: 'assets/images/themes/abstrait1.jpg',
    textColor: _plum,
    font: ThemeFont.lilita,
  ),
  PhilTheme(
    id: 'abstrait2',
    name: 'Aura',
    families: {ThemeFamily.colore, ThemeFamily.minimal},
    image: 'assets/images/themes/abstrait2.jpg',
    textColor: _plum,
    font: ThemeFont.lilita,
  ),
];

/// Thème enregistré sur le compte, ou le thème « Crème » par défaut.
PhilTheme philThemeById(String? id) => kPhilThemes.firstWhere(
      (theme) => theme.id == id,
      orElse: () => kPhilThemes.first,
    );
