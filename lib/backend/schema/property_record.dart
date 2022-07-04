import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'property_record.g.dart';

abstract class PropertyRecord
    implements Built<PropertyRecord, PropertyRecordBuilder> {
  static Serializer<PropertyRecord> get serializer =>
      _$propertyRecordSerializer;

  @nullable
  @BuiltValueField(wireName: 'p_id')
  int get pId;

  @nullable
  @BuiltValueField(wireName: 'property_city')
  String get propertyCity;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(PropertyRecordBuilder builder) => builder
    ..pId = 0
    ..propertyCity = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Property');

  static Stream<PropertyRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<PropertyRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static PropertyRecord fromAlgolia(AlgoliaObjectSnapshot snapshot) =>
      PropertyRecord(
        (c) => c
          ..pId = snapshot.data['p_id']?.round()
          ..propertyCity = snapshot.data['property_city']
          ..reference = PropertyRecord.collection.doc(snapshot.objectID),
      );

  static Future<List<PropertyRecord>> search(
          {String term,
          FutureOr<LatLng> location,
          int maxResults,
          double searchRadiusMeters}) =>
      FFAlgoliaManager.instance
          .algoliaQuery(
            index: 'Property',
            term: term,
            maxResults: maxResults,
            location: location,
            searchRadiusMeters: searchRadiusMeters,
          )
          .then((r) => r.map(fromAlgolia).toList());

  PropertyRecord._();
  factory PropertyRecord([void Function(PropertyRecordBuilder) updates]) =
      _$PropertyRecord;

  static PropertyRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createPropertyRecordData({
  int pId,
  String propertyCity,
}) =>
    serializers.toFirestore(
        PropertyRecord.serializer,
        PropertyRecord((p) => p
          ..pId = pId
          ..propertyCity = propertyCity));
