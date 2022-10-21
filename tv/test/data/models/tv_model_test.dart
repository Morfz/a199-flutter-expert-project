import 'package:tv/data/models/tv_model.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tTvModel = TvModel(
    backdropPath: 'backdropPath',
    genreIds: [1, 2],
    id: 1,
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1.0,
    posterPath: 'posterPath',
    firstAirDate: 'firstAirDate',
     name: 'name',
    voteAverage: 1.0,
    voteCount: 1, 
  );

  final tTv = Tv(
    backdropPath: 'backdropPath',
    genreIds: const [1, 2],
    id: 1,
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1.0,
    posterPath: 'posterPath',
    firstAirDate: 'firstAirDate',
    name: 'name',
    voteAverage: 1.0,
    voteCount: 1,
  );

  final tTvJson = {
    'backdrop_path': 'backdropPath',
    'genre_ids': [1, 2],
    'id': 1,
    'original_name': 'originalName',
    'overview': 'overview',
    'popularity': 1.0,
    'poster_path': 'posterPath',
    'release_date': 'firstAirDate',
    'name': 'name',
    'vote_average': 1.0,
    'vote_count': 1
  };

  test('should be a subclass of TV Series entity', () async {
    final result = tTvModel.toEntity();
    expect(result, tTv);
  });

  test('should be a subclass of Tv JSON', () async {
    final result = tTvModel.toJson();
    expect(result, tTvJson);
  });
}
