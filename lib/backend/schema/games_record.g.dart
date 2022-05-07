// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'games_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GamesRecord> _$gamesRecordSerializer = new _$GamesRecordSerializer();

class _$GamesRecordSerializer implements StructuredSerializer<GamesRecord> {
  @override
  final Iterable<Type> types = const [GamesRecord, _$GamesRecord];
  @override
  final String wireName = 'GamesRecord';

  @override
  Iterable<Object> serialize(Serializers serializers, GamesRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    Object value;
    value = object.date;
    if (value != null) {
      result
        ..add('date')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.boughtBy;
    if (value != null) {
      result
        ..add('bought_by')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(BuiltList, const [
              const FullType(DocumentReference, const [const FullType(Object)])
            ])));
    }
    value = object.title;
    if (value != null) {
      result
        ..add('title')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.desc;
    if (value != null) {
      result
        ..add('desc')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.stadium;
    if (value != null) {
      result
        ..add('stadium')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.homeTeam;
    if (value != null) {
      result
        ..add('home_team')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.htImageUrl;
    if (value != null) {
      result
        ..add('ht_image_url')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.awayTeam;
    if (value != null) {
      result
        ..add('away_team')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.atImageUrl;
    if (value != null) {
      result
        ..add('at_image_url')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.coveredNum;
    if (value != null) {
      result
        ..add('covered_num')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.coveredPrice;
    if (value != null) {
      result
        ..add('covered_price')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.normalPrice;
    if (value != null) {
      result
        ..add('normal_price')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.totalRevenue;
    if (value != null) {
      result
        ..add('total_revenue')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.normalNumCurrent;
    if (value != null) {
      result
        ..add('normal_num_current')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.normalNum;
    if (value != null) {
      result
        ..add('normal_num')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.coveredNumCurrent;
    if (value != null) {
      result
        ..add('covered_num_current')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.versus;
    if (value != null) {
      result
        ..add('versus')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.reference;
    if (value != null) {
      result
        ..add('Document__Reference__Field')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType(Object)])));
    }
    return result;
  }

  @override
  GamesRecord deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GamesRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'date':
          result.date = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
        case 'bought_by':
          result.boughtBy.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(
                    DocumentReference, const [const FullType(Object)])
              ])) as BuiltList<Object>);
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'desc':
          result.desc = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'stadium':
          result.stadium = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'home_team':
          result.homeTeam = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'ht_image_url':
          result.htImageUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'away_team':
          result.awayTeam = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'at_image_url':
          result.atImageUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'covered_num':
          result.coveredNum = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'covered_price':
          result.coveredPrice = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'normal_price':
          result.normalPrice = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'total_revenue':
          result.totalRevenue = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'normal_num_current':
          result.normalNumCurrent = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'normal_num':
          result.normalNum = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'covered_num_current':
          result.coveredNumCurrent = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'versus':
          result.versus = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'Document__Reference__Field':
          result.reference = serializers.deserialize(value,
                  specifiedType: const FullType(
                      DocumentReference, const [const FullType(Object)]))
              as DocumentReference<Object>;
          break;
      }
    }

    return result.build();
  }
}

class _$GamesRecord extends GamesRecord {
  @override
  final DateTime date;
  @override
  final BuiltList<DocumentReference<Object>> boughtBy;
  @override
  final String title;
  @override
  final String desc;
  @override
  final String stadium;
  @override
  final String homeTeam;
  @override
  final String htImageUrl;
  @override
  final String awayTeam;
  @override
  final String atImageUrl;
  @override
  final int coveredNum;
  @override
  final int coveredPrice;
  @override
  final int normalPrice;
  @override
  final int totalRevenue;
  @override
  final int normalNumCurrent;
  @override
  final int normalNum;
  @override
  final int coveredNumCurrent;
  @override
  final String versus;
  @override
  final DocumentReference<Object> reference;

  factory _$GamesRecord([void Function(GamesRecordBuilder) updates]) =>
      (new GamesRecordBuilder()..update(updates)).build();

  _$GamesRecord._(
      {this.date,
      this.boughtBy,
      this.title,
      this.desc,
      this.stadium,
      this.homeTeam,
      this.htImageUrl,
      this.awayTeam,
      this.atImageUrl,
      this.coveredNum,
      this.coveredPrice,
      this.normalPrice,
      this.totalRevenue,
      this.normalNumCurrent,
      this.normalNum,
      this.coveredNumCurrent,
      this.versus,
      this.reference})
      : super._();

  @override
  GamesRecord rebuild(void Function(GamesRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GamesRecordBuilder toBuilder() => new GamesRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GamesRecord &&
        date == other.date &&
        boughtBy == other.boughtBy &&
        title == other.title &&
        desc == other.desc &&
        stadium == other.stadium &&
        homeTeam == other.homeTeam &&
        htImageUrl == other.htImageUrl &&
        awayTeam == other.awayTeam &&
        atImageUrl == other.atImageUrl &&
        coveredNum == other.coveredNum &&
        coveredPrice == other.coveredPrice &&
        normalPrice == other.normalPrice &&
        totalRevenue == other.totalRevenue &&
        normalNumCurrent == other.normalNumCurrent &&
        normalNum == other.normalNum &&
        coveredNumCurrent == other.coveredNumCurrent &&
        versus == other.versus &&
        reference == other.reference;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc(
                                        $jc(
                                            $jc(
                                                $jc(
                                                    $jc(
                                                        $jc(
                                                            $jc(
                                                                $jc(
                                                                    $jc(
                                                                        $jc(
                                                                            0,
                                                                            date
                                                                                .hashCode),
                                                                        boughtBy
                                                                            .hashCode),
                                                                    title
                                                                        .hashCode),
                                                                desc.hashCode),
                                                            stadium.hashCode),
                                                        homeTeam.hashCode),
                                                    htImageUrl.hashCode),
                                                awayTeam.hashCode),
                                            atImageUrl.hashCode),
                                        coveredNum.hashCode),
                                    coveredPrice.hashCode),
                                normalPrice.hashCode),
                            totalRevenue.hashCode),
                        normalNumCurrent.hashCode),
                    normalNum.hashCode),
                coveredNumCurrent.hashCode),
            versus.hashCode),
        reference.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GamesRecord')
          ..add('date', date)
          ..add('boughtBy', boughtBy)
          ..add('title', title)
          ..add('desc', desc)
          ..add('stadium', stadium)
          ..add('homeTeam', homeTeam)
          ..add('htImageUrl', htImageUrl)
          ..add('awayTeam', awayTeam)
          ..add('atImageUrl', atImageUrl)
          ..add('coveredNum', coveredNum)
          ..add('coveredPrice', coveredPrice)
          ..add('normalPrice', normalPrice)
          ..add('totalRevenue', totalRevenue)
          ..add('normalNumCurrent', normalNumCurrent)
          ..add('normalNum', normalNum)
          ..add('coveredNumCurrent', coveredNumCurrent)
          ..add('versus', versus)
          ..add('reference', reference))
        .toString();
  }
}

