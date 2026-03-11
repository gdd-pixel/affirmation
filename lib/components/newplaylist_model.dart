import '/flutter_flow/flutter_flow_util.dart';
import 'newplaylist_widget.dart' show NewplaylistWidget;
import 'package:flutter/material.dart';

class NewplaylistModel extends FlutterFlowModel<NewplaylistWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
