import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_tv_recommendation.dart';
import 'package:core/core.dart';
import 'package:tv/presentation/bloc/tv_detail_page/tv_recommendations/tv_recommendations_bloc.dart';

import 'recommendation_bloc_test.mocks.dart';

@GenerateMocks([GetTvRecommendations])
void main() {
  late TvRecommendationsBloc tvRecomendationBloc;
  late MockGetTvRecommendations mockGetTvRecomendations;

  setUp(() {
    mockGetTvRecomendations = MockGetTvRecommendations();
    tvRecomendationBloc = TvRecommendationsBloc(mockGetTvRecomendations);
  });

  const tId = 1;

  final tTv = Tv(
    backdropPath: 'backdropPath',
    id: 1,
    originalName: 'originalName',
    overview: 'overview',
    posterPath: 'posterPath',
    firstAirDate: 'firstAirDate',
    name: 'name',
    voteAverage: 1,
    voteCount: 1,
    genreIds: const [],
    popularity: null,
  );

  final tTvs = <Tv>[tTv];

  blocTest<TvRecommendationsBloc, TvRecommendationsState>(
    'Should emit [loading, loaded] when data is loaded successfully',
    build: () {
      when(mockGetTvRecomendations.execute(tId))
          .thenAnswer((_) async => Right(tTvs));

      return tvRecomendationBloc;
    },
    act: (bloc) => bloc.add(OnFetchTvRecommendations(tId)),
    expect: () => [TvRecommendationsLoading(), TvRecommendationsHasData(tTvs)],
  );

  blocTest<TvRecommendationsBloc, TvRecommendationsState>(
    'Should emit [loading, error] when data is failed to load',
    build: () {
      when(mockGetTvRecomendations.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvRecomendationBloc;
    },
    act: (bloc) => bloc.add(OnFetchTvRecommendations(tId)),
    expect: () =>
        [TvRecommendationsLoading(), TvRecommendationsError('Server Failure')],
  );
}
