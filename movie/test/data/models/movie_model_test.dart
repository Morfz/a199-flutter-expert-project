import 'package:movie/data/models/movie_model.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tMovieModel = MovieModel(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );

  final tMovieJson = {
    'adult': false,
    'backdrop_path': 'backdropPath',
    'genre_ids': const [1, 2, 3],
    'id': 1,
    'original_title': 'originalTitle',
    'overview': 'overview',
    'popularity': 1,
    'poster_path': 'posterPath',
    'release_date': 'releaseDate',
    'title': 'title',
    'video': false,
    'vote_average': 1,
    'vote_count': 1,
  };

  test('should be a subclass of Movie entity', () async {
    final result = tMovieModel.toEntity();
    expect(result, tMovie);
  });

  test('should be a subclass of Movie JSON', () async {
    final result = tMovieModel.toJson();
    expect(result, tMovieJson);
  });
}
