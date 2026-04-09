import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'createaccount_model.dart';
export 'createaccount_model.dart';

/// Create a Signup Page for a daily affirmation app (calm, minimalist).
///
/// Style: light cream #FAF7F2, lavender #7C6CF2, rounded 24.
/// Include:
///
/// Logo + title “Create your account”, subtitle “Positive affirmations every
/// day.”
///
/// Fields: Name, Email, Password, Confirm Password.
///
/// Primary button: Create account.
///
/// Divider “or”.
///
/// Social buttons: Continue with Google, Continue with Apple.
///
/// Footer: “Already have an account? Sign in” → /login.
///
/// Behavior:
///
/// Validation: email format, password ≥ 8 chars with confirm match, terms
/// required.
///
/// Disable submit when invalid; show loader on sub
///
/// Firebase Auth: Email/Password signup; handle errors (email-in-use,
/// weak-password, network).
///
/// On success: create user profile doc (users/{uid}: displayName, email,
/// locale, createdAt), toast “Welcome ✨”, navigate → /onboarding (fallback
/// /home).
///
/// Optional: send email verification; show notice if not verified.
///
/// Accessibility & UX: AA contrast, real labels (not only placeholders), tap
/// targets ≥ 44px, light/dark mode, responsive.
class CreateaccountWidget extends StatefulWidget {
  const CreateaccountWidget({super.key});

  static String routeName = 'createaccount';
  static String routePath = '/createaccount';

  @override
  State<CreateaccountWidget> createState() => _CreateaccountWidgetState();
}

