part of 'watchlist_movie_page_bloc.dart';

abstract class WatchListMoviePageState extends Equatable {
  const WatchListMoviePageState();
  
  @override
  List<Object> get props => [];
}

class WatchListMoviePageEmpty extends WatchListMoviePageState {}

class WatchListMoviePageLoading extends WatchListMoviePageState {}

class WatchListMoviePageError extends WatchListMoviePageState {
  final String message;

  const WatchListMoviePageError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchListMoviePageHasData extends WatchListMoviePageState {
  final List<Movie> watchListMovie;

  const WatchListMoviePageHasData(this.watchListMovie);

  @override
  List<Object> get props => [watchListMovie];
}
