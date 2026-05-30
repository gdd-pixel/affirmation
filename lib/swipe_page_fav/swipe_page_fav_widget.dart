import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'swipe_page_fav_model.dart';
export 'swipe_page_fav_model.dart';

class SwipePageFavWidget extends StatefulWidget {
  const SwipePageFavWidget({super.key});

  static String routeName = 'swipePageFav';
  static String routePath = '/swipePageFav';

  @override
  State<SwipePageFavWidget> createState() => _SwipePageFavWidgetState();
}

class _SwipePageFavWidgetState extends State<SwipePageFavWidget> {
  late SwipePageFavModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SwipePageFavModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'swipePageFav'});
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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primary,
        body: AuthUserStreamWidget(
          builder: (context) => Container(
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).primary,
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
                              color: FlutterFlowTheme.of(context).secondary,
                              size: 30.0,
                            ),
                          ),
                        ),
                        Text(
                          'Mes favoris',
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: 'Motter Corpus',
                                color: FlutterFlowTheme.of(context).secondary,
                                fontSize: 20.0,
                                letterSpacing: 0.0,
                              ),
                        ),
                      ].divide(SizedBox(width: 16.0)),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 42.0),
                    child: Container(
                      width: double.infinity,
                      height: 400.0,
                      decoration: BoxDecoration(),
                      child: StreamBuilder<List<FavoritesRecord>>(
                        stream: queryFavoritesRecord(
                          parent: currentUserReference,
                          queryBuilder: (favoritesRecord) => favoritesRecord
                              .orderBy('createdAt', descending: true),
                          limit: 200,
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
                          List<FavoritesRecord> columnFavoritesRecordList =
                              snapshot.data!;

                          return SingleChildScrollView(
                            primary: false,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: List.generate(
                                  columnFavoritesRecordList.length,
                                  (columnIndex) {
                                final columnFavoritesRecord =
                                    columnFavoritesRecordList[columnIndex];
                                return Container(
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 12.0, 16.0, 12.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Align(
                                          alignment:
                                              AlignmentDirectional(-1.0, -1.0),
                                          child: Text(
                                            columnFavoritesRecord.text,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  font: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w500,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondary,
                                                  fontSize: 16.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 16.0, 0.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  dateTimeFormat(
                                                    "yMMMEd",
                                                    columnFavoritesRecord
                                                        .createdAt!,
                                                    locale: FFLocalizations.of(
                                                            context)
                                                        .languageCode,
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        font:
                                                            GoogleFonts.poppins(
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        color:
                                                            Color(0xFF3E3E40),
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                ),
                                                InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    await columnFavoritesRecord
                                                        .reference
                                                        .delete();
                                                  },
                                                  child: Icon(
                                                    Icons.favorite_rounded,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondary,
                                                    size: 24.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ].divide(SizedBox(height: 16.0)),
                                    ),
                                  ),
                                );
                              }).divide(SizedBox(height: 12.0)),
                            ),
                          );
                        },
                      ),
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
