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
  const String appGroupId = 'group.com.mycompany.affirmation';

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

    if (userReference != null) {
      final DocumentSnapshot userSnapshot = await userReference.get();

      final Map<String, dynamic> userData =
          (userSnapshot.data() as Map<String, dynamic>?) ?? <String, dynamic>{};

      final String requestedMode = userData['widgetMode'] is String
          ? userData['widgetMode'] as String
          : 'general';

      switch (requestedMode) {
        case 'myAffirmations':
          final List<String> personalTexts = await _loadSubcollectionTexts(
            userReference: userReference,
            subcollectionName: 'myaffirmation',
          );

          if (personalTexts.isNotEmpty) {
            effectiveMode = 'myAffirmations';
            texts = personalTexts;
          }
          break;

        case 'favorites':
          final List<String> favoriteTexts = await _loadSubcollectionTexts(
            userReference: userReference,
            subcollectionName: 'favorites',
          );

          if (favoriteTexts.isNotEmpty) {
            effectiveMode = 'favorites';
            texts = favoriteTexts;
          }
          break;

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
          }
          break;

        case 'general':
        default:
          effectiveMode = 'general';
          texts = List<String>.from(
            generalAffirmations,
          );
          break;
      }
    }

    final List<String> cleanedTexts = _cleanTexts(texts);

    final List<String> finalTexts = cleanedTexts.isNotEmpty
        ? cleanedTexts
        : List<String>.from(
            generalAffirmations,
          );

    final Map<String, dynamic> payload = <String, dynamic>{
      'mode': effectiveMode,
      'affirmations': finalTexts,
      'updatedAt': DateTime.now().toUtc().toIso8601String(),
    };

    await HomeWidget.saveWidgetData<String>(
      storageKey,
      jsonEncode(payload),
    );

    await HomeWidget.updateWidget(
      name: 'AffirmationWidget',
      iOSName: 'AffirmationWidget',
    );

    return '$effectiveMode:${finalTexts.length}';
  } catch (error, stackTrace) {
    print(
      'Erreur syncWidgetContent : $error',
    );
    print(stackTrace);

    return 'error:$error';
  }
}

Future<List<String>> _loadSubcollectionTexts({
  required DocumentReference userReference,
  required String subcollectionName,
}) async {
  final QuerySnapshot snapshot =
      await userReference.collection(subcollectionName).get();

  final List<String> texts = <String>[];

  for (final QueryDocumentSnapshot document in snapshot.docs) {
    final Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    final dynamic textValue = data['text'];

    if (textValue is String && textValue.trim().isNotEmpty) {
      texts.add(textValue.trim());
      continue;
    }

    // Repli si le texte n'est pas copié
    // mais qu'une référence existe.
    final dynamic affirmationReference =
        data['affirmationRef'] ?? data['affirmationref'];

    if (affirmationReference is DocumentReference) {
      final DocumentSnapshot affirmationSnapshot =
          await affirmationReference.get();

      final Map<String, dynamic>? affirmationData =
          affirmationSnapshot.data() as Map<String, dynamic>?;

      final dynamic referencedText = affirmationData?['text'];

      if (referencedText is String && referencedText.trim().isNotEmpty) {
        texts.add(referencedText.trim());
      }
    }
  }

  return _cleanTexts(texts);
}

Future<List<String>> _loadCategoryAffirmations(
  List<DocumentReference> categoryReferences,
) async {
  if (categoryReferences.isEmpty) {
    return <String>[];
  }

  final List<String> texts = <String>[];

  // Une requête par catégorie :
  // simple et adaptée aux premiers tests.
  for (final DocumentReference categoryReference in categoryReferences) {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('affirmation')
        .where(
          'categoryRef',
          isEqualTo: categoryReference,
        )
        .get();

    for (final QueryDocumentSnapshot document in snapshot.docs) {
      final Map<String, dynamic> data = document.data() as Map<String, dynamic>;

      final dynamic textValue = data['text'];

      if (textValue is String && textValue.trim().isNotEmpty) {
        texts.add(textValue.trim());
      }
    }
  }

  return _cleanTexts(texts);
}

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
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the `</>` button on the right!
