import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'avantsettings_widget.dart' show AvantsettingsWidget;
import 'package:flutter/material.dart';

class AvantsettingsModel extends FlutterFlowModel<AvantsettingsWidget> {
  ///  Local state fields for this component.

  String? visitoday;

  String? visihier;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Firestore Query - Query a collection] action in avantsettings widget.
  CheckinsRecord? today;
  // Stores action output result for [Firestore Query - Query a collection] action in avantsettings widget.
  CheckinsRecord? hier;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
