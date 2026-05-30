import '/flutter_flow/flutter_flow_util.dart';
import 'swipe_page_own_widget.dart' show SwipePageOwnWidget;
import 'package:flutter/material.dart';

class SwipePageOwnModel extends FlutterFlowModel<SwipePageOwnWidget> {
  ///  Local state fields for this page.

  bool isliked = false;

  ///  State fields for stateful widgets in this page.

  // State field(s) for PageViewgang widget.
  PageController? pageViewgangController;

  int get pageViewgangCurrentIndex => pageViewgangController != null &&
          pageViewgangController!.hasClients &&
          pageViewgangController!.page != null
      ? pageViewgangController!.page!.round()
      : 0;
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
