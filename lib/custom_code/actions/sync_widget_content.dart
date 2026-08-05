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

Future<String> syncWidgetContent() async {
  // IMPORTANT :
  // Remplace cette valeur par ton App Group iOS exact.
  const String appGroupId = 'group.com.mycompany.affirmation';

  // Cette clé doit être identique dans le code Swift.
  const String storageKey = 'widget_content_json';

  const List<String> generalAffirmations = <String>[
    'Je mérite de belles choses.',
    'Je suis capable d’avancer à mon rythme.',
    'Je fais confiance à mon chemin.',
    'Je choisis de voir le positif aujourd’hui.',
    'Je suis plus fort que mes doutes.',
    'Chaque petit pas compte.',
    'Je mérite le calme et la sérénité.',
    'Je suis fier de la personne que je deviens.',
    'J’accueille cette journée avec confiance.',
    'Je peux créer une vie qui me ressemble.',
    'Je suis digne d’amour et de respect.',
    'Je me donne le droit d’être heureux.',
    'Je progresse chaque jour.',
    'Je mérite de prendre soin de moi.',
    'Je choisis la paix intérieure.',
    'Je peux dépasser les difficultés.',
    'Je crois en mes capacités.',
    'Je m’autorise à ralentir.',
    'Je suis suffisant tel que je suis.',
    'Je transforme mes pensées avec douceur.',
    'Je mérite une vie épanouissante.',
    'Je fais de mon mieux et cela suffit.',
    'Je peux recommencer à tout moment.',
    'Je suis ouvert aux belles opportunités.',
    'Je choisis de me parler avec bienveillance.',
    'Je mérite de me sentir en sécurité.',
    'Je suis en train de devenir plus confiant.',
    'Je peux apprendre de chaque expérience.',
    'Je suis capable de créer du changement.',
    'Aujourd’hui, je choisis de croire en moi.',
    'Je choisis de me concentrer sur le positif.',
    'Je laisse aller ce qui ne me sert plus.',
    'Je suis reconnaissant pour tout ce que j’ai.',
    'Je m’entoure de personnes positives.',
    'Je mérite de recevoir le meilleur.',
    'Je choisis d’être ma priorité.',
    'J’avance avec confiance et détermination.',
    'Je suis l’auteur de ma propre histoire.',
    'Je choisis l’amour, la joie et la paix.',
    'Je fais de chaque jour une belle aventure.',
  ];

  try {
    await HomeWidget.setAppGroupId(appGroupId);

    final DocumentReference? userReference = currentUserReference;

    String effectiveMode = 'general';
    List<String> texts = List<String>.from(generalAffirmations);

    // ------------------------------------------------------------
    // 1. Lecture du mode choisi par l'utilisateur
    // ------------------------------------------------------------

    if (userReference != null) {
      final DocumentSnapshot userSnapshot = await userReference.get();

      final Map<String, dynamic> userData =
          (userSnapshot.data() as Map<String, dynamic>?) ?? <String, dynamic>{};

      final String requestedMode = userData['widgetMode'] is String
          ? userData['widgetMode'] as String
          : 'general';

      switch (requestedMode) {
        // --------------------------------------------------------
        // Mes affirmations personnelles
        // users/{uid}/myaffirmation
        // --------------------------------------------------------

        case 'myAffirmations':
          final List<String> personalTexts = await _loadSubcollectionTexts(
            userReference: userReference,
            subcollectionName: 'myaffirmation',
          );

          if (personalTexts.isNotEmpty) {
            effectiveMode = 'myAffirmations';
            texts = personalTexts;
          } else {
            effectiveMode = 'general';
            texts = List<String>.from(generalAffirmations);
          }

          break;

        // --------------------------------------------------------
        // Favoris
        // users/{uid}/favorites
        // --------------------------------------------------------

        case 'favorites':
          final List<String> favoriteTexts = await _loadSubcollectionTexts(
            userReference: userReference,
            subcollectionName: 'favorites',
          );

          if (favoriteTexts.isNotEmpty) {
            effectiveMode = 'favorites';
            texts = favoriteTexts;
          } else {
            effectiveMode = 'general';
            texts = List<String>.from(generalAffirmations);
          }

          break;

        // --------------------------------------------------------
        // Catégories choisies
        // user.widgetCategoryRefs
        // --------------------------------------------------------

        case 'categories':
          final List<dynamic> rawReferences =
              userData['widgetCategoryRefs'] is List
                  ? userData['widgetCategoryRefs'] as List<dynamic>
                  : <dynamic>[];

          final List<DocumentReference> categoryReferences =
              rawReferences.whereType<DocumentReference>().toList();

          final List<String> categoryTexts = await _loadCategoryAffirmations(
            categoryReferences,
          );

          if (categoryTexts.isNotEmpty) {
            effectiveMode = 'categories';
            texts = categoryTexts;
          } else {
            effectiveMode = 'general';
            texts = List<String>.from(generalAffirmations);
          }

          break;

        // --------------------------------------------------------
        // Mode général
        // --------------------------------------------------------

        case 'general':
        default:
          effectiveMode = 'general';
          texts = List<String>.from(generalAffirmations);
          break;
      }
    }

    // ------------------------------------------------------------
    // 2. Nettoyage de la liste
    // ------------------------------------------------------------

    final List<String> cleanedTexts = _cleanTexts(texts);

    final List<String> finalTexts = cleanedTexts.isNotEmpty
        ? cleanedTexts
        : List<String>.from(generalAffirmations);

    // ------------------------------------------------------------
    // 3. Lecture de l'ancien JSON
    // afin de conserver l'affirmation actuellement affichée
    // ------------------------------------------------------------

    int currentIndex = 0;

    final String? previousJson = await HomeWidget.getWidgetData<String>(
      storageKey,
    );

    if (previousJson != null && previousJson.trim().isNotEmpty) {
      try {
        final dynamic decodedPreviousJson = jsonDecode(previousJson);

        if (decodedPreviousJson is Map<String, dynamic>) {
          final dynamic previousIndex = decodedPreviousJson['currentIndex'];

          if (previousIndex is int) {
            currentIndex = previousIndex;
          } else if (previousIndex is num) {
            currentIndex = previousIndex.toInt();
          }
        }
      } catch (error) {
        print(
          'Impossible de lire l’ancien currentIndex : $error',
        );

        currentIndex = 0;
      }
    }

    // Empêche un index invalide si la liste a changé.
    if (finalTexts.isNotEmpty) {
      currentIndex = currentIndex % finalTexts.length;
    } else {
      currentIndex = 0;
    }

    // ------------------------------------------------------------
    // 4. Création du JSON partagé avec le widget
    // ------------------------------------------------------------

    final Map<String, dynamic> payload = <String, dynamic>{
      'mode': effectiveMode,
      'affirmations': finalTexts,
      'currentIndex': currentIndex,
      'updatedAt': DateTime.now().toUtc().toIso8601String(),
    };

    // ------------------------------------------------------------
    // 5. Enregistrement dans l'App Group
    // ------------------------------------------------------------

    await HomeWidget.saveWidgetData<String>(
      storageKey,
      jsonEncode(payload),
    );

    // ------------------------------------------------------------
    // 6. Demande de rafraîchissement du widget iOS
    // ------------------------------------------------------------

    await HomeWidget.updateWidget(
      name: 'AffirmationWidget',
      iOSName: 'AffirmationWidget',
    );

    // Exemple de résultat :
    // favorites:8:2
    // mode:nombre d'affirmations:index actuel
    return '$effectiveMode:${finalTexts.length}:$currentIndex';
  } catch (error, stackTrace) {
    print(
      'Erreur syncWidgetContent : $error',
    );
    print(stackTrace);

    return 'error:$error';
  }
}

