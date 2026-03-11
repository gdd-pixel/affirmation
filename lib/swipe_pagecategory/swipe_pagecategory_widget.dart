import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/components/category_widget.dart';
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
import 'swipe_pagecategory_model.dart';
export 'swipe_pagecategory_model.dart';

class SwipePagecategoryWidget extends StatefulWidget {
  const SwipePagecategoryWidget({
    super.key,
    String? catname,
    required this.cate,
  }) : this.catname = catname ?? 'Zen';

  final String catname;
  final Category? cate;

  static String routeName = 'swipePagecategory';
  static String routePath = '/swipePagecategory';

  @override
  State<SwipePagecategoryWidget> createState() =>
      _SwipePagecategoryWidgetState();
}

class _SwipePagecategoryWidgetState extends State<SwipePagecategoryWidget> {
  late SwipePagecategoryModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SwipePagecategoryModel());

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
      builder: (context) => GestureDetector(
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
              } else if (valueOrDefault(currentUserDocument?.currentheme, '') ==
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
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 64.0, 16.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              context.safePop();
                            },
                            child: Icon(
                              Icons.arrow_back_sharp,
                              color: valueOrDefault<Color>(
                                () {
                                  if (valueOrDefault(
                                          currentUserDocument?.currentheme,
                                          '') ==
                                      'base1') {
                                    return FlutterFlowTheme.of(context)
                                        .secondary;
                                  } else if (valueOrDefault(
                                          currentUserDocument?.currentheme,
                                          '') ==
                                      'base2') {
                                    return FlutterFlowTheme.of(context).primary;
                                  } else {
                                    return FlutterFlowTheme.of(context)
                                        .secondaryBackground;
                                  }
                                }(),
                                FlutterFlowTheme.of(context).secondary,
                              ),
                              size: 24.0,
                            ),
                          ),
                        ),
                        Text(
                          widget.catname,
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: 'Sniglet',
                                color: valueOrDefault<Color>(
                                  () {
                                    if (valueOrDefault(
                                            currentUserDocument?.currentheme,
                                            '') ==
                                        'base1') {
                                      return FlutterFlowTheme.of(context)
                                          .secondary;
                                    } else if (valueOrDefault(
                                            currentUserDocument?.currentheme,
                                            '') ==
                                        'base2') {
                                      return FlutterFlowTheme.of(context)
                                          .primary;
                                    } else {
                                      return FlutterFlowTheme.of(context)
                                          .secondaryBackground;
                                    }
                                  }(),
                                  FlutterFlowTheme.of(context).secondary,
                                ),
                                fontSize: 20.0,
                                letterSpacing: 0.0,
                              ),
                        ),
                      ].divide(SizedBox(width: 40.0)),
                    ),
                  ),
                ),
                Expanded(
                  child: StreamBuilder<List<AffirmationRecord>>(
                    stream: queryAffirmationRecord(
                      queryBuilder: (affirmationRecord) =>
                          affirmationRecord.where(
                        'category',
                        isEqualTo: widget.cate?.serialize(),
                      ),
                      limit: 100,
                    ),
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
                          swipeableStackAffirmationRecordList = snapshot.data!;

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
                                    valueOrDefault<String>(
                                      swipeableStackAffirmationRecord.text,
                                      'text',
                                    ),
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
                                          color: valueOrDefault<Color>(
                                            () {
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
                                            FlutterFlowTheme.of(context)
                                                .secondary,
                                          ),
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
                                      alignment: AlignmentDirectional(0.0, 1.0),
                                      child: ToggleIcon(
                                        onPressed: () async {
                                          safeSetState(() =>
                                              _model.isliked = !_model.isliked);
                                        },
                                        value: _model.isliked,
                                        onIcon: Icon(
                                          Icons.favorite,
                                          color: valueOrDefault<Color>(
                                            () {
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
                                            FlutterFlowTheme.of(context)
                                                .secondary,
                                          ),
                                          size: 30.0,
                                        ),
                                        offIcon: Icon(
                                          Icons.favorite_border,
                                          color: valueOrDefault<Color>(
                                            () {
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
                                            FlutterFlowTheme.of(context)
                                                .secondary,
                                          ),
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
                        itemCount: swipeableStackAffirmationRecordList.length,
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
                    padding:
                        EdgeInsetsDirectional.fromSTEB(32.0, 0.0, 32.0, 32.0),
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
                                    padding: MediaQuery.viewInsetsOf(context),
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
                                      size: 24.0,
                                    ),
                                    Text(
                                      'Catégories',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Sniglet',
                                            color: FlutterFlowTheme.of(context)
                                                .secondary,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
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
                            context.pushNamed(PratiqueWidget.routeName);
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
                                      size: 24.0,
                                    ),
                                    Text(
                                      'Pratique',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Sniglet',
                                            color: FlutterFlowTheme.of(context)
                                                .secondary,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
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
      ),
    );
  }
}
