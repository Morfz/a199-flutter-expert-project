import 'package:flutter_test/flutter_test.dart';
import 'package:movie/data/models/movie_genre_model.dart';
import 'package:movie/domain/entities/movie_genre.dart';

void main() {
  const tGenreModel = MovieGenreModel(
    id: 1,
    name: 'genre',
  );

  const tGenre = MovieGenre(
    id: 1,
    name: 'genre',
  );

  final tGenreJson = {
    'id': 1,
    'name': 'genre',
  };

  test('should be a subclass Genre entity', () async {
    final result = tGenreModel.toEntity();
    expect(result, tGenre);
  });

  test('should be a subclass Genre Json', () async {
    final result = tGenreModel.toJson();
    expect(result, tGenreJson);
  });
}