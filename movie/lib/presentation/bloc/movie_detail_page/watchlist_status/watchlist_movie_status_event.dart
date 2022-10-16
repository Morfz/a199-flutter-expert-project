part of 'watchlist_movie_status_bloc.dart';

abstract class WatchlistMovieStatusEvent extends Equatable {
  const WatchlistMovieStatusEvent();

  @override
  List<Object> get props => [];
}

class AddToWatchlist extends WatchlistMovieStatusEvent {
  final MovieDetail movieDetail;

  AddToWatchlist(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class RemoveFromWatchlist extends WatchlistMovieStatusEvent {
  final MovieDetail movieDetail;

  RemoveFromWatchlist(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class LoadWatclistStatus extends WatchlistMovieStatusEvent {
  final int id;

  LoadWatclistStatus(this.id);

  @override
  List<Object> get props => [id];
}
