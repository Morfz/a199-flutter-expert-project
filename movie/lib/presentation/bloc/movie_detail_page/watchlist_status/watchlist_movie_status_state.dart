part of 'watchlist_movie_status_bloc.dart';

class WatchListMovieStatusState extends Equatable {
  final bool status;
  final String message;

  const WatchListMovieStatusState(this.status, this.message);

  @override
  List<Object> get props => [status, message];
}

