part of 'nowplaying_movies_bloc.dart';

abstract class NowplayingMoviesState extends Equatable {
  const NowplayingMoviesState();
  
  @override
  List<Object> get props => [];
}

class NowplayingMoviesEmpty extends NowplayingMoviesState {}

class NowplayingMoviesLoading extends NowplayingMoviesState {}

class NowplayingMoviesError extends NowplayingMoviesState {
  final String message;
 
  const NowplayingMoviesError(this.message);
 
  @override
  List<Object> get props => [message];
}

class NowPlayingMoviesHasData extends NowplayingMoviesState {
  final List<Movie> movie;
 
  const NowPlayingMoviesHasData(this.movie);
 
  @override
  List<Object> get props => [movie];
}