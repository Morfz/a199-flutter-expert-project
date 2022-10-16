part of 'watchlist_movie_status_bloc.dart';

abstract class WatchListMovieStatusEvent extends Equatable {
  const WatchListMovieStatusEvent();

  @override
  List<Object> get props => [];
}

class AddToWatchListMovie extends WatchListMovieStatusEvent {
  final MovieDetail movieDetail;

  const AddToWatchListMovie(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class RemoveFromWatchListMovie extends WatchListMovieStatusEvent {
  final MovieDetail movieDetail;

  const RemoveFromWatchListMovie(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class LoadWatchListMovieStatus extends WatchListMovieStatusEvent {
  final int id;

  const LoadWatchListMovieStatus(this.id);

  @override
  List<Object> get props => [id];
}
