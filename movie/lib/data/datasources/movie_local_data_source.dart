import 'package:movie/data/datasources/db/movie_database_helper.dart';
import 'package:movie/data/models/movie_table.dart';
import 'package:core/core.dart';

abstract class MovieLocalDataSource {
  Future<String> insertWatchlistMovie(MovieTable movie);
  Future<String> removeWatchlistMovie(MovieTable movie);
  Future<MovieTable?> getMovieById(int id);
  Future<List<MovieTable>> getWatchlistMovie();
}

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  final MovieDatabaseHelper databaseHelper;

  MovieLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlistMovie(MovieTable movie) async {
    try {
      await databaseHelper.insertWatchlistMovie(movie);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlistMovie(MovieTable movie) async {
    try {
      await databaseHelper.removeWatchlistMovie(movie);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<MovieTable?> getMovieById(int id) async {
    final result = await databaseHelper.getMovieById(id);
    if (result != null) {
      return MovieTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<MovieTable>> getWatchlistMovie() async {
    final result = await databaseHelper.getWatchlistMovie();
    return result.map((data) => MovieTable.fromMap(data)).toList();
  }
}