class GamesRecordBuilder implements Builder<GamesRecord, GamesRecordBuilder> {
  _$GamesRecord _$v;

  DateTime _date;
  DateTime get date => _$this._date;
  set date(DateTime date) => _$this._date = date;

  ListBuilder<DocumentReference<Object>> _boughtBy;
  ListBuilder<DocumentReference<Object>> get boughtBy =>
      _$this._boughtBy ??= new ListBuilder<DocumentReference<Object>>();
  set boughtBy(ListBuilder<DocumentReference<Object>> boughtBy) =>
      _$this._boughtBy = boughtBy;

  String _title;
  String get title => _$this._title;
  set title(String title) => _$this._title = title;

  String _desc;
  String get desc => _$this._desc;
  set desc(String desc) => _$this._desc = desc;

  String _stadium;
  String get stadium => _$this._stadium;
  set stadium(String stadium) => _$this._stadium = stadium;

  String _homeTeam;
  String get homeTeam => _$this._homeTeam;
  set homeTeam(String homeTeam) => _$this._homeTeam = homeTeam;

  String _htImageUrl;
  String get htImageUrl => _$this._htImageUrl;
  set htImageUrl(String htImageUrl) => _$this._htImageUrl = htImageUrl;

  String _awayTeam;
  String get awayTeam => _$this._awayTeam;
  set awayTeam(String awayTeam) => _$this._awayTeam = awayTeam;

