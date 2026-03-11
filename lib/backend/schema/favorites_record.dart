import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class FavoritesRecord extends FirestoreRecord {
  FavoritesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "affirmationRef" field.
  DocumentReference? _affirmationRef;
  DocumentReference? get affirmationRef => _affirmationRef;
  bool hasAffirmationRef() => _affirmationRef != null;

  // "createdAt" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "tags" field.
  String? _tags;
  String get tags => _tags ?? '';
  bool hasTags() => _tags != null;

  // "text" field.
  String? _text;
  String get text => _text ?? '';
  bool hasText() => _text != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _affirmationRef = snapshotData['affirmationRef'] as DocumentReference?;
    _createdAt = snapshotData['createdAt'] as DateTime?;
    _tags = snapshotData['tags'] as String?;
    _text = snapshotData['text'] as String?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('favorites')
          : FirebaseFirestore.instance.collectionGroup('favorites');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('favorites').doc(id);

  static Stream<FavoritesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => FavoritesRecord.fromSnapshot(s));

  static Future<FavoritesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => FavoritesRecord.fromSnapshot(s));

  static FavoritesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      FavoritesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static FavoritesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      FavoritesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'FavoritesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is FavoritesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createFavoritesRecordData({
  DocumentReference? affirmationRef,
  DateTime? createdAt,
  String? tags,
  String? text,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'affirmationRef': affirmationRef,
      'createdAt': createdAt,
      'tags': tags,
      'text': text,
    }.withoutNulls,
  );

  return firestoreData;
}

class FavoritesRecordDocumentEquality implements Equality<FavoritesRecord> {
  const FavoritesRecordDocumentEquality();

  @override
  bool equals(FavoritesRecord? e1, FavoritesRecord? e2) {
    return e1?.affirmationRef == e2?.affirmationRef &&
        e1?.createdAt == e2?.createdAt &&
        e1?.tags == e2?.tags &&
        e1?.text == e2?.text;
  }

  @override
  int hash(FavoritesRecord? e) => const ListEquality()
      .hash([e?.affirmationRef, e?.createdAt, e?.tags, e?.text]);

  @override
  bool isValidKey(Object? o) => o is FavoritesRecord;
}
