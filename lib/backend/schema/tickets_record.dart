import 'dart:async';
import 'package:built_value/built_value.dart';
import 'serializers.dart';
part 'tickets_record.g.dart';

abstract class TicketsRecord
    implements Built<TicketsRecord, TicketsRecordBuilder> {
  static Serializer<TicketsRecord> get serializer => _$ticketsRecordSerializer;

  @nullable
  String get code;

  @nullable
  DocumentReference get user;

  @nullable
  DocumentReference get game;

  @nullable
  @BuiltValueField(wireName: 'purchased_on')
  DateTime get purchasedOn;

  @nullable
  @BuiltValueField(wireName: 'qr_code')
  String get qrCode;

  @nullable
  @BuiltValueField(wireName: 'is_covered')
  bool get isCovered;

  @nullable
  @BuiltValueField(wireName: 'is_valid')
  bool get isValid;

  @nullable
  DocumentReference get price;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(TicketsRecordBuilder builder) => builder
    ..code = ''
    ..qrCode = ''
    ..isCovered = false
    ..isValid = false;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('tickets');

  static Stream<TicketsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<TicketsRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  TicketsRecord._();
  factory TicketsRecord([void Function(TicketsRecordBuilder) updates]) =
      _$TicketsRecord;

  static TicketsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createTicketsRecordData({
  String code,
  DocumentReference user,
  DocumentReference game,
  DateTime purchasedOn,
  String qrCode,
  bool isCovered,
  bool isValid,
  DocumentReference price,
}) =>
    serializers.toFirestore(
        TicketsRecord.serializer,
        TicketsRecord((t) => t
          ..code = code
          ..user = user
          ..game = game
          ..purchasedOn = purchasedOn
          ..qrCode = qrCode
          ..isCovered = isCovered
          ..isValid = isValid
          ..price = price));