  String _atImageUrl;
  String get atImageUrl => _$this._atImageUrl;
  set atImageUrl(String atImageUrl) => _$this._atImageUrl = atImageUrl;

  int _coveredNum;
  int get coveredNum => _$this._coveredNum;
  set coveredNum(int coveredNum) => _$this._coveredNum = coveredNum;

  int _coveredPrice;
  int get coveredPrice => _$this._coveredPrice;
  set coveredPrice(int coveredPrice) => _$this._coveredPrice = coveredPrice;

  int _normalPrice;
  int get normalPrice => _$this._normalPrice;
  set normalPrice(int normalPrice) => _$this._normalPrice = normalPrice;

  int _totalRevenue;
  int get totalRevenue => _$this._totalRevenue;
  set totalRevenue(int totalRevenue) => _$this._totalRevenue = totalRevenue;

  int _normalNumCurrent;
  int get normalNumCurrent => _$this._normalNumCurrent;
  set normalNumCurrent(int normalNumCurrent) =>
      _$this._normalNumCurrent = normalNumCurrent;

  int _normalNum;
  int get normalNum => _$this._normalNum;
  set normalNum(int normalNum) => _$this._normalNum = normalNum;

  int _coveredNumCurrent;
  int get coveredNumCurrent => _$this._coveredNumCurrent;
  set coveredNumCurrent(int coveredNumCurrent) =>
      _$this._coveredNumCurrent = coveredNumCurrent;

  String _versus;
  String get versus => _$this._versus;
  set versus(String versus) => _$this._versus = versus;

  DocumentReference<Object> _reference;
  DocumentReference<Object> get reference => _$this._reference;
  set reference(DocumentReference<Object> reference) =>
      _$this._reference = reference;

  GamesRecordBuilder() {
    GamesRecord._initializeBuilder(this);
  }

  GamesRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _date = $v.date;
      _boughtBy = $v.boughtBy?.toBuilder();
      _title = $v.title;
      _desc = $v.desc;
      _stadium = $v.stadium;
      _homeTeam = $v.homeTeam;
      _htImageUrl = $v.htImageUrl;
      _awayTeam = $v.awayTeam;
      _atImageUrl = $v.atImageUrl;
      _coveredNum = $v.coveredNum;
      _coveredPrice = $v.coveredPrice;
      _normalPrice = $v.normalPrice;
      _totalRevenue = $v.totalRevenue;
      _normalNumCurrent = $v.normalNumCurrent;
      _normalNum = $v.normalNum;
      _coveredNumCurrent = $v.coveredNumCurrent;
      _versus = $v.versus;
      _reference = $v.reference;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GamesRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GamesRecord;
  }

  @override
  void update(void Function(GamesRecordBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GamesRecord build() {
    _$GamesRecord _$result;
    try {
      _$result = _$v ??
          new _$GamesRecord._(
              date: date,
              boughtBy: _boughtBy?.build(),
              title: title,
              desc: desc,
              stadium: stadium,
              homeTeam: homeTeam,
              htImageUrl: htImageUrl,
              awayTeam: awayTeam,
              atImageUrl: atImageUrl,
              coveredNum: coveredNum,
              coveredPrice: coveredPrice,
              normalPrice: normalPrice,
              totalRevenue: totalRevenue,
              normalNumCurrent: normalNumCurrent,
              normalNum: normalNum,
              coveredNumCurrent: coveredNumCurrent,
              versus: versus,
              reference: reference);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'boughtBy';
        _boughtBy?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'GamesRecord', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
