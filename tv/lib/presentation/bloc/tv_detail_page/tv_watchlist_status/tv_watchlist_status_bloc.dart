import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/domain/usecases/get_watchlist_tv_status.dart';
import 'package:tv/domain/usecases/remove_watchlist_tv.dart';
import 'package:tv/domain/usecases/save_watchlist_tv.dart';

part 'watchlist_tv_status_event.dart';
part 'watchlist_tv_status_state.dart';

class WatchlistTvStatusBloc extends Bloc<WatchlistTvStatusEvent, WatchlistTvStatusState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';
  final SaveWatchlistTv saveTvWatchlist;
  final RemoveWatchlistTv removeTvWatchlist;
  final GetWatchListTvStatus getWatchlistTvStatus;

  WatchlistTvStatusBloc({required this.saveTvWatchlist, required this.removeTvWatchlist, required this.getWatchlistTvStatus}) : super(const WatchlistTvStatusState(false, '')) {
    on<AddToWatchlistTvs>((event, emit) async {
      final result = await saveTvWatchlist.execute(event.tvDetail);
      String msg = '';

      result.fold(
        (failure) {
          msg = failure.message;
        },
        (success) {
          msg = watchlistAddSuccessMessage;
        }
      );
      final status = await getWatchlistTvStatus.execute(event.tvDetail.id);
      emit(WatchlistTvStatusState(status, msg));
    });

    on<RemoveFromWatchlistTvs>((event, emit) async {
      final result = await removeTvWatchlist.execute(event.tvDetail);
      String msg = '';

      result.fold((failure) {
        msg = failure.message;
      }, (success) {
        msg = watchlistRemoveSuccessMessage;
      });
      final status = await getWatchlistTvStatus.execute(event.tvDetail.id);
      emit(WatchlistTvStatusState(status, msg));
    });

    on<LoadWatchlistTvStatus>((event, emit) async {
      final result = await getWatchlistTvStatus.execute(event.id);
      emit(WatchlistTvStatusState(result, state.message));
    });
  }
}
