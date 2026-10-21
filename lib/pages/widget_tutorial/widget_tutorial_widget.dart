import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Tutoriel « Comment installer le widget » en 4 étapes (iPhone).
class WidgetTutorialWidget extends StatelessWidget {
  const WidgetTutorialWidget({super.key});

  static String routeName = 'widgetTutorial';
  static String routePath = '/widgetTutorial';

  static const _steps = [
    (
      'Allume l\'écran sans le déverrouiller',
      'Une fois que tu as allumé ton iPhone, reste sur l\'écran de '
          'verrouillage.',
      'assets/images/99.png',
    ),
    (
      'Reste appuyé sur l\'écran',
      'Maintiens un appui long jusqu\'à voir le bouton « Personnaliser » '
          'apparaître en bas.',
      'assets/images/49.png',
    ),
    (
      'Appuie sur « Personnaliser » > touche la zone widget',
      'Touche « Personnaliser », puis touche la zone de widget située juste '
          'en dessous de l\'horloge.',
      'assets/images/110.png',
    ),
    (
      'Ajoute le widget « Phil\'O »',
      'Cherche « Phil\'O », choisis la taille, valide avec OK, puis reviens '
          'dans l\'app pour choisir ce que tu veux afficher dans ton widget.',
      'assets/images/120.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);

    return Scaffold(
      backgroundColor: theme.primary,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 32.0),
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () => context.safePop(),
                  child: Icon(Icons.arrow_back_rounded,
                      color: theme.secondary, size: 26.0),
                ),
                Expanded(
                  child: Text(
                    'Comment installer le widget',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: theme.secondary,
                      fontSize: 17.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(width: 26.0),
              ],
            ),
            const SizedBox(height: 20.0),
            Text(
              'Voici comment ajouter le widget Phil\'O à ton écran '
              'verrouillé :',
              style: GoogleFonts.poppins(
                color: theme.secondary,
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16.0),
            for (var i = 0; i < _steps.length; i++)
              Padding(
                padding: const EdgeInsets.only(bottom: 14.0),
                child: _StepCard(
                  number: i + 1,
                  title: _steps[i].$1,
                  description: _steps[i].$2,
                  image: _steps[i].$3,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _StepCard extends StatelessWidget {
  const _StepCard({
    required this.number,
    required this.title,
    required this.description,
    required this.image,
  });

  final int number;
  final String title;
  final String description;
  final String image;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(14.0, 14.0, 10.0, 14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 22.0,
            height: 22.0,
            decoration: BoxDecoration(
              color: theme.secondary,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              '$number',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 12.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    color: theme.secondary,
                    fontSize: 13.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6.0),
                Text(
                  description,
                  style: GoogleFonts.poppins(
                    color: theme.secondaryText,
                    fontSize: 10.5,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8.0),
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.asset(image, width: 70.0, fit: BoxFit.contain),
          ),
        ],
      ),
    );
  }
}
