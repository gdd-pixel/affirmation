// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:firebase_messaging/firebase_messaging.dart';

Future handlePushNavigation(BuildContext context) async {
  // Cas 1 : app ouverte depuis état complètement fermé
  final initialMessage = await FirebaseMessaging.instance.getInitialMessage();

  if (initialMessage != null) {
    final targetPage = initialMessage.data['targetPage'];

    if (targetPage == 'paywallpromo') {
      context.pushNamed('paywallpromo');
      return;
    }
  }

  // Cas 2 : app déjà ouverte en arrière-plan, puis notif cliquée
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    final targetPage = message.data['targetPage'];

    if (targetPage == 'paywallpromo') {
      context.pushNamed('paywallpromo');
    }
  });
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
