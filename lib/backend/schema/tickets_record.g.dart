// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tickets_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<TicketsRecord> _$ticketsRecordSerializer =
    new _$TicketsRecordSerializer();

class _$TicketsRecordSerializer implements StructuredSerializer<TicketsRecord> {
  @override
  final Iterable<Type> types = const [TicketsRecord, _$TicketsRecord];
  @override
  final String wireName = 'TicketsRecord';

  @override
  Iterable<Object> serialize(Serializers serializers, TicketsRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    Object value;
    value = object.code;
    if (value != null) {
      result
        ..add('code')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.user;
    if (value != null) {
      result
        ..add('user')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType(Object)])));
    }
    value = object.game;
    if (value != null) {
      result
        ..add('game')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType(Object)])));
    }
    value = object.purchasedOn;
    if (value != null) {
      result
        ..add('purchased_on')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.qrCode;
    if (value != null) {
      result
        ..add('qr_code')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.isCovered;
    if (value != null) {
      result
        ..add('is_covered')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.isValid;
    if (value != null) {
      result
        ..add('is_valid')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.price;
    if (value != null) {
      result
        ..add('price')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType(Object)])));
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
  TicketsRecord deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TicketsRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'code':
          result.code = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'user':
          result.user = serializers.deserialize(value,
                  specifiedType: const FullType(
                      DocumentReference, const [const FullType(Object)]))
              as DocumentReference<Object>;
          break;
        case 'game':
          result.game = serializers.deserialize(value,
                  specifiedType: const FullType(
                      DocumentReference, const [const FullType(Object)]))
              as DocumentReference<Object>;
          break;
        case 'purchased_on':
          result.purchasedOn = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
        case 'qr_code':
          result.qrCode = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'is_covered':
          result.isCovered = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'is_valid':
          result.isValid = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'price':
          result.price = serializers.deserialize(value,
                  specifiedType: const FullType(
                      DocumentReference, const [const FullType(Object)]))
              as DocumentReference<Object>;
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

class _$TicketsRecord extends TicketsRecord {
  @override
  final String code;
  @override
  final DocumentReference<Object> user;
  @override
  final DocumentReference<Object> game;
  @override
  final DateTime purchasedOn;
  @override
  final String qrCode;
  @override
  final bool isCovered;
  @override
  final bool isValid;
  @override
  final DocumentReference<Object> price;
  @override
  final DocumentReference<Object> reference;

  factory _$TicketsRecord([void Function(TicketsRecordBuilder) updates]) =>
      (new TicketsRecordBuilder()..update(updates)).build();

  _$TicketsRecord._(
      {this.code,
      this.user,
      this.game,
      this.purchasedOn,
      this.qrCode,
      this.isCovered,
      this.isValid,
      this.price,
      this.reference})
      : super._();

  @override
  TicketsRecord rebuild(void Function(TicketsRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TicketsRecordBuilder toBuilder() => new TicketsRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TicketsRecord &&
        code == other.code &&
        user == other.user &&
        game == other.game &&
        purchasedOn == other.purchasedOn &&
        qrCode == other.qrCode &&
        isCovered == other.isCovered &&
        isValid == other.isValid &&
        price == other.price &&
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
                            $jc($jc($jc(0, code.hashCode), user.hashCode),
                                game.hashCode),
                            purchasedOn.hashCode),
                        qrCode.hashCode),
                    isCovered.hashCode),
                isValid.hashCode),
            price.hashCode),
        reference.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TicketsRecord')
          ..add('code', code)
          ..add('user', user)
          ..add('game', game)
          ..add('purchasedOn', purchasedOn)
          ..add('qrCode', qrCode)
          ..add('isCovered', isCovered)
          ..add('isValid', isValid)
          ..add('price', price)
          ..add('reference', reference))
        .toString();
  }
}

class TicketsRecordBuilder
    implements Builder<TicketsRecord, TicketsRecordBuilder> {
  _$TicketsRecord _$v;

  String _code;
  String get code => _$this._code;
  set code(String code) => _$this._code = code;

  DocumentReference<Object> _user;
  DocumentReference<Object> get user => _$this._user;
  set user(DocumentReference<Object> user) => _$this._user = user;

  DocumentReference<Object> _game;
  DocumentReference<Object> get game => _$this._game;
  set game(DocumentReference<Object> game) => _$this._game = game;

  DateTime _purchasedOn;
  DateTime get purchasedOn => _$this._purchasedOn;
  set purchasedOn(DateTime purchasedOn) => _$this._purchasedOn = purchasedOn;

  String _qrCode;
  String get qrCode => _$this._qrCode;
  set qrCode(String qrCode) => _$this._qrCode = qrCode;

  bool _isCovered;
  bool get isCovered => _$this._isCovered;
  set isCovered(bool isCovered) => _$this._isCovered = isCovered;

  bool _isValid;
  bool get isValid => _$this._isValid;
  set isValid(bool isValid) => _$this._isValid = isValid;

  DocumentReference<Object> _price;
  DocumentReference<Object> get price => _$this._price;
  set price(DocumentReference<Object> price) => _$this._price = price;

  DocumentReference<Object> _reference;
  DocumentReference<Object> get reference => _$this._reference;
  set reference(DocumentReference<Object> reference) =>
      _$this._reference = reference;

  TicketsRecordBuilder() {
    TicketsRecord._initializeBuilder(this);
  }

  TicketsRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _code = $v.code;
      _user = $v.user;
      _game = $v.game;
      _purchasedOn = $v.purchasedOn;
      _qrCode = $v.qrCode;
      _isCovered = $v.isCovered;
      _isValid = $v.isValid;
      _price = $v.price;
      _reference = $v.reference;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TicketsRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$TicketsRecord;
  }

  @override
  void update(void Function(TicketsRecordBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$TicketsRecord build() {
    final _$result = _$v ??
        new _$TicketsRecord._(
            code: code,
            user: user,
            game: game,
            purchasedOn: purchasedOn,
            qrCode: qrCode,
            isCovered: isCovered,
            isValid: isValid,
            price: price,
            reference: reference);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
