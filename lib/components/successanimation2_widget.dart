import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'successanimation2_model.dart';
export 'successanimation2_model.dart';

class Successanimation2Widget extends StatefulWidget {
  const Successanimation2Widget({super.key});

  @override
  State<Successanimation2Widget> createState() =>
      _Successanimation2WidgetState();
}

class _Successanimation2WidgetState extends State<Successanimation2Widget> {
  late Successanimation2Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => Successanimation2Model());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
