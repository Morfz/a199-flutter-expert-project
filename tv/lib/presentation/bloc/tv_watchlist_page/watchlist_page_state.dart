part of 'watchlist_page_bloc.dart';

abstract class WatchlistTvPageState extends Equatable {
  const WatchlistTvPageState();
  
  @override
  List<Object> get props => [];
}

class WatchlistTvPageEmpty extends WatchlistTvPageState {}

class WatchlistTvPageLoading extends WatchlistTvPageState {}

class WatchlistTvPageError extends WatchlistTvPageState {
  final String message;

  const WatchlistTvPageError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistTvPageHasData extends WatchlistTvPageState {
  final List<Tv> watchlistTv;

  const WatchlistTvPageHasData(this.watchlistTv);

  @override
  List<Object> get props => [watchlistTv];
}
