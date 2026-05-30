import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/avantsettings_widget.dart';
import '/components/category_widget.dart';
import '/components/paywall_widget.dart';
import '/components/popupexo_widget.dart';
import '/components/themepop_widget.dart';
import '/flutter_flow/flutter_flow_swipeable_stack.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_toggle_icon.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'swipe_page_model.dart';
export 'swipe_page_model.dart';

class SwipePageWidget extends StatefulWidget {
  const SwipePageWidget({super.key});

  static String routeName = 'swipePage';
  static String routePath = '/swipePage';

  @override
  State<SwipePageWidget> createState() => _SwipePageWidgetState();
}

class _SwipePageWidgetState extends State<SwipePageWidget> {
  late SwipePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SwipePageModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'swipePage'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (valueOrDefault<bool>(currentUserDocument?.comptefini, false)) {
        HapticFeedback.vibrate();
        await actions.handlePushNavigation(
          context,
        );
        _model.isliked = false;
        safeSetState(() {});
        if ((dateTimeFormat(
                  "d/M/y",
                  currentUserDocument?.lastOpenAt,
                  locale: FFLocalizations.of(context).languageCode,
                ) !=
                dateTimeFormat(
                  "d/M/y",
                  getCurrentTimestamp,
                  locale: FFLocalizations.of(context).languageCode,
                )) &&
            (dateTimeFormat(
                  "d/M/y",
                  getCurrentTimestamp,
                  locale: FFLocalizations.of(context).languageCode,
                ) !=
                dateTimeFormat(
                  "d/M/y",
                  currentUserDocument?.createdTime,
                  locale: FFLocalizations.of(context).languageCode,
                ))) {
          await showModalBottomSheet(
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            enableDrag: false,
            context: context,
            builder: (context) {
              return GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                child: Padding(
                  padding: MediaQuery.viewInsetsOf(context),
                  child: Container(
                    height: double.infinity,
                    child: PopupexoWidget(),
                  ),
                ),
              );
            },
          ).then((value) => safeSetState(() {}));
        }

