import 'package:dartz/dartz.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:core/core.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies();
  Future<Either<Failure, List<Movie>>> getPopularMovies();
  Future<Either<Failure, List<Movie>>> getTopRatedMovies();
  Future<Either<Failure, MovieDetail>> getMovieDetail(int id);
  Future<Either<Failure, List<Movie>>> getMovieRecommendations(int id);
  Future<Either<Failure, List<Movie>>> searchMovies(String query);
  Future<Either<Failure, String>> saveWatchlistMovie(MovieDetail movie);
  Future<Either<Failure, String>> removeWatchlistMovie(MovieDetail movie);
  Future<bool> isAddedToWatchlistMovie(int id);
  Future<Either<Failure, List<Movie>>> getWatchlistMovies();
}
