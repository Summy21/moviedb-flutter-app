import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviedb_flutter_app/features/media/domain/usecases/get_movie_detail.dart';
import 'package:moviedb_flutter_app/features/media/domain/usecases/get_tv_show_detail.dart';
import 'package:moviedb_flutter_app/features/media/presentation/cubit/detail_state.dart';

/// Manages state for the detail screen.
///
/// Handles both movie and TV show detail in a single Cubit
/// since the detail screen layout is the same for both —
/// only the data fields differ.
class DetailCubit extends Cubit<DetailState> {
  DetailCubit({
    required GetMovieDetail getMovieDetail,
    required GetTvShowDetail getTvShowDetail,
  })  : _getMovieDetail = getMovieDetail,
        _getTvShowDetail = getTvShowDetail,
        super(const DetailState.initial());

  final GetMovieDetail _getMovieDetail;
  final GetTvShowDetail _getTvShowDetail;

  /// Fetches full detail for a movie identified by [id].
  Future<void> fetchMovieDetail(int id) async {
    emit(const DetailState.loading());
    final result = await _getMovieDetail(MovieParams(id));
    result.fold(
      (failure) => emit(DetailState.error(failure.message)),
      (detail) => emit(DetailState.loaded(detail)),
    );
  }

  /// Fetches full detail for a TV show identified by [id].
  Future<void> fetchTvShowDetail(int id) async {
    emit(const DetailState.loading());
    final result = await _getTvShowDetail(TvShowParams(id));
    result.fold(
      (failure) => emit(DetailState.error(failure.message)),
      (detail) => emit(DetailState.loaded(detail)),
    );
  }
}