        await currentUserReference!.update(createUsersRecordData(
          nextNotificationAt: functions.nextday8AM(),
          nextNotificationType: 'daily',
          lastOpenAt: getCurrentTimestamp,
        ));
      } else {
        context.pushNamed(InscriptionWidget.routeName);
      }
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthUserStreamWidget(
      builder: (context) => StreamBuilder<List<FavoritesRecord>>(
        stream: queryFavoritesRecord(
          parent: currentUserReference,
        ),
        builder: (context, snapshot) {
          // Customize what your widget looks like when it's loading.
          if (!snapshot.hasData) {
            return Scaffold(
              backgroundColor: valueOrDefault<Color>(
                () {
                  if (valueOrDefault(currentUserDocument?.currentheme, '') ==
                      'base1') {
                    return FlutterFlowTheme.of(context).primary;
                  } else if (valueOrDefault(
                          currentUserDocument?.currentheme, '') ==
                      'base2') {
                    return FlutterFlowTheme.of(context).secondary;
                  } else {
                    return FlutterFlowTheme.of(context).primary;
                  }
                }(),
                FlutterFlowTheme.of(context).primary,
              ),
              body: Center(
                child: SizedBox(
                  width: 50.0,
                  height: 50.0,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      FlutterFlowTheme.of(context).primary,
                    ),
                  ),
                ),
              ),
            );
          }
          List<FavoritesRecord> swipePageFavoritesRecordList = snapshot.data!;

          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Scaffold(
              key: scaffoldKey,
              backgroundColor: valueOrDefault<Color>(
                () {
                  if (valueOrDefault(currentUserDocument?.currentheme, '') ==
                      'base1') {
                    return FlutterFlowTheme.of(context).primary;
                  } else if (valueOrDefault(
                          currentUserDocument?.currentheme, '') ==
                      'base2') {
                    return FlutterFlowTheme.of(context).secondary;
                  } else {
                    return FlutterFlowTheme.of(context).primary;
                  }
                }(),
                FlutterFlowTheme.of(context).primary,
              ),
              body: Container(
                decoration: BoxDecoration(
                  color: () {
                    if (valueOrDefault(currentUserDocument?.currentheme, '') ==
                        'base1') {
                      return FlutterFlowTheme.of(context).primary;
                    } else if (valueOrDefault(
                            currentUserDocument?.currentheme, '') ==
                        'base2') {
                      return FlutterFlowTheme.of(context).secondary;
                    } else {
                      return FlutterFlowTheme.of(context).primary;
                    }
                  }(),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: Image.network(
                      valueOrDefault<String>(
                        () {
                          if (valueOrDefault(
                                  currentUserDocument?.currentheme, '') ==
                              'soir') {
                            return 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/affirmation-lguktd/assets/9k34ijytrnlw/Retrouve_la_sourire_et_prends_du_recule_(3).png';
                          } else if (valueOrDefault(
                                  currentUserDocument?.currentheme, '') ==
                              'beach') {
                            return 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/affirmation-lguktd/assets/t5ipo9hpr390/Retrouve_la_sourire_et_prends_du_recule_(4).png';
                          } else if (valueOrDefault(
                                  currentUserDocument?.currentheme, '') ==
                              'canyon') {
                            return 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/affirmation-lguktd/assets/u8p30k57b13b/Retrouve_la_sourire_et_prends_du_recule_(6).png';
                          } else if (valueOrDefault(
                                  currentUserDocument?.currentheme, '') ==
                              'fall') {
                            return 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/affirmation-lguktd/assets/d8gm7c3hamx0/Retrouve_la_sourire_et_prends_du_recule_(5).png';
                          } else if (valueOrDefault(
                                  currentUserDocument?.currentheme, '') ==
                              'base2') {
                            return 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/affirmation-lguktd/assets/jshrea0307nf/134.png';
                          } else if (valueOrDefault(
                                  currentUserDocument?.currentheme, '') ==
                              'lac') {
                            return 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/affirmation-lguktd/assets/g9njo31en21z/6.jpg';
                          } else if (valueOrDefault(
                                  currentUserDocument?.currentheme, '') ==
                              'ble') {
                            return 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/affirmation-lguktd/assets/w7cpa5v6wmd5/1.jpg';
                          } else if (valueOrDefault(
                                  currentUserDocument?.currentheme, '') ==
                              'fleur') {
                            return 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/affirmation-lguktd/assets/8wsb4z1aeadj/2.jpg';
                          } else if (valueOrDefault(
                                  currentUserDocument?.currentheme, '') ==
                              'nuage') {
                            return 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/affirmation-lguktd/assets/jsm8hzlszasy/10.jpg';
                          } else if (valueOrDefault(
                                  currentUserDocument?.currentheme, '') ==
                              'nuagerose') {
                            return 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/affirmation-lguktd/assets/x92b903ua5il/11.jpg';
                          } else if (valueOrDefault(
                                  currentUserDocument?.currentheme, '') ==
                              'palmier') {
                            return 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/affirmation-lguktd/assets/flxp0x2swjbq/3.jpg';
                          } else if (valueOrDefault(
                                  currentUserDocument?.currentheme, '') ==
                              'abstrait1') {
                            return 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/affirmation-lguktd/assets/poot81w7vsr8/15.jpg';
                          } else if (valueOrDefault(
                                  currentUserDocument?.currentheme, '') ==
                              'abstrait2') {
                            return 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/affirmation-lguktd/assets/evl4ahjw31oa/14.jpg';
                          } else {
                            return 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/affirmation-lguktd/assets/hubwxgmbeooz/122.png';
                          }
                        }(),
                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/affirmation-lguktd/assets/hubwxgmbeooz/122.png',
                      ),
                    ).image,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      decoration: BoxDecoration(),
                      child: Visibility(
                        visible: !valueOrDefault<bool>(
                            currentUserDocument?.accountfinished, false),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 64.0, 16.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  HapticFeedback.heavyImpact();
                                  await showModalBottomSheet(
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    enableDrag: false,
                                    context: context,
                                    builder: (context) {
                                      return GestureDetector(
                                        onTap: () {
                                          FocusScope.of(context).unfocus();
                                          FocusManager.instance.primaryFocus
                                              ?.unfocus();
                                        },
                                        child: Padding(
                                          padding:
                                              MediaQuery.viewInsetsOf(context),
                                          child: ThemepopWidget(),
                                        ),
                                      );
                                    },
                                  ).then((value) => safeSetState(() {}));
                                },
                                child: Material(
                                  color: Colors.transparent,
                                  elevation: 2.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100.0),
                                  ),
                                  child: Container(
                                    width: 50.0,
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      boxShadow: [
                                        BoxShadow(
                                          color: FlutterFlowTheme.of(context)
                                              .secondary,
                                          offset: Offset(
                                            3.0,
                                            4.0,
                                          ),
                                        )
                                      ],
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                      border: Border.all(
                                        width: 1.0,
                                      ),
                                    ),
                                    child: Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Icon(
                                        Icons.format_paint,
                                        color: FlutterFlowTheme.of(context)
                                            .secondary,
                                        size: 20.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Material(
                                color: Colors.transparent,
                                elevation: 2.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100.0),
                                ),
                                child: Container(
                                  width: 50.0,
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    boxShadow: [
                                      BoxShadow(
                                        color: FlutterFlowTheme.of(context)
                                            .secondary,
                                        offset: Offset(
                                          3.0,
                                          3.0,
                                        ),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(100.0),
                                    border: Border.all(
                                      width: 1.0,
                                    ),
                                  ),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      HapticFeedback.heavyImpact();
                                      await showModalBottomSheet(
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                        enableDrag: false,
                                        context: context,
                                        builder: (context) {
                                          return GestureDetector(
                                            onTap: () {
                                              FocusScope.of(context).unfocus();
                                              FocusManager.instance.primaryFocus
                                                  ?.unfocus();
                                            },
                                            child: Padding(
                                              padding: MediaQuery.viewInsetsOf(
                                                  context),
                                              child: AvantsettingsWidget(),
                                            ),
                                          );
                                        },
                                      ).then((value) => safeSetState(() {}));
                                    },
                                    child: Icon(
                                      Icons.person_rounded,
                                      color: FlutterFlowTheme.of(context)
                                          .secondary,
                                      size: 25.0,
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  HapticFeedback.heavyImpact();
                                  logFirebaseEvent('premiumevent');
                                  await showModalBottomSheet(
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    enableDrag: false,
                                    context: context,
                                    builder: (context) {
                                      return GestureDetector(
                                        onTap: () {
                                          FocusScope.of(context).unfocus();
                                          FocusManager.instance.primaryFocus
                                              ?.unfocus();
                                        },
                                        child: Padding(
                                          padding:
                                              MediaQuery.viewInsetsOf(context),
                                          child: PaywallWidget(),
                                        ),
                                      );
                                    },
                                  ).then((value) => safeSetState(() {}));
                                },
                                child: Material(
                                  color: Colors.transparent,
                                  elevation: 2.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100.0),
                                  ),
                                  child: Container(
                                    width: 50.0,
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      boxShadow: [
                                        BoxShadow(
                                          color: FlutterFlowTheme.of(context)
                                              .secondary,
                                          offset: Offset(
                                            3.0,
                                            3.0,
                                          ),
                                        )
                                      ],
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                      border: Border.all(
                                        width: 1.0,
                                      ),
                                    ),
                                    child: Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: FaIcon(
                                        FontAwesomeIcons.crown,
                                        color: FlutterFlowTheme.of(context)
                                            .secondary,
                                        size: 20.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: StreamBuilder<List<AffirmationRecord>>(
                        stream: queryAffirmationRecord(),
                        builder: (context, snapshot) {
                          // Customize what your widget looks like when it's loading.
                          if (!snapshot.hasData) {
                            return Center(
                              child: SizedBox(
                                width: 50.0,
                                height: 50.0,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    FlutterFlowTheme.of(context).primary,
                                  ),
                                ),
                              ),
                            );
                          }
                          List<AffirmationRecord>
                              swipeableStackAffirmationRecordList =
                              snapshot.data!;

                          return FlutterFlowSwipeableStack(
                            onSwipeFn: (swipeableStackIndex) async {
                              final swipeableStackAffirmationRecord =
                                  swipeableStackAffirmationRecordList[
                                      swipeableStackIndex];
                              HapticFeedback.mediumImpact();
                              if (valueOrDefault<bool>(
                                      currentUserDocument?.accountfinished,
                                      false) &&
                                  (_model.onboardstep == 1)) {
                                _model.onboardstep = 2;
                                safeSetState(() {});
                              } else if (valueOrDefault<bool>(
                                      currentUserDocument?.accountfinished,
                                      false) &&
                                  (_model.onboardstep == 2)) {
                                await currentUserReference!
                                    .update(createUsersRecordData(
                                  accountfinished: false,
                                ));
                              } else {
                                _model.isliked = false;
                                safeSetState(() {});
                              }
                            },
                            onLeftSwipe: (swipeableStackIndex) {},
                            onRightSwipe: (swipeableStackIndex) {},
                            onUpSwipe: (swipeableStackIndex) {},
                            onDownSwipe: (swipeableStackIndex) {},
                            itemBuilder: (context, swipeableStackIndex) {
                              final swipeableStackAffirmationRecord =
                                  swipeableStackAffirmationRecordList[
                                      swipeableStackIndex];
                              return Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(),
                                    child: Stack(
                                      children: [
                                        if (!((valueOrDefault(currentUserDocument?.currentheme, '') == 'nuage') ||
                                            (valueOrDefault(
                                                    currentUserDocument
                                                        ?.currentheme,
                                                    '') ==
                                                'palmier') ||
                                            (valueOrDefault(
                                                    currentUserDocument
                                                        ?.currentheme,
                                                    '') ==
                                                'canyon') ||
                                            (valueOrDefault(
                                                    currentUserDocument
                                                        ?.currentheme,
                                                    '') ==
                                                'ble') ||
                                            (valueOrDefault(
                                                    currentUserDocument
                                                        ?.currentheme,
                                                    '') ==
                                                'nuage') ||
                                            (valueOrDefault(
                                                    currentUserDocument
                                                        ?.currentheme,
                                                    '') ==
                                                'palmier') ||
                                            (valueOrDefault(
                                                    currentUserDocument
                                                        ?.currentheme,
                                                    '') ==
                                                'soir') ||
                                            (valueOrDefault(
                                                    currentUserDocument
                                                        ?.currentheme,
                                                    '') ==
                                                'fall') ||
                                            (valueOrDefault(
                                                    currentUserDocument
                                                        ?.currentheme,
                                                    '') ==
                                                'abstrait1') ||
                                            (valueOrDefault(
                                                    currentUserDocument
                                                        ?.currentheme,
                                                    '') ==
                                                'abstrait2') ||
                                            (valueOrDefault(
                                                    currentUserDocument
                                                        ?.currentheme,
                                                    '') ==
                                                'fleur')))
                                          Align(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            child: Text(
                                              () {
                                                if (valueOrDefault<bool>(
                                                        currentUserDocument
                                                            ?.accountfinished,
                                                        false) &&
                                                    (_model.onboardstep == 1)) {
                                                  return 'Bienvenue sur Phil\'O';
                                                } else if (valueOrDefault<bool>(
                                                        currentUserDocument
                                                            ?.accountfinished,
                                                        false) &&
                                                    (_model.onboardstep == 2)) {
                                                  return 'Le  voyage vers la meilleure version de toi-même commence maintenant';
                                                } else {
                                                  return valueOrDefault<String>(
                                                    swipeableStackAffirmationRecord
                                                        .text,
                                                    'ok mec',
                                                  );
                                                }
                                              }(),
                                              textAlign: TextAlign.center,
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .headlineLarge
                                                  .override(
                                                    fontFamily: 'Motter Corpus',
                                                    color:
                                                        valueOrDefault<Color>(
                                                      () {
                                                        if (valueOrDefault(
                                                                currentUserDocument
                                                                    ?.currentheme,
                                                                '') ==
                                                            'base1') {
                                                          return FlutterFlowTheme
                                                                  .of(context)
                                                              .secondary;
                                                        } else if (valueOrDefault(
                                                                currentUserDocument
                                                                    ?.currentheme,
                                                                '') ==
                                                            'ble') {
                                                          return Color(
                                                              0xFF14301D);
                                                        } else if (valueOrDefault(
                                                                currentUserDocument
                                                                    ?.currentheme,
                                                                '') ==
                                                            'abstrait1') {
                                                          return Color(
                                                              0xFF370924);
                                                        } else if (valueOrDefault(
                                                                currentUserDocument
                                                                    ?.currentheme,
                                                                '') ==
                                                            'abstrait2') {
                                                          return Color(
                                                              0xFF370924);
                                                        } else if (valueOrDefault(
                                                                currentUserDocument
                                                                    ?.currentheme,
                                                                '') ==
                                                            'fleur') {
                                                          return Color(
                                                              0xFF370924);
                                                        } else {
                                                          return FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground;
                                                        }
                                                      }(),
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondary,
                                                    ),
                                                    fontSize: 20.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                            ),
                                          ),
                                        Stack(
                                          children: [
                                            if (!valueOrDefault<bool>(
                                                currentUserDocument
                                                    ?.accountfinished,
                                                false))
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    0.0, 1.0),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 0.0, 0.0, 150.0),
                                                  child: ToggleIcon(
                                                    onPressed: () async {
                                                      safeSetState(() =>
                                                          _model.isliked =
                                                              !_model.isliked);
                                                      HapticFeedback
                                                          .heavyImpact();

                                                      await FavoritesRecord
                                                              .createDoc(
                                                                  currentUserReference!)
                                                          .set(
                                                              createFavoritesRecordData(
                                                        affirmationRef:
                                                            swipeableStackAffirmationRecord
                                                                .reference,
                                                        createdAt:
                                                            getCurrentTimestamp,
                                                        text:
                                                            swipeableStackAffirmationRecord
                                                                .text,
                                                      ));
                                                    },
                                                    value: _model.isliked,
                                                    onIcon: Icon(
                                                      Icons.favorite,
                                                      color:
                                                          valueOrDefault<Color>(
                                                        () {
                                                          if (valueOrDefault(
                                                                  currentUserDocument
                                                                      ?.currentheme,
                                                                  '') ==
                                                              'base1') {
                                                            return FlutterFlowTheme
                                                                    .of(context)
                                                                .secondary;
                                                          } else if (valueOrDefault(
                                                                  currentUserDocument
                                                                      ?.currentheme,
                                                                  '') ==
                                                              'ble') {
                                                            return Color(
                                                                0xFF14301D);
                                                          } else if (valueOrDefault(
                                                                  currentUserDocument
                                                                      ?.currentheme,
                                                                  '') ==
                                                              'abstrait1') {
                                                            return Color(
                                                                0xFF370924);
                                                          } else if (valueOrDefault(
                                                                  currentUserDocument
                                                                      ?.currentheme,
                                                                  '') ==
                                                              'abstrait2') {
                                                            return Color(
                                                                0xFF370924);
                                                          } else if (valueOrDefault(
                                                                  currentUserDocument
                                                                      ?.currentheme,
                                                                  '') ==
                                                              'fleur') {
                                                            return Color(
                                                                0xFF370924);
                                                          } else {
                                                            return FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground;
                                                          }
                                                        }(),
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .secondary,
                                                      ),
                                                      size: 35.0,
                                                    ),
                                                    offIcon: Icon(
                                                      Icons.favorite_border,
                                                      color:
                                                          valueOrDefault<Color>(
                                                        () {
                                                          if (valueOrDefault(
                                                                  currentUserDocument
                                                                      ?.currentheme,
                                                                  '') ==
                                                              'base1') {
                                                            return FlutterFlowTheme
                                                                    .of(context)
                                                                .secondary;
                                                          } else if (valueOrDefault(
                                                                  currentUserDocument
                                                                      ?.currentheme,
                                                                  '') ==
                                                              'ble') {
                                                            return Color(
                                                                0xFF14301D);
                                                          } else if (valueOrDefault(
                                                                  currentUserDocument
                                                                      ?.currentheme,
                                                                  '') ==
                                                              'abstrait1') {
                                                            return Color(
                                                                0xFF370924);
                                                          } else if (valueOrDefault(
                                                                  currentUserDocument
                                                                      ?.currentheme,
                                                                  '') ==
                                                              'abstrait2') {
                                                            return Color(
                                                                0xFF370924);
                                                          } else if (valueOrDefault(
                                                                  currentUserDocument
                                                                      ?.currentheme,
                                                                  '') ==
                                                              'fleur') {
                                                            return Color(
                                                                0xFF370924);
                                                          } else {
                                                            return FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground;
                                                          }
                                                        }(),
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .secondary,
                                                      ),
                                                      size: 35.0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                        if ((valueOrDefault(currentUserDocument?.currentheme, '') == 'abstrait1') ||
                                            (valueOrDefault(
                                                    currentUserDocument
                                                        ?.currentheme,
                                                    '') ==
                                                'abstrait2') ||
                                            (valueOrDefault(
                                                    currentUserDocument
                                                        ?.currentheme,
                                                    '') ==
                                                'soir'))
                                          Align(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            child: Text(
                                              () {
                                                if (valueOrDefault<bool>(
                                                        currentUserDocument
                                                            ?.accountfinished,
                                                        false) &&
                                                    (_model.onboardstep == 1)) {
                                                  return 'Bienvenue sur Phil\'O';
                                                } else if (valueOrDefault<bool>(
                                                        currentUserDocument
                                                            ?.accountfinished,
                                                        false) &&
                                                    (_model.onboardstep == 2)) {
                                                  return 'Le  voyage vers la meilleure version de toi-même commence maintenant';
                                                } else {
                                                  return valueOrDefault<String>(
                                                    swipeableStackAffirmationRecord
                                                        .text,
                                                    'ok mec',
                                                  );
                                                }
                                              }(),
                                              textAlign: TextAlign.center,
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .headlineLarge
                                                  .override(
                                                    font: GoogleFonts.lilitaOne(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .headlineLarge
                                                              .fontStyle,
                                                    ),
                                                    color:
                                                        valueOrDefault<Color>(
                                                      () {
                                                        if (valueOrDefault(
                                                                currentUserDocument
                                                                    ?.currentheme,
                                                                '') ==
                                                            'base1') {
                                                          return FlutterFlowTheme
                                                                  .of(context)
                                                              .secondary;
                                                        } else if (valueOrDefault(
                                                                currentUserDocument
                                                                    ?.currentheme,
                                                                '') ==
                                                            'ble') {
                                                          return Color(
                                                              0xFF14301D);
                                                        } else if (valueOrDefault(
                                                                currentUserDocument
                                                                    ?.currentheme,
                                                                '') ==
                                                            'abstrait1') {
                                                          return Color(
                                                              0xFF370924);
                                                        } else if (valueOrDefault(
                                                                currentUserDocument
                                                                    ?.currentheme,
                                                                '') ==
                                                            'abstrait2') {
                                                          return Color(
                                                              0xFF370924);
                                                        } else if (valueOrDefault(
                                                                currentUserDocument
                                                                    ?.currentheme,
                                                                '') ==
                                                            'fleur') {
                                                          return Color(
                                                              0xFF370924);
                                                        } else {
                                                          return FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground;
                                                        }
                                                      }(),
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondary,
                                                    ),
                                                    fontSize: 26.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .headlineLarge
                                                            .fontStyle,
                                                  ),
                                            ),
                                          ),
                                        if ((valueOrDefault(
                                                    currentUserDocument
                                                        ?.currentheme,
                                                    '') ==
                                                'ble') ||
                                            (valueOrDefault(
                                                    currentUserDocument
                                                        ?.currentheme,
                                                    '') ==
                                                'fleur') ||
                                            (valueOrDefault(
                                                    currentUserDocument
                                                        ?.currentheme,
                                                    '') ==
                                                'fall'))
                                          Align(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            child: Text(
                                              () {
                                                if (valueOrDefault<bool>(
                                                        currentUserDocument
                                                            ?.accountfinished,
                                                        false) &&
                                                    (_model.onboardstep == 1)) {
                                                  return 'Bienvenue sur Phil\'O';
                                                } else if (valueOrDefault<bool>(
                                                        currentUserDocument
                                                            ?.accountfinished,
                                                        false) &&
                                                    (_model.onboardstep == 2)) {
                                                  return 'Le  voyage vers la meilleure version de toi-même commence maintenant';
                                                } else {
                                                  return valueOrDefault<String>(
                                                    swipeableStackAffirmationRecord
                                                        .text,
                                                    'ok mec',
                                                  );
                                                }
                                              }(),
                                              textAlign: TextAlign.center,
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .headlineLarge
                                                  .override(
                                                    font: GoogleFonts
                                                        .abrilFatface(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .headlineLarge
                                                              .fontStyle,
                                                    ),
                                                    color:
                                                        valueOrDefault<Color>(
                                                      () {
                                                        if (valueOrDefault(
                                                                currentUserDocument
                                                                    ?.currentheme,
                                                                '') ==
                                                            'base1') {
                                                          return FlutterFlowTheme
                                                                  .of(context)
                                                              .secondary;
                                                        } else if (valueOrDefault(
                                                                currentUserDocument
                                                                    ?.currentheme,
                                                                '') ==
                                                            'ble') {
                                                          return Color(
                                                              0xFF14301D);
                                                        } else if (valueOrDefault(
                                                                currentUserDocument
                                                                    ?.currentheme,
                                                                '') ==
                                                            'abstrait1') {
                                                          return Color(
                                                              0xFF370924);
                                                        } else if (valueOrDefault(
                                                                currentUserDocument
                                                                    ?.currentheme,
                                                                '') ==
                                                            'abstrait2') {
                                                          return Color(
                                                              0xFF370924);
                                                        } else if (valueOrDefault(
                                                                currentUserDocument
                                                                    ?.currentheme,
                                                                '') ==
                                                            'fleur') {
                                                          return Color(
                                                              0xFF370924);
                                                        } else {
                                                          return FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground;
                                                        }
                                                      }(),
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondary,
                                                    ),
                                                    fontSize: 23.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .headlineLarge
                                                            .fontStyle,
                                                  ),
                                            ),
                                          ),
                                        if ((valueOrDefault(
                                                    currentUserDocument
                                                        ?.currentheme,
                                                    '') ==
                                                'nuage') ||
                                            (valueOrDefault(
                                                    currentUserDocument
                                                        ?.currentheme,
                                                    '') ==
                                                'palmier') ||
                                            (valueOrDefault(
                                                    currentUserDocument
                                                        ?.currentheme,
                                                    '') ==
                                                'canyon'))
                                          Align(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            child: Text(
                                              () {
                                                if (valueOrDefault<bool>(
                                                        currentUserDocument
                                                            ?.accountfinished,
                                                        false) &&
                                                    (_model.onboardstep == 1)) {
                                                  return 'Bienvenue sur Phil\'O';
                                                } else if (valueOrDefault<bool>(
                                                        currentUserDocument
                                                            ?.accountfinished,
                                                        false) &&
                                                    (_model.onboardstep == 2)) {
                                                  return 'Le  voyage vers la meilleure version de toi-même commence maintenant';
                                                } else {
                                                  return valueOrDefault<String>(
                                                    swipeableStackAffirmationRecord
                                                        .text,
                                                    'ok mec',
                                                  );
                                                }
                                              }(),
                                              textAlign: TextAlign.center,
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .headlineLarge
                                                  .override(
                                                    font: GoogleFonts.bellota(
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .headlineLarge
                                                              .fontStyle,
                                                    ),
                                                    color:
                                                        valueOrDefault<Color>(
                                                      () {
                                                        if (valueOrDefault(
                                                                currentUserDocument
                                                                    ?.currentheme,
                                                                '') ==
                                                            'base1') {
                                                          return FlutterFlowTheme
                                                                  .of(context)
                                                              .secondary;
                                                        } else if (valueOrDefault(
                                                                currentUserDocument
                                                                    ?.currentheme,
                                                                '') ==
                                                            'ble') {
                                                          return Color(
                                                              0xFF14301D);
                                                        } else if (valueOrDefault(
                                                                currentUserDocument
                                                                    ?.currentheme,
                                                                '') ==
                                                            'abstrait1') {
                                                          return Color(
                                                              0xFF370924);
                                                        } else if (valueOrDefault(
                                                                currentUserDocument
                                                                    ?.currentheme,
                                                                '') ==
                                                            'abstrait2') {
                                                          return Color(
                                                              0xFF370924);
                                                        } else if (valueOrDefault(
                                                                currentUserDocument
                                                                    ?.currentheme,
                                                                '') ==
                                                            'fleur') {
                                                          return Color(
                                                              0xFF370924);
                                                        } else {
                                                          return FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground;
                                                        }
                                                      }(),
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondary,
                                                    ),
                                                    fontSize: 25.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w900,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .headlineLarge
                                                            .fontStyle,
                                                  ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  if (valueOrDefault<bool>(
                                      currentUserDocument?.accountfinished,
                                      false))
                                    Align(
                                      alignment: AlignmentDirectional(0.0, 1.0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 100.0),
                                        child: Container(
                                          decoration: BoxDecoration(),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              FaIcon(
                                                FontAwesomeIcons.chevronUp,
                                                color: valueOrDefault<Color>(
                                                  () {
                                                    if (valueOrDefault(
                                                            currentUserDocument
                                                                ?.currentheme,
                                                            '') ==
                                                        'base1') {
                                                      return FlutterFlowTheme
                                                              .of(context)
                                                          .secondary;
                                                    } else if (valueOrDefault(
                                                            currentUserDocument
                                                                ?.currentheme,
                                                            '') ==
                                                        'ble') {
                                                      return Color(0xFF14301D);
                                                    } else if (valueOrDefault(
                                                            currentUserDocument
                                                                ?.currentheme,
                                                            '') ==
                                                        'abstrait1') {
                                                      return Color(0xFF370924);
                                                    } else if (valueOrDefault(
                                                            currentUserDocument
                                                                ?.currentheme,
                                                            '') ==
                                                        'abstrait2') {
                                                      return Color(0xFF370924);
                                                    } else if (valueOrDefault(
                                                            currentUserDocument
                                                                ?.currentheme,
                                                            '') ==
                                                        'fleur') {
                                                      return Color(0xFF370924);
                                                    } else {
                                                      return FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground;
                                                    }
                                                  }(),
                                                  FlutterFlowTheme.of(context)
                                                      .secondary,
                                                ),
                                                size: 30.0,
                                              ),
                                              Text(
                                                'Balaye vers le haut ',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      font: GoogleFonts.poppins(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                      color:
                                                          valueOrDefault<Color>(
                                                        () {
                                                          if (valueOrDefault(
                                                                  currentUserDocument
                                                                      ?.currentheme,
                                                                  '') ==
                                                              'base1') {
                                                            return FlutterFlowTheme
                                                                    .of(context)
                                                                .secondary;
                                                          } else if (valueOrDefault(
                                                                  currentUserDocument
                                                                      ?.currentheme,
                                                                  '') ==
                                                              'ble') {
                                                            return Color(
                                                                0xFF14301D);
                                                          } else if (valueOrDefault(
                                                                  currentUserDocument
                                                                      ?.currentheme,
                                                                  '') ==
                                                              'abstrait1') {
                                                            return Color(
                                                                0xFF370924);
                                                          } else if (valueOrDefault(
                                                                  currentUserDocument
                                                                      ?.currentheme,
                                                                  '') ==
                                                              'abstrait2') {
                                                            return Color(
                                                                0xFF370924);
                                                          } else if (valueOrDefault(
                                                                  currentUserDocument
                                                                      ?.currentheme,
                                                                  '') ==
                                                              'fleur') {
                                                            return Color(
                                                                0xFF370924);
                                                          } else {
                                                            return FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground;
                                                          }
                                                        }(),
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .secondary,
                                                      ),
                                                      fontSize: 14.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                              ),
                                            ].divide(SizedBox(height: 24.0)),
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              );
                            },
                            itemCount:
                                swipeableStackAffirmationRecordList.length,
                            controller: _model.swipeableStackController,
                            loop: true,
                            cardDisplayCount: 1,
                            scale: 0.9,
                            allowedSwipeDirection:
                                AllowedSwipeDirection.only(up: true),
                          );
                        },
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(),
                      child: Visibility(
                        visible: !valueOrDefault<bool>(
                            currentUserDocument?.accountfinished, false),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              32.0, 0.0, 32.0, 32.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  HapticFeedback.heavyImpact();
                                  await showModalBottomSheet(
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    enableDrag: false,
                                    context: context,
                                    builder: (context) {
                                      return GestureDetector(
                                        onTap: () {
                                          FocusScope.of(context).unfocus();
                                          FocusManager.instance.primaryFocus
                                              ?.unfocus();
                                        },
                                        child: Padding(
                                          padding:
                                              MediaQuery.viewInsetsOf(context),
                                          child: CategoryWidget(),
                                        ),
                                      );
                                    },
                                  ).then((value) => safeSetState(() {}));
                                },
                                child: Material(
                                  color: Colors.transparent,
                                  elevation: 2.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100.0),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      boxShadow: [
                                        BoxShadow(
                                          color: FlutterFlowTheme.of(context)
                                              .secondary,
                                          offset: Offset(
                                            3.0,
                                            4.0,
                                          ),
                                        )
                                      ],
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                      border: Border.all(
                                        width: 1.0,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 12.0, 12.0, 12.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Icon(
                                            Icons.apps_outlined,
                                            color: FlutterFlowTheme.of(context)
                                                .secondary,
                                            size: 25.0,
                                          ),
                                        ].divide(SizedBox(width: 8.0)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  context.pushNamed(
                                    PratiqueWidget.routeName,
                                    extra: <String, dynamic>{
                                      '__transition_info__': TransitionInfo(
                                        hasTransition: true,
                                        transitionType: PageTransitionType.fade,
                                        duration: Duration(milliseconds: 0),
                                      ),
                                    },
                                  );
                                },
                                child: Material(
                                  color: Colors.transparent,
                                  elevation: 2.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100.0),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      boxShadow: [
                                        BoxShadow(
                                          color: FlutterFlowTheme.of(context)
                                              .secondary,
                                          offset: Offset(
                                            3.0,
                                            4.0,
                                          ),
                                        )
                                      ],
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                      border: Border.all(
                                        width: 1.0,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 12.0, 12.0, 12.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          FaIcon(
                                            FontAwesomeIcons.spa,
                                            color: FlutterFlowTheme.of(context)
                                                .secondary,
                                            size: 23.0,
                                          ),
                                        ].divide(SizedBox(width: 8.0)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
