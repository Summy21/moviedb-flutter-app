// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tv_shows_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TvShowsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TvShowsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TvShowsState()';
}


}

/// @nodoc
class $TvShowsStateCopyWith<$Res>  {
$TvShowsStateCopyWith(TvShowsState _, $Res Function(TvShowsState) __);
}


/// Adds pattern-matching-related methods to [TvShowsState].
extension TvShowsStatePatterns on TvShowsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( TvShowsInitial value)?  initial,TResult Function( TvShowsLoading value)?  loading,TResult Function( TvShowsLoaded value)?  loaded,TResult Function( TvShowsError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case TvShowsInitial() when initial != null:
return initial(_that);case TvShowsLoading() when loading != null:
return loading(_that);case TvShowsLoaded() when loaded != null:
return loaded(_that);case TvShowsError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( TvShowsInitial value)  initial,required TResult Function( TvShowsLoading value)  loading,required TResult Function( TvShowsLoaded value)  loaded,required TResult Function( TvShowsError value)  error,}){
final _that = this;
switch (_that) {
case TvShowsInitial():
return initial(_that);case TvShowsLoading():
return loading(_that);case TvShowsLoaded():
return loaded(_that);case TvShowsError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( TvShowsInitial value)?  initial,TResult? Function( TvShowsLoading value)?  loading,TResult? Function( TvShowsLoaded value)?  loaded,TResult? Function( TvShowsError value)?  error,}){
final _that = this;
switch (_that) {
case TvShowsInitial() when initial != null:
return initial(_that);case TvShowsLoading() when loading != null:
return loading(_that);case TvShowsLoaded() when loaded != null:
return loaded(_that);case TvShowsError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<TvShow> tvShows)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case TvShowsInitial() when initial != null:
return initial();case TvShowsLoading() when loading != null:
return loading();case TvShowsLoaded() when loaded != null:
return loaded(_that.tvShows);case TvShowsError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<TvShow> tvShows)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case TvShowsInitial():
return initial();case TvShowsLoading():
return loading();case TvShowsLoaded():
return loaded(_that.tvShows);case TvShowsError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<TvShow> tvShows)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case TvShowsInitial() when initial != null:
return initial();case TvShowsLoading() when loading != null:
return loading();case TvShowsLoaded() when loaded != null:
return loaded(_that.tvShows);case TvShowsError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class TvShowsInitial implements TvShowsState {
  const TvShowsInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TvShowsInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TvShowsState.initial()';
}


}




/// @nodoc


class TvShowsLoading implements TvShowsState {
  const TvShowsLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TvShowsLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TvShowsState.loading()';
}


}




/// @nodoc


class TvShowsLoaded implements TvShowsState {
  const TvShowsLoaded(final  List<TvShow> tvShows): _tvShows = tvShows;
  

 final  List<TvShow> _tvShows;
 List<TvShow> get tvShows {
  if (_tvShows is EqualUnmodifiableListView) return _tvShows;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tvShows);
}


/// Create a copy of TvShowsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TvShowsLoadedCopyWith<TvShowsLoaded> get copyWith => _$TvShowsLoadedCopyWithImpl<TvShowsLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TvShowsLoaded&&const DeepCollectionEquality().equals(other._tvShows, _tvShows));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_tvShows));

@override
String toString() {
  return 'TvShowsState.loaded(tvShows: $tvShows)';
}


}

/// @nodoc
abstract mixin class $TvShowsLoadedCopyWith<$Res> implements $TvShowsStateCopyWith<$Res> {
  factory $TvShowsLoadedCopyWith(TvShowsLoaded value, $Res Function(TvShowsLoaded) _then) = _$TvShowsLoadedCopyWithImpl;
@useResult
$Res call({
 List<TvShow> tvShows
});




}
/// @nodoc
class _$TvShowsLoadedCopyWithImpl<$Res>
    implements $TvShowsLoadedCopyWith<$Res> {
  _$TvShowsLoadedCopyWithImpl(this._self, this._then);

  final TvShowsLoaded _self;
  final $Res Function(TvShowsLoaded) _then;

/// Create a copy of TvShowsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tvShows = null,}) {
  return _then(TvShowsLoaded(
null == tvShows ? _self._tvShows : tvShows // ignore: cast_nullable_to_non_nullable
as List<TvShow>,
  ));
}


}

/// @nodoc


class TvShowsError implements TvShowsState {
  const TvShowsError(this.message);
  

 final  String message;

/// Create a copy of TvShowsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TvShowsErrorCopyWith<TvShowsError> get copyWith => _$TvShowsErrorCopyWithImpl<TvShowsError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TvShowsError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'TvShowsState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $TvShowsErrorCopyWith<$Res> implements $TvShowsStateCopyWith<$Res> {
  factory $TvShowsErrorCopyWith(TvShowsError value, $Res Function(TvShowsError) _then) = _$TvShowsErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$TvShowsErrorCopyWithImpl<$Res>
    implements $TvShowsErrorCopyWith<$Res> {
  _$TvShowsErrorCopyWithImpl(this._self, this._then);

  final TvShowsError _self;
  final $Res Function(TvShowsError) _then;

/// Create a copy of TvShowsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(TvShowsError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
