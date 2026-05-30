import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MyaffirmationRecord extends FirestoreRecord {
  MyaffirmationRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "affirmationref" field.
  DocumentReference? _affirmationref;
  DocumentReference? get affirmationref => _affirmationref;
  bool hasAffirmationref() => _affirmationref != null;

  // "createdAt" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "text" field.
  String? _text;
  String get text => _text ?? '';
  bool hasText() => _text != null;

  // "tags" field.
  String? _tags;
  String get tags => _tags ?? '';
  bool hasTags() => _tags != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _affirmationref = snapshotData['affirmationref'] as DocumentReference?;
    _createdAt = snapshotData['createdAt'] as DateTime?;
    _text = snapshotData['text'] as String?;
    _tags = snapshotData['tags'] as String?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('myaffirmation')
          : FirebaseFirestore.instance.collectionGroup('myaffirmation');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('myaffirmation').doc(id);

  static Stream<MyaffirmationRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => MyaffirmationRecord.fromSnapshot(s));

  static Future<MyaffirmationRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => MyaffirmationRecord.fromSnapshot(s));

  static MyaffirmationRecord fromSnapshot(DocumentSnapshot snapshot) =>
      MyaffirmationRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static MyaffirmationRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      MyaffirmationRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'MyaffirmationRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is MyaffirmationRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createMyaffirmationRecordData({
  DocumentReference? affirmationref,
  DateTime? createdAt,
  String? text,
  String? tags,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'affirmationref': affirmationref,
      'createdAt': createdAt,
      'text': text,
      'tags': tags,
    }.withoutNulls,
  );

  return firestoreData;
}

class MyaffirmationRecordDocumentEquality
    implements Equality<MyaffirmationRecord> {
  const MyaffirmationRecordDocumentEquality();

  @override
  bool equals(MyaffirmationRecord? e1, MyaffirmationRecord? e2) {
    return e1?.affirmationref == e2?.affirmationref &&
        e1?.createdAt == e2?.createdAt &&
        e1?.text == e2?.text &&
        e1?.tags == e2?.tags;
  }

  @override
  int hash(MyaffirmationRecord? e) => const ListEquality()
      .hash([e?.affirmationref, e?.createdAt, e?.text, e?.tags]);

  @override
  bool isValidKey(Object? o) => o is MyaffirmationRecord;
}
