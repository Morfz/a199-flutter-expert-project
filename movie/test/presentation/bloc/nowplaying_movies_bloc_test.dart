import 'package:bloc_test/bloc_test.dart';
import 'package:movie/presentation/bloc/movie_list_page/nowplaying_movies/nowplaying_movies_bloc.dart';
import 'package:core/core.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'nowplaying_movies_bloc_test.mocks.dart';

@GenerateMocks([
  GetNowPlayingMovies,
])
void main() {
  late NowPlayingMoviesBloc nowplayingMoviesBloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    nowplayingMoviesBloc = NowPlayingMoviesBloc(mockGetNowPlayingMovies);
  });

  final tMovieList = <Movie>[];

  group('Now Playing Movies BLoC Test', () {
    blocTest<NowPlayingMoviesBloc, NowPlayingMoviesState>(
        'Should emit [Loading, HasData] when data is loaded successfully',
        build: () {
          when(mockGetNowPlayingMovies.execute())
              .thenAnswer((_) async => Right(tMovieList));
          return nowplayingMoviesBloc;
        },
        act: (bloc) => bloc.add(FetchNowPlayingMovies()),
        expect: () =>
            [NowPlayingMoviesLoading(), NowPlayingMoviesHasData(tMovieList)],
        verify: (bloc) {
          verify(mockGetNowPlayingMovies.execute());
        });

    blocTest<NowPlayingMoviesBloc, NowPlayingMoviesState>(
        'Should emit [Loading, Error] when data is failed to loaded',
        build: () {
          when(mockGetNowPlayingMovies.execute())
              .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
          return nowplayingMoviesBloc;
        },
        act: (bloc) => bloc.add(FetchNowPlayingMovies()),
        expect: () =>
            [NowPlayingMoviesLoading(), const NowPlayingMoviesError('Server Failure')],
        verify: (bloc) {
          verify(mockGetNowPlayingMovies.execute());
        });
  });
}
