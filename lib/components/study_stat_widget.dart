import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';

/// Chiffre d'étude mis en avant pendant l'onboarding : un grand pourcentage
/// dans un cercle qui se remplit, suivi d'une phrase courte.
class StudyStatWidget extends StatelessWidget {
  const StudyStatWidget({super.key, this.percent = 0.87});

  final double percent;

  /// Le cercle et le chiffre atteignent leur valeur finale en 3 s.
  static const _fillDuration = Duration(milliseconds: 3000);

  @override
  Widget build(BuildContext context) {
    final strong = FlutterFlowTheme.of(context).secondary;
    final muted = strong.withValues(alpha: 0.75);

    TextStyle textStyle(Color color, FontWeight weight) => GoogleFonts.poppins(
          color: color,
          fontSize: 18.0,
          fontWeight: weight,
          height: 1.55,
        );

    return Padding(
      padding: const EdgeInsets.fromLTRB(30.0, 27.0, 30.0, 0.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'D’après des études sur la santé mentale',
            textAlign: TextAlign.center,
            style: textStyle(muted, FontWeight.w400),
          ),
          const SizedBox(height: 56.0),
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: percent),
            duration: _fillDuration,
            curve: Curves.easeOutCubic,
            builder: (context, value, _) => CircularPercentIndicator(
              percent: value,
              radius: 91.0,
              lineWidth: 11.0,
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: strong,
              backgroundColor: const Color(0xFFEBDAD3),
              center: Text(
                '${(value * 100).round()}%',
                style: GoogleFonts.poppins(
                  color: strong,
                  fontSize: 50.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          const SizedBox(height: 55.0),
          Text.rich(
            TextSpan(
              style: textStyle(muted, FontWeight.w400),
              children: [
                const TextSpan(
                  text: 'Des personnes qui pratiquent régulièrement '
                      'les affirmations\n',
                ),
                TextSpan(
                  text: 'ressentent moins de stress\n',
                  style: textStyle(strong, FontWeight.w700),
                ),
                const TextSpan(text: 'et '),
                TextSpan(
                  text: 'reprennent confiance',
                  style: textStyle(strong, FontWeight.w700),
                ),
                const TextSpan(text: ' en eux.'),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
