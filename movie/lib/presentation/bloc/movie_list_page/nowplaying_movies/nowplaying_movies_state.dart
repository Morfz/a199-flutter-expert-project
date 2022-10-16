part of 'nowplaying_movies_bloc.dart';

abstract class NowPlayingMoviesState extends Equatable {
  const NowPlayingMoviesState();
  
  @override
  List<Object> get props => [];
}

class NowPlayingMoviesEmpty extends NowPlayingMoviesState {}

class NowPlayingMoviesLoading extends NowPlayingMoviesState {}

class NowPlayingMoviesError extends NowPlayingMoviesState {
  final String message;
 
  const NowPlayingMoviesError(this.message);
 
  @override
  List<Object> get props => [message];
}

class NowPlayingMoviesHasData extends NowPlayingMoviesState {
  final List<Movie> nowPlayingMovie;
 
  const NowPlayingMoviesHasData(this.nowPlayingMovie);
 
  @override
  List<Object> get props => [nowPlayingMovie];
}