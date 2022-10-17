import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_watchlist_movie_status.dart';
import 'package:movie/domain/usecases/remove_watchlist_movie.dart';
import 'package:movie/domain/usecases/save_watchlist_movie.dart';
import 'package:movie/presentation/bloc/movie_detail_page/watchlist_status/watchlist_movie_status_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_movie_status_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchListMovieStatus,
  SaveWatchlistMovie,
  RemoveWatchlistMovie
])
void main() {
  late WatchlistMovieStatusBloc watchlistStatusBloc;
  late MockGetWatchListMovieStatus mockGetWatchlistStatus;
  late MockSaveWatchlistMovie mockSaveWatchlist;
  late MockRemoveWatchlistMovie mockRemoveWatchlist;

  setUp(() {
    mockGetWatchlistStatus = MockGetWatchListMovieStatus();
    mockSaveWatchlist = MockSaveWatchlistMovie();
    mockRemoveWatchlist = MockRemoveWatchlistMovie();
    watchlistStatusBloc = WatchlistMovieStatusBloc(
        getWatchlistStatus: mockGetWatchlistStatus,
        saveWatchlist: mockSaveWatchlist,
        removeWatchlist: mockRemoveWatchlist);
  });

  const tId = 1;

  group('Watchlist Status', () {
    blocTest<WatchlistMovieStatusBloc, WatchListMovieStatusState>(
        'should get the watchlist status',
        build: () {
          when(mockGetWatchlistStatus.execute(1))
              .thenAnswer((realInvocation) async => false);
          return watchlistStatusBloc;
        },
        act: (bloc) => bloc.add(const LoadWatchListMovieStatus(1)),
        expect: () => [
          const WatchListMovieStatusState(false, '')
        ],
        verify: (bloc) {
          verify(mockGetWatchlistStatus.execute(tId));
        });

    blocTest<WatchlistMovieStatusBloc, WatchListMovieStatusState>(
        'should execute save watchlist when function called', build: () {
      when(mockSaveWatchlist.execute(testMovieDetail))
          .thenAnswer((realInvocation) async => const Right('success'));
      when(mockGetWatchlistStatus.execute(tId))
          .thenAnswer((realInvocation) async => true);
      return watchlistStatusBloc;
    }, act: (bloc) {
      bloc.add(const AddToWatchListMovie(testMovieDetail));
      bloc.add(LoadWatchListMovieStatus(tId));
    }, verify: (bloc) {
      verify(mockSaveWatchlist.execute(testMovieDetail));
      verify(mockGetWatchlistStatus.execute(tId));
    });

    blocTest<WatchlistMovieStatusBloc, WatchListMovieStatusState>(
      'should execute save watchlist when function called successfully',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((realInvocation) async => const Right('Added to Watchlist'));
        when(mockGetWatchlistStatus.execute(tId))
            .thenAnswer((realInvocation) async => true);
        return watchlistStatusBloc;
      },
      act: (bloc) {
        bloc.add(const AddToWatchListMovie(testMovieDetail));
      },
      expect: () => [
        const WatchListMovieStatusState(true, 'Added to Watchlist'),
      ],
    );

    blocTest<WatchlistMovieStatusBloc, WatchListMovieStatusState>(
      'should execute remove watchlist when function called successfully',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail)).thenAnswer(
                (realInvocation) async => const Right('Removed from Watchlist'));
        when(mockGetWatchlistStatus.execute(tId))
            .thenAnswer((realInvocation) async => false);
        return watchlistStatusBloc;
      },
      act: (bloc) {
        bloc.add(const RemoveFromWatchListMovie(testMovieDetail));
      },
      expect: () => [
        const WatchListMovieStatusState(false, 'Removed from Watchlist'),
      ],
    );

    blocTest<WatchlistMovieStatusBloc, WatchListMovieStatusState>(
      'should raise error message when add to watchlist is failed',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail)).thenAnswer(
                (realInvocation) async =>
                const Left(DatabaseFailure('failed add to watchlist')));
        when(mockGetWatchlistStatus.execute(tId))
            .thenAnswer((realInvocation) async => false);
        return watchlistStatusBloc;
      },
      act: (bloc) {
        bloc.add(const AddToWatchListMovie(testMovieDetail));
      },
      expect: () => [
        const WatchListMovieStatusState(false, 'failed add to watchlist'),
      ],
    );
  });
}
