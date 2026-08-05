import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'succeesanimationtwo_model.dart';
export 'succeesanimationtwo_model.dart';

class SucceesanimationtwoWidget extends StatefulWidget {
  const SucceesanimationtwoWidget({super.key});

  @override
  State<SucceesanimationtwoWidget> createState() =>
      _SucceesanimationtwoWidgetState();
}

class _SucceesanimationtwoWidgetState extends State<SucceesanimationtwoWidget> {
  late SucceesanimationtwoModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SucceesanimationtwoModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0.0, -1.0),
      child: Container(
        width: 200.0,
        height: 200.0,
        decoration: BoxDecoration(),
        child: Lottie.asset(
          'assets/jsons/WxJp1qnras.json',
          width: 200.0,
          height: 200.0,
          fit: BoxFit.contain,
          animate: true,
        ),
      ),
    );
  }
}
