import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/domain/usecases/get_watchlist_status.dart';
import 'package:tv/domain/usecases/remove_watchlist.dart';
import 'package:tv/domain/usecases/save_watchlist.dart';

part 'tv_watchlist_status_event.dart';
part 'tv_watchlist_status_state.dart';

class TvWatchlistStatusBloc
    extends Bloc<TvWatchlistStatusEvent, TvWatchlistStatusState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';
  final SaveWatchlistTv saveTvWatchlist;
  final RemoveWatchlistTv removeTvWatchlist;
  final GetWatchListTvStatus getWatchlistTvStatus;
  TvWatchlistStatusBloc({
    required this.saveTvWatchlist, 
    required this.removeTvWatchlist, 
    required this.getWatchlistTvStatus
  }) : super(TvWatchlistStatusState(false, '')) {
    on<OnAddToWatchlistTvs>((event, emit) async {
      final result = await saveTvWatchlist.execute(event.tvDetail);
      String msg = '';
      result.fold((failure) {
        msg = failure.message;
      }, (success) {
        msg = watchlistAddSuccessMessage;
      });
      final status = await getWatchlistTvStatus.execute(event.tvDetail.id);
      emit(TvWatchlistStatusState(status, msg));
    });

    on<OnRemoveFromWatchlistTvs>((event, emit) async {
      final result = await removeTvWatchlist.execute(event.tvDetail);
      String msg = '';
      result.fold((failure) {
        msg = failure.message;
      }, (success) {
        msg = watchlistRemoveSuccessMessage;
      });
      final status = await getWatchlistTvStatus.execute(event.tvDetail.id);
      emit(TvWatchlistStatusState(status, msg));
    });

    on<OnLoadWatchlistTvStatus>((event, emit) async {
      final result = await getWatchlistTvStatus.execute(event.id);
      emit(TvWatchlistStatusState(result, state.message));
    });
  }
}
