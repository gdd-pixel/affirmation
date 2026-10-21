import 'dart:async';

import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

/// Carte « Bravo {prénom} ! » affichée à la fin de l'exercice de respiration
/// de l'onboarding : feux d'artifice, mascotte en méditation et message.
/// La carte entre en douceur, puis les feux d'artifice démarrent 1 s après.
class BreathingCelebrationWidget extends StatefulWidget {
  const BreathingCelebrationWidget({super.key, required this.prenom});

  final String prenom;

  static const fireworksDelay = Duration(milliseconds: 1000);

  @override
  State<BreathingCelebrationWidget> createState() =>
      _BreathingCelebrationWidgetState();
}

class _BreathingCelebrationWidgetState
    extends State<BreathingCelebrationWidget> {
  bool _showFireworks = false;
  Timer? _fireworksTimer;

  @override
  void initState() {
    super.initState();
    // Le Lottie n'est ajouté qu'au bout du délai, pour qu'il démarre au
    // début de son animation.
    _fireworksTimer = Timer(BreathingCelebrationWidget.fireworksDelay, () {
      if (mounted) {
        setState(() => _showFireworks = true);
      }
    });
  }

  @override
  void dispose() {
    _fireworksTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final cardWidth = MediaQuery.sizeOf(context).width * 0.87;
    // Le Lottie fait 400 x 260 ; le centre du grand bouquet (y = 94) doit
    // tomber sur le bord haut de la carte.
    const lottieAspect = 260 / 400;
    const lottieTopOffset = 94 / 400;

    return Center(
      child: SizedBox(
        width: cardWidth,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: cardWidth,
              height: cardWidth * 1.34,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(34.0),
              ),
            ),
            if (_showFireworks)
              Positioned(
                top: -cardWidth * lottieTopOffset,
                left: 0,
                width: cardWidth,
                height: cardWidth * lottieAspect,
                child: Lottie.asset(
                  'assets/jsons/fireworks.json',
                  fit: BoxFit.fill,
                  repeat: true,
                ),
              ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: cardWidth * 0.06),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: cardWidth * 0.07),
                  Image.asset(
                    'assets/images/Untitled_design_(58).png',
                    width: cardWidth * 0.46,
                    height: cardWidth * 0.46,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: cardWidth * 0.12),
                  Text(
                    'Bravo ${widget.prenom} !',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: theme.secondary,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: cardWidth * 0.05),
                  Text(
                    'Une séance tous les jours te permettra de retrouver '
                    'de la sérénité et de la confiance',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: theme.secondary,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w400,
                      height: 1.45,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 900.ms, curve: Curves.easeOut)
        .slideY(
            begin: 0.06, end: 0.0, duration: 900.ms, curve: Curves.easeOutCubic)
        .scaleXY(
            begin: 0.96,
            end: 1.0,
            duration: 900.ms,
            curve: Curves.easeOutCubic);
  }
}
