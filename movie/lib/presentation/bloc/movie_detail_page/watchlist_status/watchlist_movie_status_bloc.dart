import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:movie/domain/usecases/get_watchlist_movie_status.dart';
import 'package:movie/domain/usecases/remove_watchlist_movie.dart';
import 'package:movie/domain/usecases/save_watchlist_movie.dart';

part 'watchlist_movie_status_event.dart';
part 'watchlist_movie_status_state.dart';

class WatchlistMovieStatusBloc extends Bloc<WatchListMovieStatusEvent, WatchListMovieStatusState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetWatchListMovieStatus getWatchlistStatus;
  final SaveWatchlistMovie saveWatchlist;
  final RemoveWatchlistMovie removeWatchlist;

  WatchlistMovieStatusBloc({required this.getWatchlistStatus, required this.saveWatchlist, required this.removeWatchlist}) : super(const WatchListMovieStatusState(false, '')) {
    on<AddToWatchListMovie>((event, emit) async {
      final result = await saveWatchlist.execute(event.movieDetail);
      String msg = '';

      result.fold(
        (failure) {
          msg = failure.message;
        },
        (success) async {
          msg = watchlistAddSuccessMessage;
        }
      );

      final status = await getWatchlistStatus.execute(event.movieDetail.id);
      emit(WatchListMovieStatusState(status, msg));
    });

    on<RemoveFromWatchListMovie>((event, emit) async {
      final result = await removeWatchlist.execute(event.movieDetail);
      String msg = '';

      result.fold(
        (failure) {
          msg = failure.message;
        },
        (success) async {
          msg = watchlistRemoveSuccessMessage;
        }
      );
      final status = await getWatchlistStatus.execute(event.movieDetail.id);
      emit(WatchListMovieStatusState(status, msg));
    });

    on<LoadWatchListMovieStatus>((event, emit) async {
      final result = await getWatchlistStatus.execute(event.id);
      emit(WatchListMovieStatusState(result, ''));
    });
  }
}
