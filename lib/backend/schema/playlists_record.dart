import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PlaylistsRecord extends FirestoreRecord {
  PlaylistsRecord._(
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

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "tags" field.
  String? _tags;
  String get tags => _tags ?? '';
  bool hasTags() => _tags != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _affirmationRef = snapshotData['affirmationRef'] as DocumentReference?;
    _createdAt = snapshotData['createdAt'] as DateTime?;
    _name = snapshotData['name'] as String?;
    _tags = snapshotData['tags'] as String?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('playlists')
          : FirebaseFirestore.instance.collectionGroup('playlists');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('playlists').doc(id);

  static Stream<PlaylistsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => PlaylistsRecord.fromSnapshot(s));

  static Future<PlaylistsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => PlaylistsRecord.fromSnapshot(s));

  static PlaylistsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      PlaylistsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static PlaylistsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      PlaylistsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'PlaylistsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PlaylistsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createPlaylistsRecordData({
  DocumentReference? affirmationRef,
  DateTime? createdAt,
  String? name,
  String? tags,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'affirmationRef': affirmationRef,
      'createdAt': createdAt,
      'name': name,
      'tags': tags,
    }.withoutNulls,
  );

  return firestoreData;
}

class PlaylistsRecordDocumentEquality implements Equality<PlaylistsRecord> {
  const PlaylistsRecordDocumentEquality();

  @override
  bool equals(PlaylistsRecord? e1, PlaylistsRecord? e2) {
    return e1?.affirmationRef == e2?.affirmationRef &&
        e1?.createdAt == e2?.createdAt &&
        e1?.name == e2?.name &&
        e1?.tags == e2?.tags;
  }

  @override
  int hash(PlaylistsRecord? e) => const ListEquality()
      .hash([e?.affirmationRef, e?.createdAt, e?.name, e?.tags]);

  @override
  bool isValidKey(Object? o) => o is PlaylistsRecord;
}
