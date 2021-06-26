import 'dart:async';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latlong/latlong.dart';

import 'schema_util.dart';
import 'serializers.dart';

part 'employees_record.g.dart';

abstract class EmployeesRecord
    implements Built<EmployeesRecord, EmployeesRecordBuilder> {
  static Serializer<EmployeesRecord> get serializer =>
      _$employeesRecordSerializer;

  @nullable
  @BuiltValueField(wireName: 'alocated_manager')
  String get alocatedManager;

  @nullable
  String get department;

  @nullable
  @BuiltValueField(wireName: 'first_name')
  String get firstName;

  @nullable
  @BuiltValueField(wireName: 'last_name')
  String get lastName;

  @nullable
  String get role;

  @nullable
  @BuiltValueField(wireName: 'remaining_vacation_days')
  int get remainingVacationDays;

  @nullable
  BuiltList<DocumentReference> get vacations;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(EmployeesRecordBuilder builder) => builder
    ..alocatedManager = ''
    ..department = ''
    ..firstName = ''
    ..lastName = ''
    ..role = ''
    ..remainingVacationDays = 0
    ..vacations = ListBuilder();

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('employees');

  static Stream<EmployeesRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  EmployeesRecord._();
  factory EmployeesRecord([void Function(EmployeesRecordBuilder) updates]) =
      _$EmployeesRecord;

  static EmployeesRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(
          serializer, {...data, kDocumentReferenceField: reference});
}

Map<String, dynamic> createEmployeesRecordData({
  String alocatedManager,
  String department,
  String firstName,
  String lastName,
  String role,
  int remainingVacationDays,
}) =>
    serializers.toFirestore(
        EmployeesRecord.serializer,
        EmployeesRecord((e) => e
          ..alocatedManager = alocatedManager
          ..department = department
          ..firstName = firstName
          ..lastName = lastName
          ..role = role
          ..remainingVacationDays = remainingVacationDays
          ..vacations = null));

EmployeesRecord get dummyEmployeesRecord {
  final builder = EmployeesRecordBuilder()
    ..alocatedManager = dummyString
    ..department = dummyString
    ..firstName = dummyString
    ..lastName = dummyString
    ..role = dummyString
    ..remainingVacationDays = dummyInteger;
  return builder.build();
}

List<EmployeesRecord> createDummyEmployeesRecord({int count}) =>
    List.generate(count, (_) => dummyEmployeesRecord);
