import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'partique_widget.dart' show PartiqueWidget;
import 'package:flutter/material.dart';

class PartiqueModel extends FlutterFlowModel<PartiqueWidget> {
  ///  Local state fields for this page.

  bool isliked = false;

  String? currentext = 'cool';

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in partique widget.
  List<AffirmationRecord>? output;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
