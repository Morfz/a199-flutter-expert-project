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
  late NowplayingMoviesBloc nowplayingMoviesBloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    nowplayingMoviesBloc = NowplayingMoviesBloc(mockGetNowPlayingMovies);
  });

  final tMovieList = <Movie>[];

  group('Now Playing Movies BLoC Test', () {
    blocTest<NowplayingMoviesBloc, NowplayingMoviesState>(
        'Should emit [loading, loaded] when data is loaded successfully',
        build: () {
          when(mockGetNowPlayingMovies.execute())
              .thenAnswer((_) async => Right(tMovieList));
          return nowplayingMoviesBloc;
        },
        act: (bloc) => bloc.add(FetchNowPlayingMovies()),
        expect: () =>
            [NowplayingMoviesLoading(), NowPlayingMoviesHasData(tMovieList)],
        verify: (bloc) {
          verify(mockGetNowPlayingMovies.execute());
        });

    blocTest<NowplayingMoviesBloc, NowplayingMoviesState>(
        'Should emit [loading, error] when data is failed to loaded',
        build: () {
          when(mockGetNowPlayingMovies.execute())
              .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
          return nowplayingMoviesBloc;
        },
        act: (bloc) => bloc.add(FetchNowPlayingMovies()),
        expect: () =>
            [NowplayingMoviesLoading(), const NowplayingMoviesError('Server Failure')],
        verify: (bloc) {
          verify(mockGetNowPlayingMovies.execute());
        });
  });
}
