import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class NotificationJobsRecord extends FirestoreRecord {
  NotificationJobsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "idc" field.
  String? _idc;
  String get idc => _idc ?? '';
  bool hasIdc() => _idc != null;

  void _initializeFields() {
    _idc = snapshotData['idc'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('notification_jobs');

  static Stream<NotificationJobsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => NotificationJobsRecord.fromSnapshot(s));

  static Future<NotificationJobsRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => NotificationJobsRecord.fromSnapshot(s));

  static NotificationJobsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      NotificationJobsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static NotificationJobsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      NotificationJobsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'NotificationJobsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is NotificationJobsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createNotificationJobsRecordData({
  String? idc,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'idc': idc,
    }.withoutNulls,
  );

  return firestoreData;
}

class NotificationJobsRecordDocumentEquality
    implements Equality<NotificationJobsRecord> {
  const NotificationJobsRecordDocumentEquality();

  @override
  bool equals(NotificationJobsRecord? e1, NotificationJobsRecord? e2) {
    return e1?.idc == e2?.idc;
  }

  @override
  int hash(NotificationJobsRecord? e) => const ListEquality().hash([e?.idc]);

  @override
  bool isValidKey(Object? o) => o is NotificationJobsRecord;
}
