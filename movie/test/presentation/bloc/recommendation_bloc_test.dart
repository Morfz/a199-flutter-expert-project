import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/presentation/bloc/movie_detail_page/movie_recommendation/movie_recommendation_bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:core/core.dart';

import 'recommendation_bloc_test.mocks.dart';

@GenerateMocks([GetMovieRecommendations])
void main() {
  late MovieRecommendationBloc movieRecomendationBloc;
  late MockGetMovieRecommendations mockGetMovieRecomendations;

  setUp(() {
    mockGetMovieRecomendations = MockGetMovieRecommendations();
    movieRecomendationBloc =
        MovieRecommendationBloc(mockGetMovieRecomendations);
  });

  const tId = 1;

  final tMovie = Movie(
    adult: false,
    backdropPath: '/backdropPath.jpg',
    genreIds: const [14, 28],
    id: 557,
    originalTitle: 'originalTitle',
    overview:
        'overview',
    popularity: 1,
    posterPath: '/posterPath.jpg',
    releaseDate: '2002-05-01',
    title: 'title',
    video: false,
    voteAverage:1,
    voteCount: 1,
  );
  final tMovies = <Movie>[tMovie];

  blocTest<MovieRecommendationBloc, MovieRecommendationState>(
    'Should emit [loading, loaded] when data is loaded successfully',
    build: () {
      when(mockGetMovieRecomendations.execute(tId))
          .thenAnswer((_) async => Right(tMovies));

      return movieRecomendationBloc;
    },
    act: (bloc) => bloc.add(const FetchMovieRecommendation(tId)),
    expect: () => [MovieRecommendationLoading(), MovieRecommendationHasData(tMovies)],
  );

  blocTest<MovieRecommendationBloc, MovieRecommendationState>(
    'Should emit [loading, error] when data is failed to loaded ',
    build: () {
      when(mockGetMovieRecomendations.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return movieRecomendationBloc;
    },
    act: (bloc) => bloc.add(const FetchMovieRecommendation(tId)),
    expect: () =>
        [MovieRecommendationLoading(), MovieRecommendationError('Server Failure')],
  );
}
