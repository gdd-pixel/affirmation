import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'anim1_model.dart';
export 'anim1_model.dart';

class Anim1Widget extends StatefulWidget {
  const Anim1Widget({super.key});

  @override
  State<Anim1Widget> createState() => _Anim1WidgetState();
}

class _Anim1WidgetState extends State<Anim1Widget> {
  late Anim1Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => Anim1Model());
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
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0.0, 50.0, 0.0, 0.0),
        child: Container(
          width: 200.0,
          height: 200.0,
          decoration: BoxDecoration(),
          child: Lottie.asset(
            'assets/jsons/Like.json',
            width: 200.0,
            height: 200.0,
            fit: BoxFit.contain,
            repeat: false,
            animate: true,
          ),
        ),
      ),
    );
  }
}
