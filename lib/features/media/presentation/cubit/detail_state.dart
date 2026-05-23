import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moviedb_flutter_app/features/media/domain/entities/media_detail.dart';

part 'detail_state.freezed.dart';

/// Represents all possible states of the detail screen.
@freezed
sealed class DetailState with _$DetailState {
  /// Initial state before detail fetch is triggered.
  const factory DetailState.initial() = DetailInitial;

  /// Detail fetch is in progress.
  const factory DetailState.loading() = DetailLoading;

  /// Detail fetch completed successfully.
  const factory DetailState.loaded(MediaDetail detail) = DetailLoaded;

  /// Detail fetch failed — [message] describes what went wrong.
  const factory DetailState.error(String message) = DetailError;
}