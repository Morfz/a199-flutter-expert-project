part of 'watchlist_page_bloc.dart';

abstract class WatchlistMoviePageState extends Equatable {
  const WatchlistMoviePageState();
  
  @override
  List<Object> get props => [];
}

class WatchlistPageEmpty extends WatchlistMoviePageState {}

class WatchlistPageLoading extends WatchlistMoviePageState {}

class WatchlistPageError extends WatchlistMoviePageState {
  final String message;

  const WatchlistPageError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistPageHasData extends WatchlistMoviePageState {
  final List<Movie> movie;

  const WatchlistPageHasData(this.movie);

  @override
  List<Object> get props => [movie];
}
