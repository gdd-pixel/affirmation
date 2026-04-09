import 'package:flutter/foundation.dart';
import 'package:appsflyer_sdk/appsflyer_sdk.dart';

class AppsFlyerManager {
  static final AppsFlyerManager _instance = AppsFlyerManager._internal();
  factory AppsFlyerManager() => _instance;
  AppsFlyerManager._internal();

  AppsflyerSdk? _sdk;
  bool _isInitialized = false;

  static const String _devKey = '3j4WLGWY4T8SrWPUdVgbRf';

  Future<void> init() async {
    if (_isInitialized && _sdk != null) {
      debugPrint('AppsFlyer already initialized');
      return;
    }

    final options = AppsFlyerOptions(
      afDevKey: _devKey,
      showDebug: true,
      timeToWaitForATTUserAuthorization: 0,
    );

    _sdk = AppsflyerSdk(options);

    _sdk!.onInstallConversionData((data) {
      debugPrint('AppsFlyer conversion data: $data');
    });

    _sdk!.onAppOpenAttribution((data) {
      debugPrint('AppsFlyer app open attribution: $data');
    });

    _sdk!.onDeepLinking((deepLinkResult) {
      debugPrint('AppsFlyer deep link: $deepLinkResult');
    });

    await _sdk!.initSdk(
      registerConversionDataCallback: true,
      registerOnAppOpenAttributionCallback: true,
      registerOnDeepLinkingCallback: true,
    );

    _isInitialized = true;
    debugPrint('AppsFlyer initialized');
  }

  Future<void> logEvent(
    String eventName, {
    Map<String, dynamic>? values,
  }) async {
    if (!_isInitialized || _sdk == null) {
      await init();
    }

    await _sdk!.logEvent(eventName, values ?? {});
    debugPrint('AppsFlyer event sent: $eventName / ${values ?? {}}');
  }

  Future<void> trackOnboardingCompleted() async {
    await logEvent(
      'af_tutorial_completion',
      values: {
        'status': 'completed',
      },
    );
  }

  Future<void> trackOnboardingStep({
    required int step,
    required String stepName,
  }) async {
    await logEvent(
      'onboarding_progress',
      values: {
        'step': step,
        'step_name': stepName,
      },
    );
  }

  Future<void> trackPurchase({
    required double amount,
    required String currency,
    required String productId,
  }) async {
    await logEvent(
      'af_purchase',
      values: {
        'af_revenue': amount,
        'af_currency': currency,
        'af_content_id': productId,
      },
    );
  }
}
