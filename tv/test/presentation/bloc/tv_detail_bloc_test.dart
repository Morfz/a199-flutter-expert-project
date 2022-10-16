import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/domain/usecases/get_tv_detail.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/presentation/bloc/tv_detail_page/tv_detail/tv_detail_bloc.dart';

import 'tv_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvDetail,
])
void main() {
  late TvDetailBloc getTvDetailBloc;
  late MockGetTvDetail mockGetTvDetail;

  setUp(() {
    mockGetTvDetail = MockGetTvDetail();
    getTvDetailBloc = TvDetailBloc(mockGetTvDetail);
  });

  const tId = 1;

  const tMovieDetail = TvDetail(
    backdropPath: 'backdropPath',
    genres: [],
    id: 1,
    originalName: 'originalName',
    overview: 'overview',
    posterPath: 'posterPath',
    firstAirDate: 'firstAirDate',
    name: 'name',
    numberOfEpisodes: 1,
    numberOfSeasons: 1,
    voteAverage: 1,
    voteCount: 1,
  );

  group('Movie Detail BLoC Test', () {
    blocTest<TvDetailBloc, TvDetailState>(
        'Should emit [loading, loaded] when data is loaded successfully',
        build: () {
          when(mockGetTvDetail.execute(tId))
              .thenAnswer((_) async => const Right(tMovieDetail));
          return getTvDetailBloc;
        },
        act: (bloc) => bloc.add(OnFetchTvDetail(tId)),
        expect: () {
          return [TvDetailLoading(), TvDetailHasData(tMovieDetail)];
        });

    blocTest<TvDetailBloc, TvDetailState>(
      'Should emit [loading, error] when data is failed to loaded',
      build: () {
        when(mockGetTvDetail.execute(tId))
            .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
        return getTvDetailBloc;
      },
      act: (bloc) => bloc.add(OnFetchTvDetail(tId)),
      expect: () {
        return [TvDetailLoading(), TvDetailError('Server Failure')];
      },
    );
  });
}
