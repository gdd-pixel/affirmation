import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'swipe_page_cat_widget.dart' show SwipePageCatWidget;
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class SwipePageCatModel extends FlutterFlowModel<SwipePageCatWidget> {
  ///  Local state fields for this page.

  bool isliked = false;

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
