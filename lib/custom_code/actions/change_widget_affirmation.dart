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

import 'dart:convert';
import 'dart:math';

import 'package:home_widget/home_widget.dart';

Future<String> changeWidgetAffirmation() async {
  // IMPORTANT :
  // Mets exactement le même App Group
  // que dans syncWidgetContent et dans Xcode.
  const String appGroupId = 'group.com.mycompany.affirmation';

  // Cette clé doit être identique à celle de syncWidgetContent
  // et du fichier Swift.
  const String storageKey = 'widget_content_json';

  try {
    await HomeWidget.setAppGroupId(appGroupId);

    // ------------------------------------------------------------
    // 1. Lire le JSON actuellement partagé avec le widget
    // ------------------------------------------------------------

    final String? jsonString = await HomeWidget.getWidgetData<String>(
      storageKey,
    );

    if (jsonString == null || jsonString.trim().isEmpty) {
      return 'error:no_widget_content';
    }

    final dynamic decodedJson = jsonDecode(jsonString);

    if (decodedJson is! Map<String, dynamic>) {
      return 'error:invalid_widget_content';
    }

    final Map<String, dynamic> payload = Map<String, dynamic>.from(decodedJson);

    // ------------------------------------------------------------
    // 2. Récupérer et nettoyer la liste des affirmations
    // ------------------------------------------------------------

    final dynamic rawAffirmations = payload['affirmations'];

    if (rawAffirmations is! List) {
      return 'error:no_affirmations';
    }

    final List<String> affirmations = rawAffirmations
        .whereType<String>()
        .map((text) => text.trim())
        .where((text) => text.isNotEmpty)
        .toSet()
        .toList();

    if (affirmations.isEmpty) {
      return 'error:no_affirmations';
    }

    // ------------------------------------------------------------
    // 3. Lire l’index actuellement affiché
    // ------------------------------------------------------------

    int currentIndex = 0;

    final dynamic rawCurrentIndex = payload['currentIndex'];

    if (rawCurrentIndex is int) {
      currentIndex = rawCurrentIndex;
    } else if (rawCurrentIndex is num) {
      currentIndex = rawCurrentIndex.toInt();
    }

    currentIndex = currentIndex % affirmations.length;

    // ------------------------------------------------------------
    // 4. Choisir un nouvel index aléatoire
    // différent de l’index actuel
    // ------------------------------------------------------------

    int newIndex = currentIndex;

    if (affirmations.length > 1) {
      final Random random = Random();

      do {
        newIndex = random.nextInt(
          affirmations.length,
        );
      } while (newIndex == currentIndex);
    }

    // ------------------------------------------------------------
    // 5. Mettre à jour le JSON
    // ------------------------------------------------------------

    payload['affirmations'] = affirmations;
    payload['currentIndex'] = newIndex;
    payload['updatedAt'] = DateTime.now().toUtc().toIso8601String();

    await HomeWidget.saveWidgetData<String>(
      storageKey,
      jsonEncode(payload),
    );

    // ------------------------------------------------------------
    // 6. Demander au widget iOS de se recharger
    // ------------------------------------------------------------

    await HomeWidget.updateWidget(
      name: 'AffirmationWidget',
      iOSName: 'AffirmationWidget',
    );

    // ------------------------------------------------------------
    // 7. Retourner exactement le texte qui doit être affiché
    // dans l’aperçu FlutterFlow
    // ------------------------------------------------------------

    return affirmations[newIndex];
  } catch (error, stackTrace) {
    print(
      'Erreur changeWidgetAffirmation : $error',
    );
    print(stackTrace);

    return 'error:$error';
  }
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the `</>` button on the right!
