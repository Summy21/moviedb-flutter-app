// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'detail_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DetailState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DetailState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DetailState()';
}


}

/// @nodoc
class $DetailStateCopyWith<$Res>  {
$DetailStateCopyWith(DetailState _, $Res Function(DetailState) __);
}


/// Adds pattern-matching-related methods to [DetailState].
extension DetailStatePatterns on DetailState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( DetailInitial value)?  initial,TResult Function( DetailLoading value)?  loading,TResult Function( DetailLoaded value)?  loaded,TResult Function( DetailError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case DetailInitial() when initial != null:
return initial(_that);case DetailLoading() when loading != null:
return loading(_that);case DetailLoaded() when loaded != null:
return loaded(_that);case DetailError() when error != null:
return error(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( DetailInitial value)  initial,required TResult Function( DetailLoading value)  loading,required TResult Function( DetailLoaded value)  loaded,required TResult Function( DetailError value)  error,}){
final _that = this;
switch (_that) {
case DetailInitial():
return initial(_that);case DetailLoading():
return loading(_that);case DetailLoaded():
return loaded(_that);case DetailError():
return error(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( DetailInitial value)?  initial,TResult? Function( DetailLoading value)?  loading,TResult? Function( DetailLoaded value)?  loaded,TResult? Function( DetailError value)?  error,}){
final _that = this;
switch (_that) {
case DetailInitial() when initial != null:
return initial(_that);case DetailLoading() when loading != null:
return loading(_that);case DetailLoaded() when loaded != null:
return loaded(_that);case DetailError() when error != null:
return error(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( MediaDetail detail)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case DetailInitial() when initial != null:
return initial();case DetailLoading() when loading != null:
return loading();case DetailLoaded() when loaded != null:
return loaded(_that.detail);case DetailError() when error != null:
return error(_that.message);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( MediaDetail detail)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case DetailInitial():
return initial();case DetailLoading():
return loading();case DetailLoaded():
return loaded(_that.detail);case DetailError():
return error(_that.message);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( MediaDetail detail)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case DetailInitial() when initial != null:
return initial();case DetailLoading() when loading != null:
return loading();case DetailLoaded() when loaded != null:
return loaded(_that.detail);case DetailError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class DetailInitial implements DetailState {
  const DetailInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DetailInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DetailState.initial()';
}


}




/// @nodoc


class DetailLoading implements DetailState {
  const DetailLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DetailLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DetailState.loading()';
}


}




/// @nodoc


class DetailLoaded implements DetailState {
  const DetailLoaded(this.detail);
  

 final  MediaDetail detail;

/// Create a copy of DetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DetailLoadedCopyWith<DetailLoaded> get copyWith => _$DetailLoadedCopyWithImpl<DetailLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DetailLoaded&&(identical(other.detail, detail) || other.detail == detail));
}


@override
int get hashCode => Object.hash(runtimeType,detail);

@override
String toString() {
  return 'DetailState.loaded(detail: $detail)';
}


}

/// @nodoc
abstract mixin class $DetailLoadedCopyWith<$Res> implements $DetailStateCopyWith<$Res> {
  factory $DetailLoadedCopyWith(DetailLoaded value, $Res Function(DetailLoaded) _then) = _$DetailLoadedCopyWithImpl;
@useResult
$Res call({
 MediaDetail detail
});




}
/// @nodoc
class _$DetailLoadedCopyWithImpl<$Res>
    implements $DetailLoadedCopyWith<$Res> {
  _$DetailLoadedCopyWithImpl(this._self, this._then);

  final DetailLoaded _self;
  final $Res Function(DetailLoaded) _then;

/// Create a copy of DetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? detail = null,}) {
  return _then(DetailLoaded(
null == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as MediaDetail,
  ));
}


}

/// @nodoc


class DetailError implements DetailState {
  const DetailError(this.message);
  

 final  String message;

/// Create a copy of DetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DetailErrorCopyWith<DetailError> get copyWith => _$DetailErrorCopyWithImpl<DetailError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DetailError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'DetailState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $DetailErrorCopyWith<$Res> implements $DetailStateCopyWith<$Res> {
  factory $DetailErrorCopyWith(DetailError value, $Res Function(DetailError) _then) = _$DetailErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$DetailErrorCopyWithImpl<$Res>
    implements $DetailErrorCopyWith<$Res> {
  _$DetailErrorCopyWithImpl(this._self, this._then);

  final DetailError _self;
  final $Res Function(DetailError) _then;

/// Create a copy of DetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(DetailError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
