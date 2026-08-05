import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'successanimation_model.dart';
export 'successanimation_model.dart';

class SuccessanimationWidget extends StatefulWidget {
  const SuccessanimationWidget({super.key});

  @override
  State<SuccessanimationWidget> createState() => _SuccessanimationWidgetState();
}

class _SuccessanimationWidgetState extends State<SuccessanimationWidget> {
  late SuccessanimationModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SuccessanimationModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
