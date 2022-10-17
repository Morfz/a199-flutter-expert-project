import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';
import 'package:movie/presentation/bloc/watchlist_movie_page/watchlist_movie_page_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_movie_page_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies])
void main() {
  late WatchlistMoviePageBloc watchlistBloc;
  late MockGetWatchlistMovies mockGetWatchlistMovies;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    watchlistBloc = WatchlistMoviePageBloc(mockGetWatchlistMovies);
  });

  blocTest<WatchlistMoviePageBloc, WatchListMoviePageState>(
      'should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((realInvocation) async => Right([testWatchlistMovie]));
        return watchlistBloc;
      },
      act: (bloc) => bloc.add(FetchWatchlistMoviePage()),
      expect: () => [
            WatchListMoviePageLoading(),
            WatchListMoviePageHasData([testWatchlistMovie])
          ],
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute());
      });

  blocTest<WatchlistMoviePageBloc, WatchListMoviePageState>(
    'should emit [Loading, Error] when data is gotten unsuccessfully',
    build: () {
      when(mockGetWatchlistMovies.execute()).thenAnswer(
          (realInvocation) async => const Left(DatabaseFailure("Can't get data")));
      return watchlistBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistMoviePage()),
    expect: () => [
      WatchListMoviePageLoading(),
      const WatchListMoviePageError("Can't get data")
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
    },
  );
}
