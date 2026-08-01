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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:home_widget/home_widget.dart';

import '/auth/firebase_auth/auth_util.dart';

Future<int> syncFavoriteAffirmationsToWidget() async {
  const appGroupId = 'group.com.mycompany.affirmation';
  const storageKey = 'favorite_affirmations_json';

  try {
    await HomeWidget.setAppGroupId(appGroupId);

    final userReference = currentUserReference;

    // Aucun utilisateur connecté : on vide les données du widget.
    if (userReference == null) {
      await HomeWidget.saveWidgetData<String>(
        storageKey,
        jsonEncode(<String>[]),
      );

      await HomeWidget.updateWidget(
        name: 'AffirmationWidget',
        iOSName: 'AffirmationWidget',
      );

      return 0;
    }

    final favoritesSnapshot = await userReference
        .collection('favorites')
        .orderBy('createdAt', descending: true)
        .get();

    final List<String> favoriteTexts = [];

    for (final favoriteDocument in favoritesSnapshot.docs) {
      final data = favoriteDocument.data();

      // Première possibilité : le texte est directement enregistré
      // dans le document favorite.
      final directText = data['text'];

      if (directText is String && directText.trim().isNotEmpty) {
        favoriteTexts.add(directText.trim());
        continue;
      }

      // Sécurité supplémentaire :
      // si le champ text est absent, on utilise affirmationRef.
      final affirmationReference = data['affirmationRef'];

      if (affirmationReference is DocumentReference) {
        try {
          final affirmationSnapshot = await affirmationReference.get();

          final affirmationData =
              affirmationSnapshot.data() as Map<String, dynamic>?;

          final referencedText = affirmationData?['text'];

          if (referencedText is String && referencedText.trim().isNotEmpty) {
            favoriteTexts.add(referencedText.trim());
          }
        } catch (error) {
          print(
            'Impossible de charger une affirmation favorite : $error',
          );
        }
      }
    }

    // Supprime les doublons tout en conservant l’ordre.
    final uniqueTexts = favoriteTexts.toSet().toList();

    await HomeWidget.saveWidgetData<String>(
      storageKey,
      jsonEncode(uniqueTexts),
    );

    await HomeWidget.updateWidget(
      name: 'AffirmationWidget',
      iOSName: 'AffirmationWidget',
    );

    return uniqueTexts.length;
  } catch (error, stackTrace) {
    print(
      'Erreur de synchronisation des favoris vers le widget : $error',
    );
    print(stackTrace);

    return -1;
  }
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the `</>` button on the right!
