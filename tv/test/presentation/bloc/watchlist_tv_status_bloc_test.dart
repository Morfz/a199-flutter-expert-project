import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_watchlist_tv_status.dart';
import 'package:tv/domain/usecases/remove_watchlist_tv.dart';
import 'package:tv/domain/usecases/save_watchlist_tv.dart';
import 'package:tv/presentation/bloc/tv_detail_page/tv_watchlist_status/tv_watchlist_status_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_tv_status_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchListTvStatus,
  SaveWatchlistTv,
  RemoveWatchlistTv
])
void main() {
  late WatchlistTvStatusBloc watchlistStatusBloc;
  late MockGetWatchListTvStatus mockGetWatchlistStatus;
  late MockSaveWatchlistTv mockSaveWatchlist;
  late MockRemoveWatchlistTv mockRemoveWatchlist;

  setUp(() {
    mockGetWatchlistStatus = MockGetWatchListTvStatus();
    mockSaveWatchlist = MockSaveWatchlistTv();
    mockRemoveWatchlist = MockRemoveWatchlistTv();
    watchlistStatusBloc = WatchlistTvStatusBloc(
        getWatchlistTvStatus: mockGetWatchlistStatus,
        saveTvWatchlist: mockSaveWatchlist,
        removeTvWatchlist: mockRemoveWatchlist);
  });

  const tId = 1;

  group('Watchlist Status', () {
    blocTest<WatchlistTvStatusBloc, WatchlistTvStatusState>(
        'should get the watchlist status',
        build: () {
          when(mockGetWatchlistStatus.execute(1))
              .thenAnswer((realInvocation) async => false);
          return watchlistStatusBloc;
        },
        act: (bloc) => bloc.add(const LoadWatchlistTvStatus(1)),
        expect: () => [
          const WatchlistTvStatusState(false, '')
        ],
        verify: (bloc) {
          verify(mockGetWatchlistStatus.execute(tId));
        });

    blocTest<WatchlistTvStatusBloc, WatchlistTvStatusState>(
        'should execute save watchlist when function called', build: () {
      when(mockSaveWatchlist.execute(testTvDetail))
          .thenAnswer((realInvocation) async => const Right('success'));
      when(mockGetWatchlistStatus.execute(tId))
          .thenAnswer((realInvocation) async => true);
      return watchlistStatusBloc;
    }, act: (bloc) {
      bloc.add(const AddToWatchlistTvs(testTvDetail));
      bloc.add(const LoadWatchlistTvStatus(tId));
    }, verify: (bloc) {
      verify(mockSaveWatchlist.execute(testTvDetail));
      verify(mockGetWatchlistStatus.execute(tId));
    });

    blocTest<WatchlistTvStatusBloc, WatchlistTvStatusState>(
      'should execute save watchlist when function called successfully',
      build: () {
        when(mockSaveWatchlist.execute(testTvDetail))
            .thenAnswer((realInvocation) async => const Right('Added to Watchlist'));
        when(mockGetWatchlistStatus.execute(tId))
            .thenAnswer((realInvocation) async => true);
        return watchlistStatusBloc;
      },
      act: (bloc) {
        bloc.add(const AddToWatchlistTvs(testTvDetail));
      },
      expect: () => [
        const WatchlistTvStatusState(true, 'Added to Watchlist'),
      ],
    );

    blocTest<WatchlistTvStatusBloc, WatchlistTvStatusState>(
      'should execute remove watchlist when function called successfully',
      build: () {
        when(mockRemoveWatchlist.execute(testTvDetail)).thenAnswer(
                (realInvocation) async => const Right('Removed from Watchlist'));
        when(mockGetWatchlistStatus.execute(tId))
            .thenAnswer((realInvocation) async => false);
        return watchlistStatusBloc;
      },
      act: (bloc) {
        bloc.add(const RemoveFromWatchlistTvs(testTvDetail));
      },
      expect: () => [
        const WatchlistTvStatusState(false, 'Removed from Watchlist'),
      ],
    );

    blocTest<WatchlistTvStatusBloc, WatchlistTvStatusState>(
      'should raise error message when add to watchlist is failed',
      build: () {
        when(mockSaveWatchlist.execute(testTvDetail)).thenAnswer(
                (realInvocation) async =>
            const Left(DatabaseFailure('failed add to watchlist')));
        when(mockGetWatchlistStatus.execute(tId))
            .thenAnswer((realInvocation) async => false);
        return watchlistStatusBloc;
      },
      act: (bloc) {
        bloc.add(const AddToWatchlistTvs(testTvDetail));
      },
      expect: () => [
        const WatchlistTvStatusState(false, 'failed add to watchlist'),
      ],
    );
  });
}
