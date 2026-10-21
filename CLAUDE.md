# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Contexte

PhilO (package `phil_o`) est une application mobile Flutter d'affirmations en français : cartes d'affirmations à swiper, favoris, playlists, catégories/thèmes, streaks, check-ins, paywall. Elle s'appuie sur Firebase, RevenueCat (abonnements), AppsFlyer (attribution) et un widget iOS natif pour l'écran d'accueil.

L'application a été générée avec FlutterFlow puis exportée. **Le projet est désormais maintenu uniquement dans le code : on ne ré-exporte plus depuis FlutterFlow.** Tout le code de `lib/`, y compris le code généré, peut donc être modifié directement. Les conventions FlutterFlow (paires `*_widget.dart` / `*_model.dart`, en-têtes d'import auto-générés dans `lib/custom_code/`) restent en place ; on les garde pour rester cohérent avec le code existant. La branche principale s'appelle encore `flutterflow`.

## Backend

Firebase (projet `affirmation-lguktd`) :
- **Auth** : email, Google, Apple, anonyme (`lib/auth/firebase_auth/`).
- **Firestore** : une classe par collection dans `lib/backend/schema/*_record.dart` (affirmation, category, themes, tags, favorites, myaffirmation, playlists, checkins, notifpreference, notification_jobs, users). Les requêtes et helpers sont dans `lib/backend/backend.dart`. Règles et index : `firebase/firestore.rules`, `firebase/firestore.indexes.json`.
- **Cloud Functions** (`firebase/functions/index.js`, Node 20) : notifications push générées par FlutterFlow (`addFcmToken`, `sendPushNotificationsTrigger` sur `ff_push_notifications`, `onUserDeleted`).
- **Messaging / Analytics / Performance** : FCM (`lib/backend/push_notifications/`), Firebase Analytics, Firebase Performance.

## Commandes utiles

```bash
flutter pub get                    # installer les dépendances
flutter analyze                    # vérifier le code
flutter test                       # lancer les tests (test/widget_test.dart n'est qu'un smoke test)
flutter test test/widget_test.dart # lancer un seul fichier de test
flutter run                        # lancer l'app (canal Flutter stable)
flutter run --dart-define=ONBOARDING_STEP=17  # debug : ouvrir l'onboarding sur une étape (= index de page)
flutter run --dart-define=FREE_USER=true       # debug : tester en non-abonné (sinon le debug est premium, cf. revenue_cat_util.dart)
flutter run --dart-define=FIRST_VISIT=true      # debug : rejouer l'introduction de la première visite sur la page principale
dart run flutter_launcher_icons    # régénérer les icônes depuis assets/images/app_launcher_icon.png
cd ios && pod install              # après un changement natif ou de plugin

# Cloud Functions
cd firebase/functions && npm run lint
cd firebase/functions && npm run serve   # émulateur de fonctions
```

`analysis_options.yaml` exclut `lib/custom_code/**` et `lib/flutter_flow/custom_functions.dart` de l'analyse.

## Structure

- Écrans : chaque écran est dans son propre dossier `lib/<ecran>/` (ex. `lib/swipe_page/`, `lib/inscription/`, `lib/settings/`). Seul `home_page` est dans `lib/pages/`. `lib/index.dart` exporte les écrans.
- `lib/components/` : composants réutilisables (paywalls, animations, popups, streak…).
- `lib/flutter_flow/` : utilitaires générés par FlutterFlow (thème, widgets, utils, navigation). À modifier avec prudence, car beaucoup d'écrans en dépendent.
- `lib/backend/` : accès aux données (Firestore, Cloud Functions, push, analytics).
- `lib/custom_code/` : actions personnalisées (`actions/`, exportées via `actions/index.dart`) et `appsflyer_manager.dart`.
- `lib/app_state.dart` : `FFAppState`, état global persisté dans `flutter_secure_storage` (clés préfixées `ff_`).

## Architecture

- **Démarrage** (`lib/main.dart`) : `initFirebase()`, puis `FFAppState().initializePersistedState()`, puis l'initialisation de RevenueCat, puis `runApp` avec `FFAppState` fourni par un `ChangeNotifierProvider`. Le flux de l'utilisateur authentifié alimente `AppStateNotifier` et le login RevenueCat. Seule la locale `fr` est prise en charge.
- **Navigation** : `go_router`, configuré dans `lib/flutter_flow/nav/nav.dart`. La route racine affiche `SwipePageWidget` si l'utilisateur est connecté, sinon `InscriptionWidget` (onboarding / inscription).

### Page principale

`lib/swipe_page/` : fil vertical « Pour toi » (affirmations dont `category` est dans `users.selectedCategories`, Généralités par défaut) et « Favoris » (`users/{uid}/favorites`). Barre de navigation `lib/components/phil_nav_bar.dart` : Accueil, Catégories (feuille `category_widget.dart`, toucher = cocher), Je manifeste (`swipe_page_own`), Widgets (`lib/pages/widgets_page/`). Libellés et mascottes des catégories : `lib/components/category_meta.dart`. Thèmes et Pratique sont dans le Profil (`avantsettings_widget.dart`). Les thèmes (fond, couleur et police des affirmations) sont définis dans `lib/components/app_themes.dart` (id = `users.currentheme`, fonds dans `assets/images/themes/`) et choisis via `themepop_widget.dart` / `theme_grid.dart`, aussi utilisés par l'onboarding.

### Widget iOS (écran d'accueil)

Le widget est une extension WidgetKit (`ios/AffirmationWidget/AffirmationWidget.swift`). Flutter l'alimente via le package `home_widget`. Le côté Dart et le côté Swift partagent un contrat qui doit rester synchronisé :

- App Group `group.com.mycompany.affirmation`. On le retrouve dans `Runner.entitlements`, `AffirmationWidgetExtension.entitlements`, le `Provider` Swift et chaque action custom liée au widget. Cette valeur ressemble encore à un placeholder.
- Clé de stockage `widget_content_json`. Elle contient un JSON conforme à `WidgetPayload` côté Swift (`mode`, `affirmations`, `currentIndex`, `updatedAt`).
- Nom du widget (`kind` / `iOSName`) : `AffirmationWidget`.

L'app sait si le widget est installé via `isAffirmationWidgetInstalled()` (`lib/custom_code/widget_status.dart`, basé sur `HomeWidget.getInstalledWidgets()`) : la page Widgets affiche une pop-up d'installation et le tutoriel `lib/pages/widget_tutorial/` sinon.

Les actions Dart qui écrivent ces données sont `sync_widget_content.dart`, `change_widget_affirmation.dart`, `sync_favorite_affirmations_to_widget.dart` et `update_affirmation_widget.dart`. Côté Swift, la timeline fait tourner les affirmations toutes les heures, avec sa propre liste d'affirmations de secours.

`ios/ImageNotification/` est une Notification Service Extension qui affiche les images dans les notifications push.
