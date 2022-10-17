import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';

part 'watchlist_movie_page_event.dart';
part 'watchlist_movie_page_state.dart';

class WatchlistMoviePageBloc extends Bloc<WatchListMoviePageEvent, WatchListMoviePageState> {
  final GetWatchlistMovies getWatchlistMovie;

  WatchlistMoviePageBloc(this.getWatchlistMovie) : super(WatchListMoviePageEmpty()) {
    on<FetchWatchlistMoviePage>((event, emit) async {
      emit(WatchListMoviePageLoading());

      final result = await getWatchlistMovie.execute();

      result.fold(
        (failure) {
          emit(WatchListMoviePageError(failure.message));
        },
        (data) {
          emit(WatchListMoviePageHasData(data));
        }
      );
    });
  }
}
