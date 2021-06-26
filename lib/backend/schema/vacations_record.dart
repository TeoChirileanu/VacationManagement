import 'dart:async';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latlong/latlong.dart';

import 'schema_util.dart';
import 'serializers.dart';

part 'vacations_record.g.dart';

abstract class VacationsRecord
    implements Built<VacationsRecord, VacationsRecordBuilder> {
  static Serializer<VacationsRecord> get serializer =>
      _$vacationsRecordSerializer;

  @nullable
  @BuiltValueField(wireName: 'duration_in_days')
  int get durationInDays;

  @nullable
  @BuiltValueField(wireName: 'start_date')
  DateTime get startDate;

  @nullable
  @BuiltValueField(wireName: 'end_date')
  DateTime get endDate;

  @nullable
  String get status;

  @nullable
  String get type;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(VacationsRecordBuilder builder) => builder
    ..durationInDays = 0
    ..status = ''
    ..type = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('vacations');

  static Stream<VacationsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  VacationsRecord._();
  factory VacationsRecord([void Function(VacationsRecordBuilder) updates]) =
      _$VacationsRecord;

  static VacationsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(
          serializer, {...data, kDocumentReferenceField: reference});
}

Map<String, dynamic> createVacationsRecordData({
  int durationInDays,
  DateTime startDate,
  DateTime endDate,
  String status,
  String type,
}) =>
    serializers.toFirestore(
        VacationsRecord.serializer,
        VacationsRecord((v) => v
          ..durationInDays = durationInDays
          ..startDate = startDate
          ..endDate = endDate
          ..status = status
          ..type = type));

VacationsRecord get dummyVacationsRecord {
  final builder = VacationsRecordBuilder()
    ..durationInDays = dummyInteger
    ..startDate = dummyTimestamp
    ..endDate = dummyTimestamp
    ..status = dummyString
    ..type = dummyString;
  return builder.build();
}

List<VacationsRecord> createDummyVacationsRecord({int count}) =>
    List.generate(count, (_) => dummyVacationsRecord);