class _CreateaccountWidgetState extends State<CreateaccountWidget> {
  late CreateaccountModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CreateaccountModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'createaccount'});
    _model.textFieldnomTextController ??= TextEditingController();
    _model.textFieldnomFocusNode ??= FocusNode();

    _model.textFieldmailTextController ??= TextEditingController();
    _model.textFieldmailFocusNode ??= FocusNode();

    _model.textFieldMDP1TextController ??= TextEditingController();
    _model.textFieldMDP1FocusNode ??= FocusNode();

    _model.textFieldMDP2TextController ??= TextEditingController();
    _model.textFieldMDP2FocusNode ??= FocusNode();
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
        backgroundColor: Color(0xFFFAF7F2),
        body: SafeArea(
          top: true,
          child: Align(
            alignment: AlignmentDirectional(0.0, 0.0),
            child: Container(
              width: MediaQuery.sizeOf(context).width * 1.0,
              height: MediaQuery.sizeOf(context).height * 1.0,
              constraints: BoxConstraints(
                maxWidth: 430.0,
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: 80.0,
                            height: 80.0,
                            decoration: BoxDecoration(
                              color: Color(0xFF7C6CF2),
                              shape: BoxShape.circle,
                            ),
                            child: Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Icon(
                                Icons.self_improvement,
                                color: Color(0xFFFAF7F2),
                                size: 40.0,
                              ),
                            ),
                          ),
                          Text(
                            'Create your account',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .headlineLarge
                                .override(
                                  font: GoogleFonts.interTight(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .headlineLarge
                                        .fontStyle,
                                  ),
                                  color: Color(0xFF2D2D2D),
                                  fontSize: 28.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .headlineLarge
                                      .fontStyle,
                                ),
                          ),
                          Text(
                            'Positive affirmations every day.',
                            textAlign: TextAlign.center,
                            style:
                                FlutterFlowTheme.of(context).bodyLarge.override(
                                      fontFamily: 'Sniglet',
                                      color: Color(0xFF6B6B6B),
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      lineHeight: 1.4,
                                    ),
                          ),
                        ].divide(SizedBox(height: 16.0)),
                      ),
                      Form(
                        key: _model.formKey,
                        autovalidateMode: AutovalidateMode.disabled,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            TextFormField(
                              controller: _model.textFieldnomTextController,
                              focusNode: _model.textFieldnomFocusNode,
                              autofocus: false,
                              textCapitalization: TextCapitalization.words,
                              textInputAction: TextInputAction.next,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Full Name',
                                labelStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Sniglet',
                                      color: Color(0xFF6B6B6B),
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                    ),
                                hintText: 'Enter your full name',
                                hintStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Sniglet',
                                      color: Color(0xFF9E9E9E),
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                    ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFE5E5E5),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(24.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF7C6CF2),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(24.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFFF4444),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(24.0),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFFF4444),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(24.0),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 16.0, 20.0, 16.0),
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Sniglet',
                                    color: Color(0xFF2D2D2D),
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                  ),
                              keyboardType: TextInputType.name,
                              validator: _model
                                  .textFieldnomTextControllerValidator
                                  .asValidator(context),
                              inputFormatters: [
                                if (!isAndroid && !isiOS)
                                  TextInputFormatter.withFunction(
                                      (oldValue, newValue) {
                                    return TextEditingValue(
                                      selection: newValue.selection,
                                      text: newValue.text.toCapitalization(
                                          TextCapitalization.words),
                                    );
                                  }),
                              ],
                            ),
                            TextFormField(
                              controller: _model.textFieldmailTextController,
                              focusNode: _model.textFieldmailFocusNode,
                              autofocus: false,
                              textInputAction: TextInputAction.next,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Email Address',
                                labelStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Sniglet',
                                      color: Color(0xFF6B6B6B),
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                    ),
                                hintText: 'Enter your email address',
                                hintStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Sniglet',
                                      color: Color(0xFF9E9E9E),
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                    ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFE5E5E5),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(24.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF7C6CF2),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(24.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFFF4444),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(24.0),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFFF4444),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(24.0),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 16.0, 20.0, 16.0),
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Sniglet',
                                    color: Color(0xFF2D2D2D),
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                  ),
                              keyboardType: TextInputType.emailAddress,
                              validator: _model
                                  .textFieldmailTextControllerValidator
                                  .asValidator(context),
                            ),
                            TextFormField(
                              controller: _model.textFieldMDP1TextController,
                              focusNode: _model.textFieldMDP1FocusNode,
                              autofocus: false,
                              textInputAction: TextInputAction.next,
                              obscureText: !_model.textFieldMDP1Visibility,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                labelStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Sniglet',
                                      color: Color(0xFF6B6B6B),
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                    ),
                                hintText: 'Enter your password',
                                hintStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Sniglet',
                                      color: Color(0xFF9E9E9E),
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                    ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFE5E5E5),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(24.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF7C6CF2),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(24.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFFF4444),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(24.0),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFFF4444),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(24.0),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 16.0, 20.0, 16.0),
                                suffixIcon: InkWell(
                                  onTap: () async {
                                    safeSetState(() =>
                                        _model.textFieldMDP1Visibility =
                                            !_model.textFieldMDP1Visibility);
                                  },
                                  focusNode: FocusNode(skipTraversal: true),
                                  child: Icon(
                                    _model.textFieldMDP1Visibility
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    size: 22,
                                  ),
                                ),
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Sniglet',
                                    color: Color(0xFF2D2D2D),
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                  ),
                              validator: _model
                                  .textFieldMDP1TextControllerValidator
                                  .asValidator(context),
                            ),
                            TextFormField(
                              controller: _model.textFieldMDP2TextController,
                              focusNode: _model.textFieldMDP2FocusNode,
                              autofocus: false,
                              textInputAction: TextInputAction.next,
                              obscureText: !_model.textFieldMDP2Visibility,
                              decoration: InputDecoration(
                                labelText: 'Confirm Password',
                                labelStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Sniglet',
                                      color: Color(0xFF6B6B6B),
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                    ),
                                hintText: 'Confirm your password',
                                hintStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Sniglet',
                                      color: Color(0xFF9E9E9E),
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                    ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFE5E5E5),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(24.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF7C6CF2),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(24.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFFF4444),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(24.0),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFFF4444),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(24.0),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 16.0, 20.0, 16.0),
                                suffixIcon: InkWell(
                                  onTap: () async {
                                    safeSetState(() =>
                                        _model.textFieldMDP2Visibility =
                                            !_model.textFieldMDP2Visibility);
                                  },
                                  focusNode: FocusNode(skipTraversal: true),
                                  child: Icon(
                                    _model.textFieldMDP2Visibility
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    size: 22,
                                  ),
                                ),
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Sniglet',
                                    color: Color(0xFF2D2D2D),
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                  ),
                              validator: _model
                                  .textFieldMDP2TextControllerValidator
                                  .asValidator(context),
                            ),
                          ].divide(SizedBox(height: 20.0)),
                        ),
                      ),
                      FFButtonWidget(
                        onPressed: () {
                          print('Button pressed ...');
                        },
                        text: 'Create Account',
                        options: FFButtonOptions(
                          width: double.infinity,
                          height: 56.0,
                          padding: EdgeInsets.all(8.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: Color(0xFF7C6CF2),
                          textStyle:
                              FlutterFlowTheme.of(context).titleMedium.override(
                                    font: GoogleFonts.interTight(
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontStyle,
                                    ),
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                  ),
                          elevation: 0.0,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 80.0,
                            height: 1.0,
                            decoration: BoxDecoration(
                              color: Color(0xFFE5E5E5),
                            ),
                          ),
                          Text(
                            'or',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Sniglet',
                                  color: Color(0xFF9E9E9E),
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                ),
                          ),
                          Container(
                            width: 80.0,
                            height: 1.0,
                            decoration: BoxDecoration(
                              color: Color(0xFFE5E5E5),
                            ),
                          ),
                        ].divide(SizedBox(width: 16.0)),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          FFButtonWidget(
                            onPressed: () {
                              print('Button pressed ...');
                            },
                            text: 'Continue with Apple',
                            icon: Icon(
                              Icons.apple,
                              size: 20.0,
                            ),
                            options: FFButtonOptions(
                              width: double.infinity,
                              height: 56.0,
                              padding: EdgeInsets.all(8.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              iconColor: Colors.black,
                              color: Colors.white,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .override(
                                    font: GoogleFonts.interTight(
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontStyle,
                                    ),
                                    color: Color(0xFF2D2D2D),
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                  ),
                              elevation: 0.0,
                              borderSide: BorderSide(
                                color: Color(0xFFE5E5E5),
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                          ),
                        ].divide(SizedBox(height: 12.0)),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account?',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Sniglet',
                                  color: Color(0xFF6B6B6B),
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                ),
                          ),
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              logFirebaseEvent(
                                  'CREATEACCOUNT_PAGE_Text_tykbfu8g_ON_TAP');
                              logFirebaseEvent('Text_navigate_to');

                              context.pushNamed(Login1Widget.routeName);
                            },
                            child: Text(
                              'Sign in',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Sniglet',
                                    color: Color(0xFF7C6CF2),
                                    fontSize: 14.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                        ].divide(SizedBox(width: 4.0)),
                      ),
                    ]
                        .divide(SizedBox(height: 32.0))
                        .addToStart(SizedBox(height: 40.0))
                        .addToEnd(SizedBox(height: 32.0)),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