// ----------------------------------------------------------------
// Lecture d'une sous-collection du document utilisateur
//
// Utilisée pour :
// - users/{uid}/favorites
// - users/{uid}/myaffirmation
// ----------------------------------------------------------------

Future<List<String>> _loadSubcollectionTexts({
  required DocumentReference userReference,
  required String subcollectionName,
}) async {
  final QuerySnapshot snapshot =
      await userReference.collection(subcollectionName).get();

  final List<String> texts = <String>[];

  for (final QueryDocumentSnapshot document in snapshot.docs) {
    final dynamic rawData = document.data();

    if (rawData is! Map<String, dynamic>) {
      continue;
    }

    final Map<String, dynamic> data = rawData;

    // Première possibilité :
    // le texte est directement enregistré dans le document.
    final dynamic textValue = data['text'];

    if (textValue is String && textValue.trim().isNotEmpty) {
      texts.add(textValue.trim());
      continue;
    }

    // Deuxième possibilité :
    // le document contient seulement une référence vers
    // l'affirmation originale.
    final dynamic affirmationReference =
        data['affirmationRef'] ?? data['affirmationref'];

    if (affirmationReference is DocumentReference) {
      try {
        final DocumentSnapshot affirmationSnapshot =
            await affirmationReference.get();

        final dynamic rawAffirmationData = affirmationSnapshot.data();

        if (rawAffirmationData is Map<String, dynamic>) {
          final dynamic referencedText = rawAffirmationData['text'];

          if (referencedText is String && referencedText.trim().isNotEmpty) {
            texts.add(referencedText.trim());
          }
        }
      } catch (error) {
        print(
          'Impossible de lire une affirmation référencée : $error',
        );
      }
    }
  }

  return _cleanTexts(texts);
}

// ----------------------------------------------------------------
// Lecture des affirmations correspondant aux catégories choisies
// ----------------------------------------------------------------

Future<List<String>> _loadCategoryAffirmations(
  List<DocumentReference> categoryReferences,
) async {
  if (categoryReferences.isEmpty) {
    return <String>[];
  }

  final List<String> texts = <String>[];

  // Pour les premiers tests, on effectue une requête par catégorie.
  for (final DocumentReference categoryReference in categoryReferences) {
    try {
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('affirmation')
          .where(
            'categoryRef',
            isEqualTo: categoryReference,
          )
          .get();

      for (final QueryDocumentSnapshot document in snapshot.docs) {
        final dynamic rawData = document.data();

        if (rawData is! Map<String, dynamic>) {
          continue;
        }

        final dynamic textValue = rawData['text'];

        if (textValue is String && textValue.trim().isNotEmpty) {
          texts.add(textValue.trim());
        }
      }
    } catch (error) {
      print(
        'Impossible de charger la catégorie '
        '${categoryReference.path} : $error',
      );
    }
  }

  return _cleanTexts(texts);
}

// ----------------------------------------------------------------
// Nettoyage des textes
// - retire les espaces inutiles
// - retire les textes vides
// - retire les doublons
// - conserve l'ordre initial
// ----------------------------------------------------------------

List<String> _cleanTexts(
  Iterable<String> values,
) {
  final Set<String> seen = <String>{};
  final List<String> result = <String>[];

  for (final String value in values) {
    final String cleaned = value.trim();

    if (cleaned.isNotEmpty && seen.add(cleaned)) {
      result.add(cleaned);
    }
  }

  return result;
}
