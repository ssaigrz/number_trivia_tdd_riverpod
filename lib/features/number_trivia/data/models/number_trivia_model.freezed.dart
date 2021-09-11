// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'number_trivia_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

NumberTriviaModel _$NumberTriviaModelFromJson(Map<String, dynamic> json) {
  return _NumberTriviaModel.fromJson(json);
}

/// @nodoc
class _$NumberTriviaModelTearOff {
  const _$NumberTriviaModelTearOff();

  _NumberTriviaModel call({required String text, required num number}) {
    return _NumberTriviaModel(
      text: text,
      number: number,
    );
  }

  NumberTriviaModel fromJson(Map<String, Object> json) {
    return NumberTriviaModel.fromJson(json);
  }
}

/// @nodoc
const $NumberTriviaModel = _$NumberTriviaModelTearOff();

/// @nodoc
mixin _$NumberTriviaModel {
  String get text => throw _privateConstructorUsedError;
  num get number => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NumberTriviaModelCopyWith<NumberTriviaModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NumberTriviaModelCopyWith<$Res> {
  factory $NumberTriviaModelCopyWith(
          NumberTriviaModel value, $Res Function(NumberTriviaModel) then) =
      _$NumberTriviaModelCopyWithImpl<$Res>;
  $Res call({String text, num number});
}

/// @nodoc
class _$NumberTriviaModelCopyWithImpl<$Res>
    implements $NumberTriviaModelCopyWith<$Res> {
  _$NumberTriviaModelCopyWithImpl(this._value, this._then);

  final NumberTriviaModel _value;
  // ignore: unused_field
  final $Res Function(NumberTriviaModel) _then;

  @override
  $Res call({
    Object? text = freezed,
    Object? number = freezed,
  }) {
    return _then(_value.copyWith(
      text: text == freezed
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      number: number == freezed
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as num,
    ));
  }
}

/// @nodoc
abstract class _$NumberTriviaModelCopyWith<$Res>
    implements $NumberTriviaModelCopyWith<$Res> {
  factory _$NumberTriviaModelCopyWith(
          _NumberTriviaModel value, $Res Function(_NumberTriviaModel) then) =
      __$NumberTriviaModelCopyWithImpl<$Res>;
  @override
  $Res call({String text, num number});
}

/// @nodoc
class __$NumberTriviaModelCopyWithImpl<$Res>
    extends _$NumberTriviaModelCopyWithImpl<$Res>
    implements _$NumberTriviaModelCopyWith<$Res> {
  __$NumberTriviaModelCopyWithImpl(
      _NumberTriviaModel _value, $Res Function(_NumberTriviaModel) _then)
      : super(_value, (v) => _then(v as _NumberTriviaModel));

  @override
  _NumberTriviaModel get _value => super._value as _NumberTriviaModel;

  @override
  $Res call({
    Object? text = freezed,
    Object? number = freezed,
  }) {
    return _then(_NumberTriviaModel(
      text: text == freezed
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      number: number == freezed
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as num,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_NumberTriviaModel extends _NumberTriviaModel {
  const _$_NumberTriviaModel({required this.text, required this.number})
      : super._();

  factory _$_NumberTriviaModel.fromJson(Map<String, dynamic> json) =>
      _$$_NumberTriviaModelFromJson(json);

  @override
  final String text;
  @override
  final num number;

  @override
  String toString() {
    return 'NumberTriviaModel(text: $text, number: $number)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _NumberTriviaModel &&
            (identical(other.text, text) ||
                const DeepCollectionEquality().equals(other.text, text)) &&
            (identical(other.number, number) ||
                const DeepCollectionEquality().equals(other.number, number)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(text) ^
      const DeepCollectionEquality().hash(number);

  @JsonKey(ignore: true)
  @override
  _$NumberTriviaModelCopyWith<_NumberTriviaModel> get copyWith =>
      __$NumberTriviaModelCopyWithImpl<_NumberTriviaModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_NumberTriviaModelToJson(this);
  }
}

abstract class _NumberTriviaModel extends NumberTriviaModel {
  const factory _NumberTriviaModel(
      {required String text, required num number}) = _$_NumberTriviaModel;
  const _NumberTriviaModel._() : super._();

  factory _NumberTriviaModel.fromJson(Map<String, dynamic> json) =
      _$_NumberTriviaModel.fromJson;

  @override
  String get text => throw _privateConstructorUsedError;
  @override
  num get number => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$NumberTriviaModelCopyWith<_NumberTriviaModel> get copyWith =>
      throw _privateConstructorUsedError;
}
