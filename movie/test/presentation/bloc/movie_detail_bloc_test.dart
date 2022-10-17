import 'package:bloc_test/bloc_test.dart';
import 'package:movie/presentation/bloc/movie_detail_page/movie_detail/movie_detail_bloc.dart';
import 'package:core/core.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
])
void main() {
  late MovieDetailBloc getMovieDetailBloc;
  late MockGetMovieDetail mockGetMovieDetail;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    getMovieDetailBloc = MovieDetailBloc(getMovieDetail: mockGetMovieDetail);
  });

  const tId = 1;

  const tMovieDetail = MovieDetail(
    adult: false,
    backdropPath: 'backdropPath',
    genres: [],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    runtime: 1,
    title: 'title',
    voteAverage: 1,
    voteCount: 1,
  );

  group('Movie Detail BLoC Test', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
        'Should emit [Loading, HasData] when data is loaded successfully',
        build: () {
          when(mockGetMovieDetail.execute(tId))
              .thenAnswer((_) async => const Right(tMovieDetail));
          return getMovieDetailBloc;
        },
        act: (bloc) => bloc.add(const FetchMovieDetail(tId)),
        expect: () {
          return [MovieDetailLoading(), const MovieDetailHasData(tMovieDetail)];
        });

    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit [Loading, Error] when data is failed loaded',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
        return getMovieDetailBloc;
      },
      act: (bloc) => bloc.add(const FetchMovieDetail(tId)),
      expect: () {
        return [MovieDetailLoading(), const MovieDetailError('Server Failure')];
      },

    );
  });
}
