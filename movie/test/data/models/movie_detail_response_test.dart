import 'package:flutter_test/flutter_test.dart';
import 'package:movie/data/models/movie_detail_response.dart';
import 'package:movie/data/models/movie_genre_model.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:movie/domain/entities/movie_genre.dart';

void main() {
  const tMovieDetailModel = MovieDetailResponse(
    adult: false,
    backdropPath: 'backdropPath',
    budget: 1,
    genres: [MovieGenreModel(id: 1, name: 'Action')],
    homepage: 'homepage',
    id: 1,
    imdbId: 'imdbId',
    originalLanguage: 'originalLanguage',
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1.0,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    revenue: 1,
    runtime: 120,
    status: 'status',
    tagline: 'tagline',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );

  const tMovieDetail = MovieDetail(
    adult: false,
    backdropPath: 'backdropPath',
    genres: [MovieGenre(id: 1, name: 'Action')],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    runtime: 120,
    title: 'title',
    voteAverage: 1,
    voteCount: 1,
  );

  final tMovieDetailJson = {
    'adult': false,
    'backdrop_path': 'backdropPath',
    'budget': 1,
    'genres': [{'id': 1, 'name': 'Action'}],
    'homepage': 'homepage',
    'id': 1,
    'imdb_id': 'imdbId',
    'original_language': 'originalLanguage',
    'original_title': 'originalTitle',
    'overview': 'overview',
    'popularity': 1.0,
    'poster_path': 'posterPath',
    'release_date': 'releaseDate',
    'revenue': 1,
    'runtime': 120,
    'status': 'status',
    'tagline': 'tagline',
    'title': 'title',
    'video': false,
    'vote_average': 1,
    'vote_count': 1,
  };

  test('should be a subclass Movie Detail entity', () async {
    final result = tMovieDetailModel.toEntity();
    expect(result, tMovieDetail);
  });

  test('should be a subclass Movie Detail JSON', () async {
    final result = tMovieDetailModel.toJson();
    expect(result, tMovieDetailJson);
  });
}