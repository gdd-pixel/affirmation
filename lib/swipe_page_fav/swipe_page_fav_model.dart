import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'swipe_page_fav_widget.dart' show SwipePageFavWidget;
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class SwipePageFavModel extends FlutterFlowModel<SwipePageFavWidget> {
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
