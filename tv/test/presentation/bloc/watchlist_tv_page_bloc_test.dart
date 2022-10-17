import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_watchlist_tv.dart';
import 'package:tv/presentation/bloc/tv_watchlist_page/watchlist_page_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_tv_page_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistTv])
void main() {
  late WatchlistTvPageBloc watchlistTvsBloc;
  late MockGetWatchlistTv mockGetWatchlistTvs;

  setUp(() {
    mockGetWatchlistTvs = MockGetWatchlistTv();
    watchlistTvsBloc = WatchlistTvPageBloc(mockGetWatchlistTvs);
  });

  blocTest<WatchlistTvPageBloc, WatchlistTvPageState>(
      'should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetWatchlistTvs.execute())
            .thenAnswer((realInvocation) async => Right([testWatchlistTv]));
        return watchlistTvsBloc;
      },
      act: (bloc) => bloc.add(FetchWatchlistTvPage()),
      expect: () => [
            WatchlistTvPageLoading(),
            WatchlistTvPageHasData([testWatchlistTv])
          ],
      verify: (bloc) {
        verify(mockGetWatchlistTvs.execute());
      });

  blocTest<WatchlistTvPageBloc, WatchlistTvPageState>(
    'should emit [Loading, Error] when data is gotten unsuccessfully',
    build: () {
      when(mockGetWatchlistTvs.execute()).thenAnswer(
          (realInvocation) async => const Left(DatabaseFailure("Can't get data")));
      return watchlistTvsBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistTvPage()),
    expect: () => [
      WatchlistTvPageLoading(),
      const WatchlistTvPageError("Can't get data")
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTvs.execute());
    },
  );


}
