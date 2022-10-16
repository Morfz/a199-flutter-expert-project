part of 'tv_watchlist_status_bloc.dart';

abstract class WatchlistTvStatusEvent extends Equatable {
  const WatchlistTvStatusEvent();

  @override
  List<Object> get props => [];
}

class AddToWatchlistTvs extends WatchlistTvStatusEvent {
  final TvDetail tvDetail;

  const AddToWatchlistTvs(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}

class RemoveFromWatchlistTvs extends WatchlistTvStatusEvent {
  final TvDetail tvDetail;

  const RemoveFromWatchlistTvs(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}

class LoadWatchlistTvStatus extends WatchlistTvStatusEvent {
  final int id;

  const LoadWatchlistTvStatus(this.id);
  
  @override
  List<Object> get props => [id];
}
