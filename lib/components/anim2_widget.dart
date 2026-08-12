import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'anim2_model.dart';
export 'anim2_model.dart';

class Anim2Widget extends StatefulWidget {
  const Anim2Widget({super.key});

  @override
  State<Anim2Widget> createState() => _Anim2WidgetState();
}

class _Anim2WidgetState extends State<Anim2Widget> {
  late Anim2Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => Anim2Model());
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
            'assets/jsons/WxJp1qnras.json',
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
