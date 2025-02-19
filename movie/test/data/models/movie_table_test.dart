import 'package:flutter_test/flutter_test.dart';
import 'package:movie/data/models/movie_table.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  final Map<String, dynamic> movieTableJson = {
    'id': 1,
    'title': 'title',
    'posterPath': 'posterPath',
    'overview': 'overview',
  };

  test('should return to Json movie table correctly', () {
    final result = testMovieTable.toJson();
    expect(result, movieTableJson);
  });
}