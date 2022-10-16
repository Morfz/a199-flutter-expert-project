part of 'tv_watchlist_status_bloc.dart';

abstract class TvWatchlistStatusEvent extends Equatable {
  const TvWatchlistStatusEvent();

  @override
  List<Object> get props => [];
}

class OnAddToWatchlistTvs extends TvWatchlistStatusEvent {
  final TvDetail tvDetail;

  OnAddToWatchlistTvs(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}

class OnRemoveFromWatchlistTvs extends TvWatchlistStatusEvent {
  final TvDetail tvDetail;

  OnRemoveFromWatchlistTvs(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}

class OnLoadWatchlistTvStatus extends TvWatchlistStatusEvent {
  final int id;

  OnLoadWatchlistTvStatus(this.id);
  
  @override
  List<Object> get props => [id];
}
