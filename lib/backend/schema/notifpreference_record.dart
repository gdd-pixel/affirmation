import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class NotifpreferenceRecord extends FirestoreRecord {
  NotifpreferenceRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "dailycount" field.
  int? _dailycount;
  int get dailycount => _dailycount ?? 0;
  bool hasDailycount() => _dailycount != null;

  // "startHour" field.
  DateTime? _startHour;
  DateTime? get startHour => _startHour;
  bool hasStartHour() => _startHour != null;

  // "endHour" field.
  DateTime? _endHour;
  DateTime? get endHour => _endHour;
  bool hasEndHour() => _endHour != null;

  // "timezone" field.
  String? _timezone;
  String get timezone => _timezone ?? '';
  bool hasTimezone() => _timezone != null;

  // "notifenable" field.
  bool? _notifenable;
  bool get notifenable => _notifenable ?? false;
  bool hasNotifenable() => _notifenable != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _dailycount = castToType<int>(snapshotData['dailycount']);
    _startHour = snapshotData['startHour'] as DateTime?;
    _endHour = snapshotData['endHour'] as DateTime?;
    _timezone = snapshotData['timezone'] as String?;
    _notifenable = snapshotData['notifenable'] as bool?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('notifpreference')
          : FirebaseFirestore.instance.collectionGroup('notifpreference');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('notifpreference').doc(id);

  static Stream<NotifpreferenceRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => NotifpreferenceRecord.fromSnapshot(s));

  static Future<NotifpreferenceRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => NotifpreferenceRecord.fromSnapshot(s));

  static NotifpreferenceRecord fromSnapshot(DocumentSnapshot snapshot) =>
      NotifpreferenceRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static NotifpreferenceRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      NotifpreferenceRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'NotifpreferenceRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is NotifpreferenceRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createNotifpreferenceRecordData({
  int? dailycount,
  DateTime? startHour,
  DateTime? endHour,
  String? timezone,
  bool? notifenable,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'dailycount': dailycount,
      'startHour': startHour,
      'endHour': endHour,
      'timezone': timezone,
      'notifenable': notifenable,
    }.withoutNulls,
  );

  return firestoreData;
}

class NotifpreferenceRecordDocumentEquality
    implements Equality<NotifpreferenceRecord> {
  const NotifpreferenceRecordDocumentEquality();

  @override
  bool equals(NotifpreferenceRecord? e1, NotifpreferenceRecord? e2) {
    return e1?.dailycount == e2?.dailycount &&
        e1?.startHour == e2?.startHour &&
        e1?.endHour == e2?.endHour &&
        e1?.timezone == e2?.timezone &&
        e1?.notifenable == e2?.notifenable;
  }

  @override
  int hash(NotifpreferenceRecord? e) => const ListEquality().hash(
      [e?.dailycount, e?.startHour, e?.endHour, e?.timezone, e?.notifenable]);

  @override
  bool isValidKey(Object? o) => o is NotifpreferenceRecord;
}
