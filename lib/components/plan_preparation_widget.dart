import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';

/// Écran « On prépare ton plan » de l'onboarding.
///
/// Pendant la préparation, le cercle se remplit et les étapes se cochent une
/// par une. À 100 %, le cercle passe au vert et la carte « Ton plan est
/// prêt ! » remplace la liste.
class PlanPreparationWidget extends StatelessWidget {
  const PlanPreparationWidget({
    super.key,
    required this.progress,
    required this.prenom,
    required this.objective,
    required this.dailyCount,
    required this.startHour,
    required this.endHour,
  });

  /// Avancement de 0 à 1.
  final double progress;
  final String prenom;
  final String objective;
  final int dailyCount;
  final int startHour;
  final int endHour;

  /// Avancement à partir duquel chaque étape de la liste est cochée.
  static const _stepThresholds = [0.2, 0.4, 0.6, 0.8, 0.95];

  static const _green = Color(0xFF67B547);
  static const _track = Color(0xFFEBDAD3);
  static const _pendingGrey = Color(0xFF9B9B9B);

  bool get _isReady => progress >= 1.0;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final screenHeight = MediaQuery.sizeOf(context).height;
    final radius = (screenHeight * 0.115).clamp(70.0, 100.0);

    final steps = [
      'On analyse tes 14 réponses',
      'Objectif : $objective',
      '$dailyCount affirmations par jour de ${startHour}h à ${endHour}h',
      'On écrit des premières affirmations',
      'On prépare ton widget',
    ];

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              'On prépare ton plan $prenom',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: theme.primaryText,
                fontSize: 19.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 14.0),
          CircularPercentIndicator(
            percent: progress.clamp(0.0, 1.0),
            radius: radius,
            lineWidth: 12.0,
            animation: true,
            animationDuration: 1200,
            animateFromLastPercent: true,
            progressColor: _isReady ? _green : theme.tertiary,
            backgroundColor: _track,
            center: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: Image.asset(
                _mascotFor(progress),
                key: ValueKey(_mascotFor(progress)),
                width: radius * 1.05,
                height: radius * 1.05,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 24.0),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 700),
            switchInCurve: Curves.easeOutCubic,
            switchOutCurve: Curves.easeIn,
            transitionBuilder: (child, animation) => FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween(
                  begin: const Offset(0.0, 0.08),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            ),
            child: _isReady
                ? _ReadyCard(key: const ValueKey('ready'))
                : Padding(
                    key: const ValueKey('steps'),
                    padding: const EdgeInsets.symmetric(horizontal: 26.0),
                    child: Column(
                      children: [
                        for (var i = 0; i < steps.length; i++)
                          _StepRow(
                            label: steps[i],
                            done: progress >= _stepThresholds[i],
                          ),
                      ],
                    ),
                  ),
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }

  static String _mascotFor(double progress) {
    if (progress >= 1.0) {
      return 'assets/images/Untitled_design_(86).png';
    }
    if (progress > 0.5) {
      return 'assets/images/Untitled_design_(90).png';
    }
    return 'assets/images/Untitled_design_(91).png';
  }
}

class _StepRow extends StatelessWidget {
  const _StepRow({required this.label, required this.done});

  final String label;
  final bool done;

  static const _duration = Duration(milliseconds: 400);

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 13.0),
      child: Row(
        children: [
          AnimatedContainer(
            duration: _duration,
            width: 24.0,
            height: 24.0,
            decoration: BoxDecoration(
              color: done ? theme.tertiary : PlanPreparationWidget._pendingGrey,
              shape: BoxShape.circle,
            ),
            child:
                const Icon(Icons.check_rounded, color: Colors.white, size: 17),
          ),
          const SizedBox(width: 18.0),
          Expanded(
            child: AnimatedDefaultTextStyle(
              duration: _duration,
              style: GoogleFonts.poppins(
                color:
                    done ? theme.secondary : PlanPreparationWidget._pendingGrey,
                fontSize: 15.0,
                fontWeight: FontWeight.w700,
              ),
              child: Text(label),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReadyCard extends StatelessWidget {
  const _ReadyCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final accent = theme.tertiary;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 13.0),
      padding: const EdgeInsets.fromLTRB(18.0, 28.0, 18.0, 28.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.0),
        boxShadow: const [
          BoxShadow(
            blurRadius: 12.0,
            color: Color(0x3D291420),
            offset: Offset(0.0, 4.0),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 34.0,
            height: 34.0,
            decoration: BoxDecoration(
              color: const Color(0xFFE7F0E7),
              shape: BoxShape.circle,
              border: Border.all(color: PlanPreparationWidget._green),
            ),
            child: const Icon(
              Icons.check_rounded,
              color: PlanPreparationWidget._green,
              size: 22.0,
            ),
          ),
          const SizedBox(height: 10.0),
          Text(
            'Ton plan est prêt !',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: theme.secondary,
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 14.0),
          Text(
            'On a pris en compte ce que tu traverses et ce que tu veux changer.',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: theme.secondary,
              fontSize: 13.0,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20.0),
          Text(
            'Tu vas recevoir des affirmations qui t\'aideront à :',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: accent,
              fontSize: 13.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 22.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              _Benefit(
                icon: Icons.check_circle_outline_rounded,
                label: 'Avancer avec plus de clarté',
              ),
              _Benefit(
                icon: Icons.favorite_rounded,
                label: 'Te sentir plus aligné(e) au quotidien',
              ),
              _Benefit(
                icon: Icons.auto_awesome_rounded,
                label: 'Passer à l\'action',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Benefit extends StatelessWidget {
  const _Benefit({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final accent = FlutterFlowTheme.of(context).tertiary;

    return Expanded(
      child: Column(
        children: [
          Container(
            width: 44.0,
            height: 44.0,
            decoration: const BoxDecoration(
              color: Color(0xFFF9F0EC),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: accent, size: 24.0),
          ),
          const SizedBox(height: 10.0),
          Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: accent,
              fontSize: 11.0,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}
