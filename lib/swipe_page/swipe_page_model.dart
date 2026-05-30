import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'swipe_page_widget.dart' show SwipePageWidget;
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class SwipePageModel extends FlutterFlowModel<SwipePageWidget> {
  ///  Local state fields for this page.

  bool isliked = false;

  int? onboardstep = 1;

  ///  State fields for stateful widgets in this page.

  // State field(s) for SwipeableStack widget.
  late CardSwiperController swipeableStackController;

  @override
  void initState(BuildContext context) {
    swipeableStackController = CardSwiperController();
  }

  @override
  void dispose() {}
}
