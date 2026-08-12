import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'inscription_widget.dart' show InscriptionWidget;
import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

class InscriptionModel extends FlutterFlowModel<InscriptionWidget> {
  ///  Local state fields for this page.

  int? etape = 0;

  String? themeselected = 'base1';

  String? prenom = 'prenom';

  bool? respifini = false;

  int? q3 = 0;

  int? q4 = 0;

  int? q6 = 0;

  int? q7 = 0;

  int q9 = 0;

  int? q10 = 0;

  int? q14 = 0;

  int? q15 = 0;

  int? q16 = 0;

  int? q17 = 0;

  int? q18 = 0;

  bool? isclick = true;

  int? etapereach = 0;

  List<Soujets> q19 = [];
  void addToQ19(Soujets item) => q19.add(item);
  void removeFromQ19(Soujets item) => q19.remove(item);
  void removeAtIndexFromQ19(int index) => q19.removeAt(index);
  void insertAtIndexInQ19(int index, Soujets item) => q19.insert(index, item);
  void updateQ19AtIndex(int index, Function(Soujets) updateFn) =>
      q19[index] = updateFn(q19[index]);

  int? q2 = 0;

  int? q40 = 0;

  int? q41 = 0;

  int? q42 = 0;

  int? q43 = 0;

  int? q44 = 0;

  bool? canclickas = false;

  double? planevol = 0.0;

  bool? darkmodel = false;

  ///  State fields for stateful widgets in this page.

  // State field(s) for Paywally widget.
  PageController? paywallyController;

  int get paywallyCurrentIndex => paywallyController != null &&
          paywallyController!.hasClients &&
          paywallyController!.page != null
      ? paywallyController!.page!.round()
      : 0;
  // State field(s) for TextFieldprenom widget.
  FocusNode? textFieldprenomFocusNode;
  TextEditingController? textFieldprenomTextController;
  String? Function(BuildContext, String?)?
      textFieldprenomTextControllerValidator;
  // State field(s) for CountController widget.
  int? countControllerValue;
  DateTime? datePicked1;
  DateTime? datePicked2;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  // State field(s) for Slider widget.
  double? sliderValue;
  // State field(s) for Signature widget.
  SignatureController? signatureController;
  // State field(s) for RatingBar widget.
  double? ratingBarValue2;
  // State field(s) for Switch widget.
  bool? switchValue1;
  // State field(s) for Switch widget.
  bool? switchValue2;
  // Stores action output result for [RevenueCat - Purchase] action in Container widget.
  bool? dadpurchase;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldprenomFocusNode?.dispose();
    textFieldprenomTextController?.dispose();

    textFieldFocusNode?.dispose();
    textController2?.dispose();

    signatureController?.dispose();
  }
}
