import 'package:flutter_test/flutter_test.dart';
import 'package:tv/data/models/tv_detail_response.dart';
import 'package:tv/data/models/tv_genre_model.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/domain/entities/tv_genre.dart';

void main() {
  const tTvDetailModel = TvDetailResponse(
    backdropPath: 'backdropPath',
    genres: [TvGenreModel(id: 1, name: 'Action')],
    homepage: 'homepage',
    id: 1,
    originalLanguage: 'originalLanguage',
    originalName: 'originalTitle',
    overview: 'overview',
    popularity: 1.0,
    posterPath: 'posterPath',
    firstAirDate: 'releaseDate',
    status: 'status',
    tagline: 'tagline',
    name: 'title',
    numberOfEpisodes: 1,
    numberOfSeasons: 1,
    voteAverage: 1,
    voteCount: 1,
  );

  const tTvDetail = TvDetail(
    backdropPath: 'backdropPath',
    genres: [TvGenre(id: 1, name: 'Action')],
    id: 1,
    originalName: 'originalTitle',
    overview: 'overview',
    posterPath: 'posterPath',
    firstAirDate: 'releaseDate',
    name: 'title',
    numberOfEpisodes: 1,
    numberOfSeasons: 1,
    voteAverage: 1,
    voteCount: 1,
  );

  final tTvDetailJson = {
    'backdrop_path': 'backdropPath',
    'genres': [{'id': 1, 'name': 'Action'}],
    'homepage': 'homepage',
    'id': 1,
    'original_language': 'originalLanguage',
    'original_name': 'originalTitle',
    'overview': 'overview',
    'popularity': 1.0,
    'poster_path': 'posterPath',
    'first_air_date': 'releaseDate',
    'status': 'status',
    'tagline': 'tagline',
    'name': 'title',
    'number_of_episodes': 1,
    'number_of_seasons': 1,
    'vote_average': 1.0,
    'vote_count': 1
  };

  test('should be a subclass Tv Detail entity', () async {
    final result = tTvDetailModel.toEntity();
    expect(result, tTvDetail);
  });

  test('should be a subclass Tv Detail JSON', () async {
    final result = tTvDetailModel.toJson();
    expect(result, tTvDetailJson);
  });
}