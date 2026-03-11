import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/avantsettings_widget.dart';
import '/components/category_widget.dart';
import '/components/paywall_widget.dart';
import '/components/themepop_widget.dart';
import '/flutter_flow/flutter_flow_swipeable_stack.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_toggle_icon.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.isliked = false;
      safeSetState(() {});
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
                                    borderRadius: BorderRadius.circular(100.0),
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
                                  borderRadius: BorderRadius.circular(100.0),
                                ),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
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
                                    Icons.person_outlined,
                                    color:
                                        FlutterFlowTheme.of(context).secondary,
                                    size: 20.0,
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
                                    borderRadius: BorderRadius.circular(100.0),
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
                              _model.isliked = false;
                              safeSetState(() {});
                            },
                            onLeftSwipe: (swipeableStackIndex) {},
                            onRightSwipe: (swipeableStackIndex) {},
                            onUpSwipe: (swipeableStackIndex) {},
                            onDownSwipe: (swipeableStackIndex) {},
                            itemBuilder: (context, swipeableStackIndex) {
                              final swipeableStackAffirmationRecord =
                                  swipeableStackAffirmationRecordList[
                                      swipeableStackIndex];
                              return Container(
                                decoration: BoxDecoration(),
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Text(
                                        swipeableStackAffirmationRecord.text,
                                        textAlign: TextAlign.center,
                                        style: FlutterFlowTheme.of(context)
                                            .headlineLarge
                                            .override(
                                              font: GoogleFonts.interTight(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .headlineLarge
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .headlineLarge
                                                        .fontStyle,
                                              ),
                                              color: () {
                                                if (valueOrDefault(
                                                        currentUserDocument
                                                            ?.currentheme,
                                                        '') ==
                                                    'base1') {
                                                  return FlutterFlowTheme.of(
                                                          context)
                                                      .secondary;
                                                } else if (valueOrDefault(
                                                        currentUserDocument
                                                            ?.currentheme,
                                                        '') ==
                                                    'base2') {
                                                  return FlutterFlowTheme.of(
                                                          context)
                                                      .primary;
                                                } else {
                                                  return FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground;
                                                }
                                              }(),
                                              fontSize: 25.0,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineLarge
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineLarge
                                                      .fontStyle,
                                            ),
                                      ),
                                    ),
                                    Stack(
                                      children: [
                                        Align(
                                          alignment:
                                              AlignmentDirectional(0.0, 1.0),
                                          child: ToggleIcon(
                                            onPressed: () async {
                                              safeSetState(() => _model
                                                  .isliked = !_model.isliked);

                                              await FavoritesRecord.createDoc(
                                                      currentUserReference!)
                                                  .set(
                                                      createFavoritesRecordData(
                                                affirmationRef:
                                                    swipeableStackAffirmationRecord
                                                        .reference,
                                                createdAt: getCurrentTimestamp,
                                                text:
                                                    swipeableStackAffirmationRecord
                                                        .text,
                                              ));
                                            },
                                            value: _model.isliked,
                                            onIcon: Icon(
                                              Icons.favorite,
                                              color: () {
                                                if (valueOrDefault(
                                                        currentUserDocument
                                                            ?.currentheme,
                                                        '') ==
                                                    'base1') {
                                                  return FlutterFlowTheme.of(
                                                          context)
                                                      .secondary;
                                                } else if (valueOrDefault(
                                                        currentUserDocument
                                                            ?.currentheme,
                                                        '') ==
                                                    'base2') {
                                                  return FlutterFlowTheme.of(
                                                          context)
                                                      .primary;
                                                } else {
                                                  return FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground;
                                                }
                                              }(),
                                              size: 30.0,
                                            ),
                                            offIcon: Icon(
                                              Icons.favorite_border,
                                              color: () {
                                                if (valueOrDefault(
                                                        currentUserDocument
                                                            ?.currentheme,
                                                        '') ==
                                                    'base1') {
                                                  return FlutterFlowTheme.of(
                                                          context)
                                                      .secondary;
                                                } else if (valueOrDefault(
                                                        currentUserDocument
                                                            ?.currentheme,
                                                        '') ==
                                                    'base2') {
                                                  return FlutterFlowTheme.of(
                                                          context)
                                                      .primary;
                                                } else {
                                                  return FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground;
                                                }
                                              }(),
                                              size: 30.0,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
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
                                    borderRadius: BorderRadius.circular(100.0),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 12.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Icon(
                                          Icons.apps,
                                          color: FlutterFlowTheme.of(context)
                                              .secondary,
                                          size: 20.0,
                                        ),
                                        Text(
                                          'Catégories',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.raleway(
                                                  fontWeight: FontWeight.w300,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w300,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
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
                                    borderRadius: BorderRadius.circular(100.0),
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
                                          size: 20.0,
                                        ),
                                        Text(
                                          'Pratique',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.raleway(
                                                  fontWeight: FontWeight.w300,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w300,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
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
