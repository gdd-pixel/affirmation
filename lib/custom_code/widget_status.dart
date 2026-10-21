import 'dart:convert';
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:home_widget/home_widget.dart';

/// Doit correspondre au `kind` du widget déclaré côté Swift
/// (ios/AffirmationWidget/AffirmationWidget.swift).
const kAffirmationWidgetKind = 'AffirmationWidget';

const _appGroupId = 'group.com.mycompany.affirmation';
const _storageKey = 'widget_content_json';

/// Indique si le widget Phil'O est installé (écran d'accueil ou écran
/// verrouillé).
///
/// Retourne `null` quand on ne peut pas le savoir : hors iOS (le tutoriel et
/// le widget ne concernent que l'iPhone) ou si iOS ne répond pas.
Future<bool?> isAffirmationWidgetInstalled() async {
  if (kIsWeb || !Platform.isIOS) {
    return null;
  }
  try {
    final widgets = await HomeWidget.getInstalledWidgets();
    return widgets.any((w) => w.iOSKind == kAffirmationWidgetKind);
  } catch (_) {
    return null;
  }
}

/// Affirmation actuellement affichée par le widget, sans la changer.
Future<String?> currentWidgetAffirmation() async {
  try {
    await HomeWidget.setAppGroupId(_appGroupId);
    final json = await HomeWidget.getWidgetData<String>(_storageKey);
    if (json == null) {
      return null;
    }
    final payload = jsonDecode(json) as Map<String, dynamic>;
    final affirmations =
        (payload['affirmations'] as List?)?.whereType<String>().toList() ??
            const <String>[];
    if (affirmations.isEmpty) {
      return null;
    }
    final index = (payload['currentIndex'] as num?)?.toInt() ?? 0;
    return affirmations[index % affirmations.length];
  } catch (_) {
    return null;
  }
}
