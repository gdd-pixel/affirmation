import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/paywall_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/revenue_cat_util.dart' as revenue_cat;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'themepop_model.dart';
export 'themepop_model.dart';

class ThemepopWidget extends StatefulWidget {
  const ThemepopWidget({super.key});

  @override
  State<ThemepopWidget> createState() => _ThemepopWidgetState();
}

class _ThemepopWidgetState extends State<ThemepopWidget> {
  late ThemepopModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ThemepopModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('THEMEPOP_COMP_Themepop_ON_INIT_STATE');
      logFirebaseEvent('Themepop_update_component_state');
      _model.themeselec = valueOrDefault(currentUserDocument?.currentheme, '');
      safeSetState(() {});
    });
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primary,
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(30.0, 40.0, 30.0, 0.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 25.0, 0.0, 12.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      logFirebaseEvent('THEMEPOP_COMP_Icon_g4ozblsh_ON_TAP');
                      logFirebaseEvent('Icon_bottom_sheet');
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: FlutterFlowTheme.of(context).secondary,
                      size: 30.0,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 12.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mes Thèmes',
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            fontSize: 20.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                    ),
                  ].divide(SizedBox(height: 5.0)),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 500.0,
                decoration: BoxDecoration(),
                child: GridView(
                  padding: EdgeInsets.zero,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 0.7,
                  ),
                  scrollDirection: Axis.vertical,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(1.0, 0.0, 0.0, 0.0),
                      child: Stack(
                        children: [
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              logFirebaseEvent(
                                  'THEMEPOP_COMP_Container_hheolen2_ON_TAP');
                              logFirebaseEvent(
                                  'Container_update_component_state');
                              _model.themeselec = 'base1';
                              safeSetState(() {});
                              logFirebaseEvent('Container_backend_call');

                              await currentUserReference!
                                  .update(createUsersRecordData(
                                currentheme: _model.themeselec,
                              ));
                            },
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).primary,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: Image.asset(
                                    'assets/images/11.png',
                                  ).image,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 4.0,
                                    color: Color(0x33000000),
                                    offset: Offset(
                                      2.0,
                                      2.0,
                                    ),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                            ),
                          ),
                          if (_model.themeselec == 'base1')
                            Align(
                              alignment: AlignmentDirectional(1.0, -1.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 10.0, 10.0, 0.0),
                                child: Icon(
                                  Icons.check_circle,
                                  color: Color(0xFF4ED821),
                                  size: 24.0,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    Stack(
                      children: [
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            logFirebaseEvent(
                                'THEMEPOP_COMP_Container_6xcia7rm_ON_TAP');
                            logFirebaseEvent(
                                'Container_update_component_state');
                            _model.themeselec = 'base2';
                            safeSetState(() {});
                            logFirebaseEvent('Container_backend_call');

                            await currentUserReference!
                                .update(createUsersRecordData(
                              currentheme: _model.themeselec,
                            ));
                          },
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).primary,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: Image.asset(
                                  'assets/images/12.png',
                                ).image,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 4.0,
                                  color: Color(0x33000000),
                                  offset: Offset(
                                    2.0,
                                    2.0,
                                  ),
                                )
                              ],
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                          ),
                        ),
                        if (_model.themeselec == 'base2')
                          Align(
                            alignment: AlignmentDirectional(1.0, -1.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 10.0, 10.0, 0.0),
                              child: Icon(
                                Icons.check_circle,
                                color: Color(0xFF4ED821),
                                size: 24.0,
                              ),
                            ),
                          ),
                      ],
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        logFirebaseEvent('THEMEPOP_COMP_Stack_v2sjclbt_ON_TAP');
                        if (revenue_cat.activeEntitlementIds
                            .contains('accespremium')) {
                          logFirebaseEvent('Stack_update_component_state');
                          _model.themeselec = 'soir';
                          safeSetState(() {});
                          logFirebaseEvent('Stack_backend_call');

                          await currentUserReference!
                              .update(createUsersRecordData(
                            currentheme: _model.themeselec,
                          ));
                          logFirebaseEvent('Stack_show_snack_bar');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'yes sir',
                                style: TextStyle(
                                  color: FlutterFlowTheme.of(context).primary,
                                ),
                              ),
                              duration: Duration(milliseconds: 4000),
                              backgroundColor:
                                  FlutterFlowTheme.of(context).secondary,
                            ),
                          );
                        } else {
                          logFirebaseEvent('Stack_bottom_sheet');
                          await showModalBottomSheet(
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            enableDrag: false,
                            context: context,
                            builder: (context) {
                              return Padding(
                                padding: MediaQuery.viewInsetsOf(context),
                                child: PaywallWidget(),
                              );
                            },
                          ).then((value) => safeSetState(() {}));
                        }
                      },
                      child: Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).primary,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: Image.asset(
                                  'assets/images/Retrouve_la_sourire_et_prends_du_recule_(3).png',
                                ).image,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 4.0,
                                  color: Color(0x33000000),
                                  offset: Offset(
                                    2.0,
                                    2.0,
                                  ),
                                )
                              ],
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                          ),
                          if (!revenue_cat.activeEntitlementIds
                              .contains('accespremium'))
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  10.0, 10.0, 0.0, 0.0),
                              child: FaIcon(
                                FontAwesomeIcons.crown,
                                color: FlutterFlowTheme.of(context).primary,
                                size: 15.0,
                              ),
                            ),
                          if (_model.themeselec == 'soir')
                            Align(
                              alignment: AlignmentDirectional(1.0, -1.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 10.0, 10.0, 0.0),
                                child: Icon(
                                  Icons.check_circle,
                                  color: Color(0xFF4ED821),
                                  size: 24.0,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        logFirebaseEvent('THEMEPOP_COMP_Stack_duf8pqha_ON_TAP');
                        if (revenue_cat.activeEntitlementIds
                            .contains('accespremium')) {
                          logFirebaseEvent('Stack_update_component_state');
                          _model.themeselec = 'fall';
                          safeSetState(() {});
                          logFirebaseEvent('Stack_backend_call');

                          await currentUserReference!
                              .update(createUsersRecordData(
                            currentheme: _model.themeselec,
                          ));
                        } else {
                          logFirebaseEvent('Stack_bottom_sheet');
                          await showModalBottomSheet(
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            enableDrag: false,
                            context: context,
                            builder: (context) {
                              return Padding(
                                padding: MediaQuery.viewInsetsOf(context),
                                child: PaywallWidget(),
                              );
                            },
                          ).then((value) => safeSetState(() {}));
                        }
                      },
                      child: Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).primary,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: Image.asset(
                                  'assets/images/Retrouve_la_sourire_et_prends_du_recule_(5).png',
                                ).image,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 4.0,
                                  color: Color(0x33000000),
                                  offset: Offset(
                                    2.0,
                                    2.0,
                                  ),
                                )
                              ],
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                          ),
                          if (!revenue_cat.activeEntitlementIds
                              .contains('accespremium'))
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  10.0, 10.0, 0.0, 0.0),
                              child: FaIcon(
                                FontAwesomeIcons.crown,
                                color: FlutterFlowTheme.of(context).primary,
                                size: 15.0,
                              ),
                            ),
                          if (_model.themeselec == 'fall')
                            Align(
                              alignment: AlignmentDirectional(1.0, -1.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 10.0, 10.0, 0.0),
                                child: Icon(
                                  Icons.check_circle,
                                  color: Color(0xFF4ED821),
                                  size: 24.0,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        logFirebaseEvent('THEMEPOP_COMP_Stack_tb5hjym6_ON_TAP');
                        if (revenue_cat.activeEntitlementIds
                            .contains('accespremium')) {
                          logFirebaseEvent('Stack_update_component_state');
                          _model.themeselec = 'beach';
                          safeSetState(() {});
                          logFirebaseEvent('Stack_backend_call');

                          await currentUserReference!
                              .update(createUsersRecordData(
                            currentheme: _model.themeselec,
                          ));
                        } else {
                          logFirebaseEvent('Stack_bottom_sheet');
                          await showModalBottomSheet(
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            enableDrag: false,
                            context: context,
                            builder: (context) {
                              return Padding(
                                padding: MediaQuery.viewInsetsOf(context),
                                child: PaywallWidget(),
                              );
                            },
                          ).then((value) => safeSetState(() {}));
                        }
                      },
                      child: Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).primary,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: Image.asset(
                                  'assets/images/Retrouve_la_sourire_et_prends_du_recule_(4).png',
                                ).image,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 4.0,
                                  color: Color(0x33000000),
                                  offset: Offset(
                                    2.0,
                                    2.0,
                                  ),
                                )
                              ],
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                          ),
                          if (!revenue_cat.activeEntitlementIds
                              .contains('accespremium'))
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  10.0, 10.0, 0.0, 0.0),
                              child: FaIcon(
                                FontAwesomeIcons.crown,
                                color: FlutterFlowTheme.of(context).primary,
                                size: 15.0,
                              ),
                            ),
                          if (_model.themeselec == 'beach')
                            Align(
                              alignment: AlignmentDirectional(1.0, -1.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 10.0, 10.0, 0.0),
                                child: Icon(
                                  Icons.check_circle,
                                  color: Color(0xFF4ED821),
                                  size: 24.0,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        logFirebaseEvent('THEMEPOP_COMP_Stack_35zswf25_ON_TAP');
                        if (revenue_cat.activeEntitlementIds
                            .contains('accespremium')) {
                          logFirebaseEvent('Stack_update_component_state');
                          _model.themeselec = 'canyon';
                          safeSetState(() {});
                          logFirebaseEvent('Stack_backend_call');

                          await currentUserReference!
                              .update(createUsersRecordData(
                            currentheme: _model.themeselec,
                          ));
                        } else {
                          logFirebaseEvent('Stack_bottom_sheet');
                          await showModalBottomSheet(
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            enableDrag: false,
                            context: context,
                            builder: (context) {
                              return Padding(
                                padding: MediaQuery.viewInsetsOf(context),
                                child: PaywallWidget(),
                              );
                            },
                          ).then((value) => safeSetState(() {}));
                        }
                      },
                      child: Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).primary,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: Image.asset(
                                  'assets/images/Retrouve_la_sourire_et_prends_du_recule_(6).png',
                                ).image,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 4.0,
                                  color: Color(0x33000000),
                                  offset: Offset(
                                    2.0,
                                    2.0,
                                  ),
                                )
                              ],
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                          ),
                          if (!revenue_cat.activeEntitlementIds
                              .contains('accespremium'))
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  10.0, 10.0, 0.0, 0.0),
                              child: FaIcon(
                                FontAwesomeIcons.crown,
                                color: FlutterFlowTheme.of(context).primary,
                                size: 15.0,
                              ),
                            ),
                          if (_model.themeselec == 'canyon')
                            Align(
                              alignment: AlignmentDirectional(1.0, -1.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 10.0, 10.0, 0.0),
                                child: Icon(
                                  Icons.check_circle,
                                  color: Color(0xFF4ED821),
                                  size: 24.0,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 30.0,
              decoration: BoxDecoration(),
            ),
          ],
        ),
      ),
    );
  }
}
