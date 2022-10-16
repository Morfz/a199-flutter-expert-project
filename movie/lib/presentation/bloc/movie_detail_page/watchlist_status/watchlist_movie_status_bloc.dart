import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:movie/domain/usecases/get_watchlist_movie_status.dart';
import 'package:movie/domain/usecases/remove_watchlist_movie.dart';
import 'package:movie/domain/usecases/save_watchlist_movie.dart';

part 'watchlist_movie_status_event.dart';
part 'watchlist_movie_status_state.dart';

class WatchlistMovieStatusBloc extends Bloc<WatchlistMovieStatusEvent, WatchlistMovieStatusState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';
  final GetWatchListMovieStatus getWatchlistStatus;
  final SaveWatchlistMovie saveWatchlist;
  final RemoveWatchlistMovie removeWatchlist;
  WatchlistMovieStatusBloc(
      {required this.getWatchlistStatus,
      required this.saveWatchlist,
      required this.removeWatchlist})
      : super(WatchlistMovieStatusState(false, '')) {
    on<AddToWatchlist>((event, emit) async {
      final result = await saveWatchlist.execute(event.movieDetail);
      String msg = '';
      // bool status = state.status;
      result.fold((failure) {
        msg = failure.message;
      }, (success) async {
        msg = watchlistAddSuccessMessage;
        // status = await getWatchlistStatus.execute(event.movieDetail.id);
      });
      final status = await getWatchlistStatus.execute(event.movieDetail.id);
      emit(WatchlistMovieStatusState(status, msg));
    });

    on<RemoveFromWatchlist>((event, emit) async {
      final result = await removeWatchlist.execute(event.movieDetail);
      String msg = '';
      // bool status = state.status;
      result.fold((failure) {
        msg = failure.message;
      }, (success) async {
        msg = watchlistRemoveSuccessMessage;
        // status = await getWatchlistStatus.execute(event.movieDetail.id);
      });
      final status = await getWatchlistStatus.execute(event.movieDetail.id);
      emit(WatchlistMovieStatusState(status, msg));
    });

    on<LoadWatclistStatus>((event, emit) async {
      final result = await getWatchlistStatus.execute(event.id);
      emit(WatchlistMovieStatusState(result, ''));
    });
  }
}
