import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/app_themes.dart';
import '/components/paypaycompo_widget.dart';
import '/components/theme_grid.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/revenue_cat_util.dart' as revenue_cat;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'themepop_model.dart';
export 'themepop_model.dart';

/// Feuille « Sélectionner un thème » : filtres par famille et grille des
/// thèmes. Le thème choisi s'applique tout de suite à la page principale.
class ThemepopWidget extends StatefulWidget {
  const ThemepopWidget({super.key});

  @override
  State<ThemepopWidget> createState() => _ThemepopWidgetState();
}

class _ThemepopWidgetState extends State<ThemepopWidget> {
  late ThemepopModel _model;

  /// Filtre actif ; `null` = « Tous ».
  ThemeFamily? _family;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ThemepopModel());
    _model.themeselec =
        philThemeById(valueOrDefault(currentUserDocument?.currentheme, '')).id;
  }

  @override
  void dispose() {
    _model.maybeDispose();
    super.dispose();
  }

  bool get _isPremium =>
      revenue_cat.activeEntitlementIds.contains('accespremium');

  Future<void> _select(PhilTheme theme) async {
    if (!theme.free && !_isPremium) {
      await showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        enableDrag: false,
        context: context,
        builder: (context) => Padding(
          padding: MediaQuery.viewInsetsOf(context),
          child: PaypaycompoWidget(),
        ),
      );
      if (mounted) {
        setState(() {});
      }
      return;
    }
    HapticFeedback.selectionClick();
    setState(() => _model.themeselec = theme.id);
    await currentUserReference!.update(createUsersRecordData(
      currentheme: theme.id,
      darkmode: theme.isDark,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final app = FlutterFlowTheme.of(context);
    final themes = _family == null
        ? kPhilThemes
        : kPhilThemes.where((t) => t.families.contains(_family)).toList();

    Widget chip(String label, ThemeFamily? family) {
      final selected = _family == family;
      return GestureDetector(
        onTap: () {
          HapticFeedback.selectionClick();
          setState(() => _family = family);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: selected ? app.secondary : Colors.white,
            borderRadius: BorderRadius.circular(100.0),
          ),
          child: Text(
            label,
            style: GoogleFonts.poppins(
              color: selected ? Colors.white : app.secondary,
              fontSize: 13.0,
              fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
      );
    }

    return Container(
      height: MediaQuery.sizeOf(context).height * 0.92,
      decoration: BoxDecoration(
        color: app.primary,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32.0)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 10.0),
          Container(
            width: 40.0,
            height: 4.0,
            decoration: BoxDecoration(
              color: app.secondary.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(100.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 14.0, 8.0, 0.0),
            child: Row(
              children: [
                const SizedBox(width: 40.0),
                Expanded(
                  child: Text(
                    'Sélectionner un thème',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Motter Corpus',
                      color: app.secondary,
                      fontSize: 22.0,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close_rounded,
                      color: app.secondary, size: 24.0),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12.0),
          SizedBox(
            height: 38.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              children: [
                chip('Tous', null),
                for (final family in ThemeFamily.values) ...[
                  const SizedBox(width: 8.0),
                  chip(kThemeFamilyLabels[family]!, family),
                ],
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          Expanded(
            child: ThemeGrid(
              themes: themes,
              selectedId: _model.themeselec ?? '',
              isPremium: _isPremium,
              onSelect: _select,
              padding: EdgeInsets.fromLTRB(
                  20.0, 4.0, 20.0, MediaQuery.paddingOf(context).bottom + 24.0),
            ),
          ),
        ],
      ),
    );
  }
}
