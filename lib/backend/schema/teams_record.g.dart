// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teams_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<TeamsRecord> _$teamsRecordSerializer = new _$TeamsRecordSerializer();

class _$TeamsRecordSerializer implements StructuredSerializer<TeamsRecord> {
  @override
  final Iterable<Type> types = const [TeamsRecord, _$TeamsRecord];
  @override
  final String wireName = 'TeamsRecord';

  @override
  Iterable<Object> serialize(Serializers serializers, TeamsRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    Object value;
    value = object.name;
    if (value != null) {
      result
        ..add('name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.imageUrl;
    if (value != null) {
      result
        ..add('image_url')
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
  TeamsRecord deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TeamsRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'image_url':
          result.imageUrl = serializers.deserialize(value,
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

class _$TeamsRecord extends TeamsRecord {
  @override
  final String name;
  @override
  final String imageUrl;
  @override
  final DocumentReference<Object> reference;

  factory _$TeamsRecord([void Function(TeamsRecordBuilder) updates]) =>
      (new TeamsRecordBuilder()..update(updates)).build();

  _$TeamsRecord._({this.name, this.imageUrl, this.reference}) : super._();

  @override
  TeamsRecord rebuild(void Function(TeamsRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TeamsRecordBuilder toBuilder() => new TeamsRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TeamsRecord &&
        name == other.name &&
        imageUrl == other.imageUrl &&
        reference == other.reference;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, name.hashCode), imageUrl.hashCode), reference.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TeamsRecord')
          ..add('name', name)
          ..add('imageUrl', imageUrl)
          ..add('reference', reference))
        .toString();
  }
}

class TeamsRecordBuilder implements Builder<TeamsRecord, TeamsRecordBuilder> {
  _$TeamsRecord _$v;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _imageUrl;
  String get imageUrl => _$this._imageUrl;
  set imageUrl(String imageUrl) => _$this._imageUrl = imageUrl;

  DocumentReference<Object> _reference;
  DocumentReference<Object> get reference => _$this._reference;
  set reference(DocumentReference<Object> reference) =>
      _$this._reference = reference;

  TeamsRecordBuilder() {
    TeamsRecord._initializeBuilder(this);
  }

  TeamsRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _imageUrl = $v.imageUrl;
      _reference = $v.reference;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TeamsRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$TeamsRecord;
  }

  @override
  void update(void Function(TeamsRecordBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$TeamsRecord build() {
    final _$result = _$v ??
        new _$TeamsRecord._(
            name: name, imageUrl: imageUrl, reference: reference);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
