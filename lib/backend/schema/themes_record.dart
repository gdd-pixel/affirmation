import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ThemesRecord extends FirestoreRecord {
  ThemesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "wallpaper" field.
  String? _wallpaper;
  String get wallpaper => _wallpaper ?? '';
  bool hasWallpaper() => _wallpaper != null;

  // "premium" field.
  bool? _premium;
  bool get premium => _premium ?? false;
  bool hasPremium() => _premium != null;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _wallpaper = snapshotData['wallpaper'] as String?;
    _premium = snapshotData['premium'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('themes');

  static Stream<ThemesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ThemesRecord.fromSnapshot(s));

  static Future<ThemesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ThemesRecord.fromSnapshot(s));

  static ThemesRecord fromSnapshot(DocumentSnapshot snapshot) => ThemesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ThemesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ThemesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ThemesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ThemesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createThemesRecordData({
  String? name,
  String? wallpaper,
  bool? premium,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'wallpaper': wallpaper,
      'premium': premium,
    }.withoutNulls,
  );

  return firestoreData;
}

class ThemesRecordDocumentEquality implements Equality<ThemesRecord> {
  const ThemesRecordDocumentEquality();

  @override
  bool equals(ThemesRecord? e1, ThemesRecord? e2) {
    return e1?.name == e2?.name &&
        e1?.wallpaper == e2?.wallpaper &&
        e1?.premium == e2?.premium;
  }

  @override
  int hash(ThemesRecord? e) =>
      const ListEquality().hash([e?.name, e?.wallpaper, e?.premium]);

  @override
  bool isValidKey(Object? o) => o is ThemesRecord;
}
