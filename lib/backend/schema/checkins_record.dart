import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CheckinsRecord extends FirestoreRecord {
  CheckinsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  bool hasDate() => _date != null;

  // "completed" field.
  bool? _completed;
  bool get completed => _completed ?? false;
  bool hasCompleted() => _completed != null;

  // "idstring" field.
  String? _idstring;
  String get idstring => _idstring ?? '';
  bool hasIdstring() => _idstring != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _date = snapshotData['date'] as DateTime?;
    _completed = snapshotData['completed'] as bool?;
    _idstring = snapshotData['idstring'] as String?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('checkins')
          : FirebaseFirestore.instance.collectionGroup('checkins');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('checkins').doc(id);

  static Stream<CheckinsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => CheckinsRecord.fromSnapshot(s));

  static Future<CheckinsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => CheckinsRecord.fromSnapshot(s));

  static CheckinsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      CheckinsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static CheckinsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      CheckinsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'CheckinsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is CheckinsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createCheckinsRecordData({
  DateTime? date,
  bool? completed,
  String? idstring,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'date': date,
      'completed': completed,
      'idstring': idstring,
    }.withoutNulls,
  );

  return firestoreData;
}

class CheckinsRecordDocumentEquality implements Equality<CheckinsRecord> {
  const CheckinsRecordDocumentEquality();

  @override
  bool equals(CheckinsRecord? e1, CheckinsRecord? e2) {
    return e1?.date == e2?.date &&
        e1?.completed == e2?.completed &&
        e1?.idstring == e2?.idstring;
  }

  @override
  int hash(CheckinsRecord? e) =>
      const ListEquality().hash([e?.date, e?.completed, e?.idstring]);

  @override
  bool isValidKey(Object? o) => o is CheckinsRecord;
}
