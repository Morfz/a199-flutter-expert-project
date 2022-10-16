part of 'watchlist_movie_status_bloc.dart';

class WatchlistMovieStatusState extends Equatable {
  final bool status;
  final String message;

  const WatchlistMovieStatusState(this.status, this.message);

  @override
  List<Object> get props => [status, message];
}

