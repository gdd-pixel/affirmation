import 'dart:io' show Platform;


import 'package:rxdart/subjects.dart';

import '../../auth/firebase_auth/auth_util.dart';
import '../cloud_functions/cloud_functions.dart';

import 'package:flutter/foundation.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

export 'push_notifications_handler.dart';
export 'serialization_util.dart';

class UserTokenInfo {
  const UserTokenInfo(this.userPath, this.fcmToken);
  final String userPath;
  final String fcmToken;
}

final kNotificationsBehaviorSubject = BehaviorSubject<bool>.seeded(true);

Stream<UserTokenInfo> getFcmTokenStream(String userPath) =>
    kNotificationsBehaviorSubject.stream
        .where((_) => !kIsWeb && (Platform.isIOS || Platform.isAndroid))
        .asyncMap<String?>((_) async {
          final settings =
              await FirebaseMessaging.instance.getNotificationSettings();
          if (settings.authorizationStatus == AuthorizationStatus.authorized) {
            return FirebaseMessaging.instance.getToken();
          }
          return null;
        })
        .switchMap((fcmToken) => Stream.value(fcmToken)
            .merge(FirebaseMessaging.instance.onTokenRefresh))
        .where((fcmToken) => fcmToken != null && fcmToken.isNotEmpty)
        .map((token) => UserTokenInfo(userPath, token!));

final fcmTokenUserStream = authenticatedUserStream
    .where((user) => user != null)
    .map((user) => user!.reference.path)
    .distinct()
    .switchMap(getFcmTokenStream)
    .map(
      (userTokenInfo) => makeCloudCall(
        'addFcmToken',
        {
          'userDocPath': userTokenInfo.userPath,
          'fcmToken': userTokenInfo.fcmToken,
          'deviceType': Platform.isIOS ? 'iOS' : 'Android',
        },
      ),
    );
