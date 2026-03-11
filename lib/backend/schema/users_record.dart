import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UsersRecord extends FirestoreRecord {
  UsersRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "display_name" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  bool hasDisplayName() => _displayName != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  // "accountfinished" field.
  bool? _accountfinished;
  bool get accountfinished => _accountfinished ?? false;
  bool hasAccountfinished() => _accountfinished != null;

  // "currentheme" field.
  String? _currentheme;
  String get currentheme => _currentheme ?? '';
  bool hasCurrentheme() => _currentheme != null;

  // "currentstreak" field.
  int? _currentstreak;
  int get currentstreak => _currentstreak ?? 0;
  bool hasCurrentstreak() => _currentstreak != null;

  // "beststreak" field.
  int? _beststreak;
  int get beststreak => _beststreak ?? 0;
  bool hasBeststreak() => _beststreak != null;

  // "lastCheckinDate" field.
  DateTime? _lastCheckinDate;
  DateTime? get lastCheckinDate => _lastCheckinDate;
  bool hasLastCheckinDate() => _lastCheckinDate != null;

  // "weeklyCheckins" field.
  List<bool>? _weeklyCheckins;
  List<bool> get weeklyCheckins => _weeklyCheckins ?? const [];
  bool hasWeeklyCheckins() => _weeklyCheckins != null;

  void _initializeFields() {
    _email = snapshotData['email'] as String?;
    _displayName = snapshotData['display_name'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _uid = snapshotData['uid'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _phoneNumber = snapshotData['phone_number'] as String?;
    _accountfinished = snapshotData['accountfinished'] as bool?;
    _currentheme = snapshotData['currentheme'] as String?;
    _currentstreak = castToType<int>(snapshotData['currentstreak']);
    _beststreak = castToType<int>(snapshotData['beststreak']);
    _lastCheckinDate = snapshotData['lastCheckinDate'] as DateTime?;
    _weeklyCheckins = getDataList(snapshotData['weeklyCheckins']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('users');

  static Stream<UsersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UsersRecord.fromSnapshot(s));

  static Future<UsersRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UsersRecord.fromSnapshot(s));

  static UsersRecord fromSnapshot(DocumentSnapshot snapshot) => UsersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UsersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UsersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UsersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UsersRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUsersRecordData({
  String? email,
  String? displayName,
  String? photoUrl,
  String? uid,
  DateTime? createdTime,
  String? phoneNumber,
  bool? accountfinished,
  String? currentheme,
  int? currentstreak,
  int? beststreak,
  DateTime? lastCheckinDate,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'email': email,
      'display_name': displayName,
      'photo_url': photoUrl,
      'uid': uid,
      'created_time': createdTime,
      'phone_number': phoneNumber,
      'accountfinished': accountfinished,
      'currentheme': currentheme,
      'currentstreak': currentstreak,
      'beststreak': beststreak,
      'lastCheckinDate': lastCheckinDate,
    }.withoutNulls,
  );

  return firestoreData;
}

class UsersRecordDocumentEquality implements Equality<UsersRecord> {
  const UsersRecordDocumentEquality();

  @override
  bool equals(UsersRecord? e1, UsersRecord? e2) {
    const listEquality = ListEquality();
    return e1?.email == e2?.email &&
        e1?.displayName == e2?.displayName &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.uid == e2?.uid &&
        e1?.createdTime == e2?.createdTime &&
        e1?.phoneNumber == e2?.phoneNumber &&
        e1?.accountfinished == e2?.accountfinished &&
        e1?.currentheme == e2?.currentheme &&
        e1?.currentstreak == e2?.currentstreak &&
        e1?.beststreak == e2?.beststreak &&
        e1?.lastCheckinDate == e2?.lastCheckinDate &&
        listEquality.equals(e1?.weeklyCheckins, e2?.weeklyCheckins);
  }

  @override
  int hash(UsersRecord? e) => const ListEquality().hash([
        e?.email,
        e?.displayName,
        e?.photoUrl,
        e?.uid,
        e?.createdTime,
        e?.phoneNumber,
        e?.accountfinished,
        e?.currentheme,
        e?.currentstreak,
        e?.beststreak,
        e?.lastCheckinDate,
        e?.weeklyCheckins
      ]);

  @override
  bool isValidKey(Object? o) => o is UsersRecord;
}
