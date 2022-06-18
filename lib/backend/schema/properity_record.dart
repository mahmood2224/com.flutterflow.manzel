import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'properity_record.g.dart';

abstract class ProperityRecord
    implements Built<ProperityRecord, ProperityRecordBuilder> {
  static Serializer<ProperityRecord> get serializer =>
      _$properityRecordSerializer;

  @nullable
  String get uid;

  @nullable
  String get name;

  @nullable
  BuiltList<String> get type;

  @nullable
  String get city;

  @nullable
  String get district;

  @nullable
  LatLng get location;

  @nullable
  int get price;

  @nullable
  @BuiltValueField(wireName: 'built_in')
  int get builtIn;

  @nullable
  int get size;

  @nullable
  BuiltList<String> get images;

  @nullable
  int get rooms;

  @nullable
  int get bathrooms;

  @nullable
  int get floors;

  @nullable
  String get description;

  @nullable
  BuiltList<String> get status;

  @nullable
  @BuiltValueField(wireName: 'p_id')
  int get pId;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(ProperityRecordBuilder builder) => builder
    ..uid = ''
    ..name = ''
    ..type = ListBuilder()
    ..city = ''
    ..district = ''
    ..price = 0
    ..builtIn = 0
    ..size = 0
    ..images = ListBuilder()
    ..rooms = 0
    ..bathrooms = 0
    ..floors = 0
    ..description = ''
    ..status = ListBuilder()
    ..pId = 0;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Properity');

  static Stream<ProperityRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<ProperityRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static ProperityRecord fromAlgolia(AlgoliaObjectSnapshot snapshot) =>
      ProperityRecord(
        (c) => c
          ..uid = snapshot.data['uid']
          ..name = snapshot.data['name']
          ..type = safeGet(() => ListBuilder(snapshot.data['type']))
          ..city = snapshot.data['city']
          ..district = snapshot.data['district']
          ..location = safeGet(() => LatLng(
                snapshot.data['_geoloc']['lat'],
                snapshot.data['_geoloc']['lng'],
              ))
          ..price = snapshot.data['price']?.round()
          ..builtIn = snapshot.data['built_in']?.round()
          ..size = snapshot.data['size']?.round()
          ..images = safeGet(() => ListBuilder(snapshot.data['images']))
          ..rooms = snapshot.data['rooms']?.round()
          ..bathrooms = snapshot.data['bathrooms']?.round()
          ..floors = snapshot.data['floors']?.round()
          ..description = snapshot.data['description']
          ..status = safeGet(() => ListBuilder(snapshot.data['status']))
          ..pId = snapshot.data['p_id']?.round()
          ..reference = ProperityRecord.collection.doc(snapshot.objectID),
      );

  static Future<List<ProperityRecord>> search(
          {String term,
          FutureOr<LatLng> location,
          int maxResults,
          double searchRadiusMeters}) =>
      FFAlgoliaManager.instance
          .algoliaQuery(
            index: 'Properity',
            term: term,
            maxResults: maxResults,
            location: location,
            searchRadiusMeters: searchRadiusMeters,
          )
          .then((r) => r.map(fromAlgolia).toList());

  ProperityRecord._();
  factory ProperityRecord([void Function(ProperityRecordBuilder) updates]) =
      _$ProperityRecord;

  static ProperityRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createProperityRecordData({
  String uid,
  String name,
  String city,
  String district,
  LatLng location,
  int price,
  int builtIn,
  int size,
  int rooms,
  int bathrooms,
  int floors,
  String description,
  int pId,
}) =>
    serializers.toFirestore(
        ProperityRecord.serializer,
        ProperityRecord((p) => p
          ..uid = uid
          ..name = name
          ..type = null
          ..city = city
          ..district = district
          ..location = location
          ..price = price
          ..builtIn = builtIn
          ..size = size
          ..images = null
          ..rooms = rooms
          ..bathrooms = bathrooms
          ..floors = floors
          ..description = description
          ..status = null
          ..pId = pId));
