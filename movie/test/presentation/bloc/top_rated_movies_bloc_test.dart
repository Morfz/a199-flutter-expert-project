import 'package:bloc_test/bloc_test.dart';
import 'package:movie/presentation/bloc/movie_list_page/top_rated_movies/top_rated_movies_bloc.dart';
import 'package:core/core.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'top_rated_movies_bloc_test.mocks.dart';


@GenerateMocks([
  GetTopRatedMovies,
])
void main() {
  late TopRatedMoviesBloc topRatedMoviesBloc;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    topRatedMoviesBloc = TopRatedMoviesBloc(mockGetTopRatedMovies);
  });

  final tMovieList = <Movie>[];

  group('Now Playing Movies BLoC Test', () {
    blocTest<TopRatedMoviesBloc, TopRatedMoviesState>(
        'Should emit [loading, loaded] when data is loaded successfully',
        build: () {
          when(mockGetTopRatedMovies.execute())
              .thenAnswer((_) async => Right(tMovieList));
          return topRatedMoviesBloc;
        },
        act: (bloc) => bloc.add(FetchTopRatedMovies()),
        expect: () =>
            [TopRatedMoviesLoading(), TopRatedMoviesHasData(tMovieList)],
        verify: (bloc) {
          verify(mockGetTopRatedMovies.execute());
        });

    blocTest<TopRatedMoviesBloc, TopRatedMoviesState>(
        'Should emit [loading, error] when data is failed to loaded',
        build: () {
          when(mockGetTopRatedMovies.execute())
              .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
          return topRatedMoviesBloc;
        },
        act: (bloc) => bloc.add(FetchTopRatedMovies()),
        expect: () =>
            [TopRatedMoviesLoading(), const TopRatedMoviesError('Server Failure')],
        verify: (bloc) {
          verify(mockGetTopRatedMovies.execute());
        });
  });
}
