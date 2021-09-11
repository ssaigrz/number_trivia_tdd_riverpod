// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'number_trivia.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$NumberTriviaTearOff {
  const _$NumberTriviaTearOff();

  _NumberTrivia call({required String text, required num number}) {
    return _NumberTrivia(
      text: text,
      number: number,
    );
  }
}

/// @nodoc
const $NumberTrivia = _$NumberTriviaTearOff();

/// @nodoc
mixin _$NumberTrivia {
  String get text => throw _privateConstructorUsedError;
  num get number => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NumberTriviaCopyWith<NumberTrivia> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NumberTriviaCopyWith<$Res> {
  factory $NumberTriviaCopyWith(
          NumberTrivia value, $Res Function(NumberTrivia) then) =
      _$NumberTriviaCopyWithImpl<$Res>;
  $Res call({String text, num number});
}

/// @nodoc
class _$NumberTriviaCopyWithImpl<$Res> implements $NumberTriviaCopyWith<$Res> {
  _$NumberTriviaCopyWithImpl(this._value, this._then);

  final NumberTrivia _value;
  // ignore: unused_field
  final $Res Function(NumberTrivia) _then;

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
abstract class _$NumberTriviaCopyWith<$Res>
    implements $NumberTriviaCopyWith<$Res> {
  factory _$NumberTriviaCopyWith(
          _NumberTrivia value, $Res Function(_NumberTrivia) then) =
      __$NumberTriviaCopyWithImpl<$Res>;
  @override
  $Res call({String text, num number});
}

/// @nodoc
class __$NumberTriviaCopyWithImpl<$Res> extends _$NumberTriviaCopyWithImpl<$Res>
    implements _$NumberTriviaCopyWith<$Res> {
  __$NumberTriviaCopyWithImpl(
      _NumberTrivia _value, $Res Function(_NumberTrivia) _then)
      : super(_value, (v) => _then(v as _NumberTrivia));

  @override
  _NumberTrivia get _value => super._value as _NumberTrivia;

  @override
  $Res call({
    Object? text = freezed,
    Object? number = freezed,
  }) {
    return _then(_NumberTrivia(
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

class _$_NumberTrivia extends _NumberTrivia {
  const _$_NumberTrivia({required this.text, required this.number}) : super._();

  @override
  final String text;
  @override
  final num number;

  @override
  String toString() {
    return 'NumberTrivia(text: $text, number: $number)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _NumberTrivia &&
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
  _$NumberTriviaCopyWith<_NumberTrivia> get copyWith =>
      __$NumberTriviaCopyWithImpl<_NumberTrivia>(this, _$identity);
}

abstract class _NumberTrivia extends NumberTrivia {
  const factory _NumberTrivia({required String text, required num number}) =
      _$_NumberTrivia;
  const _NumberTrivia._() : super._();

  @override
  String get text => throw _privateConstructorUsedError;
  @override
  num get number => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$NumberTriviaCopyWith<_NumberTrivia> get copyWith =>
      throw _privateConstructorUsedError;
}
