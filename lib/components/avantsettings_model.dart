import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'avantsettings_widget.dart' show AvantsettingsWidget;
import 'package:flutter/material.dart';

class AvantsettingsModel extends FlutterFlowModel<AvantsettingsWidget> {
  ///  Local state fields for this component.

  String? visitoday;

  String? visihier;

  List<CategoryRecord> categoryapp = [];
  void addToCategoryapp(CategoryRecord item) => categoryapp.add(item);
  void removeFromCategoryapp(CategoryRecord item) => categoryapp.remove(item);
  void removeAtIndexFromCategoryapp(int index) => categoryapp.removeAt(index);
  void insertAtIndexInCategoryapp(int index, CategoryRecord item) =>
      categoryapp.insert(index, item);
  void updateCategoryappAtIndex(int index, Function(CategoryRecord) updateFn) =>
      categoryapp[index] = updateFn(categoryapp[index]);

  String widgetPreviewText = 'affirmazion';

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Firestore Query - Query a collection] action in avantsettings widget.
  CheckinsRecord? today;
  // Stores action output result for [Firestore Query - Query a collection] action in avantsettings widget.
  CheckinsRecord? hier;
  // Stores action output result for [Custom Action - changeWidgetAffirmation] action in avantsettings widget.
  String? changeWidgetAffirmation2;
  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // Stores action output result for [Custom Action - changeWidgetAffirmation] action in Text widget.
  String? changeWidgetAffirmation;
  // Stores action output result for [Custom Action - changeWidgetAffirmation] action in Container widget.
  String? change1;
  // Stores action output result for [Custom Action - changeWidgetAffirmation] action in Container widget.
  String? change2;
  // Stores action output result for [Custom Action - changeWidgetAffirmation] action in Container widget.
  String? change3;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
