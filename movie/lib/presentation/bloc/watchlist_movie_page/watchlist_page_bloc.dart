import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';

part 'watchlist_page_event.dart';
part 'watchlist_page_state.dart';

class MovieWatchlistPageBloc
    extends Bloc<WatchlistMoviePageEvent, WatchlistMoviePageState> {
  final GetWatchlistMovies getWatchlistMovie;

  MovieWatchlistPageBloc(this.getWatchlistMovie)
      : super(WatchlistPageEmpty()) {
    on<FetchWatchlistMoviePage>((event, emit) async {
      emit(WatchlistPageLoading());

      final result = await getWatchlistMovie.execute();

      result.fold(
              (failure) {
            emit(WatchlistPageError(failure.message));
          },
              (data) {
            emit(WatchlistPageHasData(data));
          }
      );
    });
  }
}
