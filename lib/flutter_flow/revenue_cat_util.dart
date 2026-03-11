import 'dart:io' show Platform;
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';

export 'package:purchases_flutter/purchases_flutter.dart'
    show Package, Offering;

Offerings? _offerings;
CustomerInfo? _customerInfo;
String? _loggedInUid;
bool _isConfigured = false;

Offerings? get offerings => _offerings;
CustomerInfo? get customerInfo => _customerInfo;
bool get isConfigured => _isConfigured;

set customerInfo(CustomerInfo? customerInfo) => _customerInfo = customerInfo;

Future initialize(
  String appStoreKey,
  String playStoreKey, {
  String webKey = '',
  bool debugLogEnabled = false,
  bool loadDataAfterLaunch = false,
}) async {
  try {
    // Set log level before configuration
    await Purchases.setLogLevel(
      debugLogEnabled ? LogLevel.debug : LogLevel.info,
    );

    // Configure based on platform
    PurchasesConfiguration configuration;
    if (kIsWeb) {
      if (webKey.isEmpty) {
        print(
          'RevenueCat web support requires a web API key. '
          'RevenueCat features will be disabled in Test Mode.',
        );
        return;
      }
      configuration = PurchasesConfiguration(webKey);
    } else if (Platform.isIOS) {
      configuration = PurchasesConfiguration(appStoreKey);
    } else if (Platform.isAndroid) {
      configuration = PurchasesConfiguration(playStoreKey);
    } else {
      print("RevenueCat is not supported on this platform.");
      return;
    }

    await Purchases.configure(configuration);
    _isConfigured = true;

    if (loadDataAfterLaunch) {
      loadCustomerInfo();
      loadOfferings();
    } else {
      await loadCustomerInfo();
      await loadOfferings();
    }

    Purchases.addCustomerInfoUpdateListener((info) {
      customerInfo = info;
    });
  } on Exception catch (e) {
    print("RevenueCat initialization failed: $e");
  }
}

// Purchase a package.
Future<bool> purchasePackage(String package) async {
  if (!_isConfigured) {
    print('RevenueCat is not configured. Cannot purchase package.');
    return false;
  }
  try {
    final revenueCatPackage = offerings?.current?.getPackage(package);
    if (revenueCatPackage == null) {
      return false;
    }
    // v9.0+: purchasePackage returns PurchaseResult instead of CustomerInfo
    final result = await Purchases.purchasePackage(revenueCatPackage);
    customerInfo = result.customerInfo;
    return true;
  } catch (_) {
    return false;
  }
}

List<String> get activeEntitlementIds => _customerInfo != null
    ? _customerInfo!.entitlements.active.values
        .map((e) => e.identifier)
        .toList()
    : [];

Future loadOfferings() async {
  if (!_isConfigured) {
    return;
  }
  try {
    _offerings = await Purchases.getOfferings();
  } on PlatformException catch (e) {
    print("Error loading offerings info: $e");
  }
}

Future loadCustomerInfo() async {
  if (!_isConfigured) {
    return;
  }
  try {
    _customerInfo = await Purchases.getCustomerInfo();
  } on PlatformException catch (e) {
    print("Error loading purchaser info: $e");
  }
}

// Return if the user has the entitlement.
// Return null on errors.
// Returns false if RevenueCat is not configured (e.g., no web billing key in Test Mode).
Future<bool?> isEntitled(String entitlementId) async {
  if (!_isConfigured) {
    // Return false instead of null to indicate no entitlement when unconfigured.
    // This allows Test Mode to work without a web billing key.
    return false;
  }
  try {
    customerInfo = await Purchases.getCustomerInfo();
    return customerInfo!.entitlements.all[entitlementId]?.isActive ?? false;
  } on Exception catch (e) {
    print("Unable to check RevenueCat entitlements: $e");
    return null;
  }
}

// https://docs.revenuecat.com/docs/user-ids
Future login(String? uid) async {
  if (!_isConfigured) {
    return;
  }
  if (uid == _loggedInUid) {
    return;
  }
  try {
    if (uid != null) {
      customerInfo = (await Purchases.logIn(uid)).customerInfo;
    } else {
      customerInfo = await Purchases.logOut();
    }
    _loggedInUid = uid;
  } on Exception catch (e) {
    print("Unable to logIn or logOut user in RevenueCat: $e");
  }
}

// https://docs.revenuecat.com/docs/restoring-purchases
Future restorePurchases() async {
  if (!_isConfigured) {
    return;
  }
  // Note: On web, purchases are automatically restored by Web Billing.
  // This method is only needed for iOS/Android.
  if (kIsWeb) {
    print(
      'Restore purchases is not needed on web - Web Billing handles this automatically.',
    );
    return;
  }
  try {
    customerInfo = await Purchases.restorePurchases();
  } on PlatformException catch (e) {
    print("Unable to restore purchases in RevenueCat: $e");
  }
}
