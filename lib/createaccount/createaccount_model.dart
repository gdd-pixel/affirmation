import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'createaccount_widget.dart' show CreateaccountWidget;
import 'package:flutter/material.dart';

class CreateaccountModel extends FlutterFlowModel<CreateaccountWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for TextFieldnom widget.
  FocusNode? textFieldnomFocusNode;
  TextEditingController? textFieldnomTextController;
  String? Function(BuildContext, String?)? textFieldnomTextControllerValidator;
  // State field(s) for TextFieldmail widget.
  FocusNode? textFieldmailFocusNode;
  TextEditingController? textFieldmailTextController;
  String? Function(BuildContext, String?)? textFieldmailTextControllerValidator;
  // State field(s) for TextFieldMDP1 widget.
  FocusNode? textFieldMDP1FocusNode;
  TextEditingController? textFieldMDP1TextController;
  late bool textFieldMDP1Visibility;
  String? Function(BuildContext, String?)? textFieldMDP1TextControllerValidator;
  // State field(s) for TextFieldMDP2 widget.
  FocusNode? textFieldMDP2FocusNode;
  TextEditingController? textFieldMDP2TextController;
  late bool textFieldMDP2Visibility;
  String? Function(BuildContext, String?)? textFieldMDP2TextControllerValidator;

  @override
  void initState(BuildContext context) {
    textFieldMDP1Visibility = false;
    textFieldMDP2Visibility = false;
  }

  @override
  void dispose() {
    textFieldnomFocusNode?.dispose();
    textFieldnomTextController?.dispose();

    textFieldmailFocusNode?.dispose();
    textFieldmailTextController?.dispose();

    textFieldMDP1FocusNode?.dispose();
    textFieldMDP1TextController?.dispose();

    textFieldMDP2FocusNode?.dispose();
    textFieldMDP2TextController?.dispose();
  }
}
