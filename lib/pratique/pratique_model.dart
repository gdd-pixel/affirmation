import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'pratique_widget.dart' show PratiqueWidget;
import 'package:flutter/material.dart';

class PratiqueModel extends FlutterFlowModel<PratiqueWidget> {
  ///  Local state fields for this page.

  List<String> affirlist = ['Hello World', 'Hello World', 'Hello World'];
  void addToAffirlist(String item) => affirlist.add(item);
  void removeFromAffirlist(String item) => affirlist.remove(item);
  void removeAtIndexFromAffirlist(int index) => affirlist.removeAt(index);
  void insertAtIndexInAffirlist(int index, String item) =>
      affirlist.insert(index, item);
  void updateAffirlistAtIndex(int index, Function(String) updateFn) =>
      affirlist[index] = updateFn(affirlist[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in pratique widget.
  List<AffirmationRecord>? affi;
  // Stores action output result for [Firestore Query - Query a collection] action in pratique widget.
  CheckinsRecord? dato;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
