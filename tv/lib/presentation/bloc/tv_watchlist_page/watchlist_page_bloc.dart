import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_watchlist_tv.dart';

part 'watchlist_page_event.dart';
part 'watchlist_page_state.dart';

class WatchlistTvPageBloc extends Bloc<WatchlistTvPageEvent, WatchlistTvPageState> {
  final GetWatchlistTv getWatchlistTv;
  
  WatchlistTvPageBloc(this.getWatchlistTv) : super(WatchlistTvPageEmpty()) {
    on<FetchWatchlistTvPage>((event, emit) async {
      emit(WatchlistTvPageLoading());

      final result = await getWatchlistTv.execute();
      result.fold(
        (failure) {
          emit(WatchlistTvPageError(failure.message));
        },
        (data) {
          emit(WatchlistTvPageHasData(data));
        }
      );
    });
  }
}
