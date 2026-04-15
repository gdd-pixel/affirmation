import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'popupexo_model.dart';
export 'popupexo_model.dart';

class PopupexoWidget extends StatefulWidget {
  const PopupexoWidget({super.key});

  @override
  State<PopupexoWidget> createState() => _PopupexoWidgetState();
}

class _PopupexoWidgetState extends State<PopupexoWidget> {
  late PopupexoModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PopupexoModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0.0, 0.0),
      child: GestureDetector(
        onPanDown: (details) async {
          logFirebaseEvent('POPUPEXO_Container_ibn0051c_ON_PAN_DOWN');
          logFirebaseEvent('Container_bottom_sheet');
          Navigator.pop(context);
        },
        child: Material(
          color: Colors.transparent,
          elevation: 2.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32.0),
          ),
          child: Container(
            width: MediaQuery.sizeOf(context).width * 0.8,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              borderRadius: BorderRadius.circular(32.0),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(32.0, 0.0, 32.0, 0.0),
                    child: Container(
                      decoration: BoxDecoration(),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.close,
                            color: Color(0xFF7D736F),
                            size: 20.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            'assets/images/Untitled_design_(58).png',
                            width: 100.0,
                            height: 100.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(
                          'Ta séance est prête ',
                          textAlign: TextAlign.center,
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: 'Motter Corpus',
                                color: FlutterFlowTheme.of(context).secondary,
                                fontSize: 20.0,
                                letterSpacing: 0.0,
                              ),
                        ),
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: 250.0,
                          ),
                          decoration: BoxDecoration(),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              AutoSizeText(
                                '2 minutes d\'affirmations positives pour reprendre le contrôle tes pensées',
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                minFontSize: 10.0,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.poppins(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      fontSize: 12.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ].divide(SizedBox(height: 8.0)),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 42.0, 0.0, 0.0),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        logFirebaseEvent(
                            'POPUPEXO_COMP_Container_keaeuaa2_ON_TAP');
                        logFirebaseEvent('Container_google_analytics_event');
                        logFirebaseEvent('Pratiquepopup');
                        logFirebaseEvent('Container_bottom_sheet');
                        Navigator.pop(context);
                        logFirebaseEvent('Container_navigate_to');

                        context.pushNamed(PratiqueWidget.routeName);
                      },
                      child: Container(
                        width: MediaQuery.sizeOf(context).width * 0.5,
                        height: 50.0,
                        decoration: BoxDecoration(
                          color: Color(0xFF4A82C5),
                          borderRadius: BorderRadius.circular(1000.0),
                        ),
                        child: Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Text(
                            'C\'est parti !',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  fontSize: 18.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ].divide(SizedBox(height: 1.0)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
