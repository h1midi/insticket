import 'dart:async';

import 'package:built_value/built_value.dart';

import 'index.dart';
import 'serializers.dart';

part 'games_record.g.dart';

abstract class GamesRecord implements Built<GamesRecord, GamesRecordBuilder> {
  static Serializer<GamesRecord> get serializer => _$gamesRecordSerializer;

  @nullable
  DateTime get date;

  @nullable
  @BuiltValueField(wireName: 'bought_by')
  BuiltList<DocumentReference> get boughtBy;

  @nullable
  String get title;

  @nullable
  String get desc;

  @nullable
  String get stadium;

  @nullable
  @BuiltValueField(wireName: 'home_team')
  String get homeTeam;

  @nullable
  @BuiltValueField(wireName: 'ht_image_url')
  String get htImageUrl;

  @nullable
  @BuiltValueField(wireName: 'away_team')
  String get awayTeam;

  @nullable
  @BuiltValueField(wireName: 'at_image_url')
  String get atImageUrl;

  @nullable
  @BuiltValueField(wireName: 'covered_num')
  int get coveredNum;

  @nullable
  @BuiltValueField(wireName: 'covered_price')
  int get coveredPrice;

  @nullable
  @BuiltValueField(wireName: 'normal_price')
  int get normalPrice;

  @nullable
  @BuiltValueField(wireName: 'total_revenue')
  int get totalRevenue;

  @nullable
  @BuiltValueField(wireName: 'normal_num_current')
  int get normalNumCurrent;

  @nullable
  @BuiltValueField(wireName: 'normal_num')
  int get normalNum;

  @nullable
  @BuiltValueField(wireName: 'covered_num_current')
  int get coveredNumCurrent;

  @nullable
  String get versus;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(GamesRecordBuilder builder) => builder
    ..boughtBy = ListBuilder()
    ..title = ''
    ..desc = ''
    ..stadium = ''
    ..homeTeam = ''
    ..htImageUrl = ''
    ..awayTeam = ''
    ..atImageUrl = ''
    ..coveredNum = 0
    ..coveredPrice = 0
    ..normalPrice = 0
    ..totalRevenue = 0
    ..normalNumCurrent = 0
    ..normalNum = 0
    ..coveredNumCurrent = 0
    ..versus = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('games');

  static Stream<GamesRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<GamesRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  GamesRecord._();
  factory GamesRecord([void Function(GamesRecordBuilder) updates]) =
      _$GamesRecord;

  static GamesRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createGamesRecordData({
  DateTime date,
  String title,
  String desc,
  String stadium,
  String homeTeam,
  String htImageUrl,
  String awayTeam,
  String atImageUrl,
  int coveredNum,
  int coveredPrice,
  int normalPrice,
  int totalRevenue,
  int normalNumCurrent,
  int normalNum,
  int coveredNumCurrent,
  String versus,
}) =>
    serializers.toFirestore(
        GamesRecord.serializer,
        GamesRecord((g) => g
          ..date = date
          ..boughtBy = null
          ..title = title
          ..desc = desc
          ..stadium = stadium
          ..homeTeam = homeTeam
          ..htImageUrl = htImageUrl
          ..awayTeam = awayTeam
          ..atImageUrl = atImageUrl
          ..coveredNum = coveredNum
          ..coveredPrice = coveredPrice
          ..normalPrice = normalPrice
          ..totalRevenue = totalRevenue
          ..normalNumCurrent = normalNumCurrent
          ..normalNum = normalNum
          ..coveredNumCurrent = coveredNumCurrent
          ..versus = versus));
