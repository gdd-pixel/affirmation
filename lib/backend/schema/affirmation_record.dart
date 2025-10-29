import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AffirmationRecord extends FirestoreRecord {
  AffirmationRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "text" field.
  String? _text;
  String get text => _text ?? '';
  bool hasText() => _text != null;

  // "lang" field.
  String? _lang;
  String get lang => _lang ?? '';
  bool hasLang() => _lang != null;

  // "likeCount" field.
  int? _likeCount;
  int get likeCount => _likeCount ?? 0;
  bool hasLikeCount() => _likeCount != null;

  // "creator" field.
  DocumentReference? _creator;
  DocumentReference? get creator => _creator;
  bool hasCreator() => _creator != null;

  void _initializeFields() {
    _text = snapshotData['text'] as String?;
    _lang = snapshotData['lang'] as String?;
    _likeCount = castToType<int>(snapshotData['likeCount']);
    _creator = snapshotData['creator'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('affirmation');

  static Stream<AffirmationRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => AffirmationRecord.fromSnapshot(s));

  static Future<AffirmationRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => AffirmationRecord.fromSnapshot(s));

  static AffirmationRecord fromSnapshot(DocumentSnapshot snapshot) =>
      AffirmationRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static AffirmationRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      AffirmationRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'AffirmationRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is AffirmationRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createAffirmationRecordData({
  String? text,
  String? lang,
  int? likeCount,
  DocumentReference? creator,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'text': text,
      'lang': lang,
      'likeCount': likeCount,
      'creator': creator,
    }.withoutNulls,
  );

  return firestoreData;
}

class AffirmationRecordDocumentEquality implements Equality<AffirmationRecord> {
  const AffirmationRecordDocumentEquality();

  @override
  bool equals(AffirmationRecord? e1, AffirmationRecord? e2) {
    return e1?.text == e2?.text &&
        e1?.lang == e2?.lang &&
        e1?.likeCount == e2?.likeCount &&
        e1?.creator == e2?.creator;
  }

  @override
  int hash(AffirmationRecord? e) =>
      const ListEquality().hash([e?.text, e?.lang, e?.likeCount, e?.creator]);

  @override
  bool isValidKey(Object? o) => o is AffirmationRecord;
}
