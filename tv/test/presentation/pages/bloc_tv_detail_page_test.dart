import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/presentation/bloc/tv_detail_page/tv_detail/tv_detail_bloc.dart';
import 'package:tv/presentation/bloc/tv_detail_page/tv_recommendations/tv_recommendations_bloc.dart';
import 'package:tv/presentation/bloc/tv_detail_page/tv_watchlist_status/tv_watchlist_status_bloc.dart';
import 'package:tv/presentation/pages/tv_detail_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockTvDetailBloc extends MockBloc<TvDetailEvent, TvDetailState>
    implements TvDetailBloc {}

class MockTvRecommendationsBloc
    extends MockBloc<TvRecommendationsEvent, TvRecommendationsState>
    implements TvRecommendationsBloc {}

class MockTvWatchlistStatusBloc
    extends MockBloc<WatchlistTvStatusEvent, WatchlistTvStatusState>
    implements WatchlistTvStatusBloc {}

//  Mock event
class FakeTvDetailEvent extends Fake implements TvDetailEvent {}

class FakeTvRecommendationsEvent extends Fake
    implements TvRecommendationsEvent {}

class FakeTvWatchlistStatusEvent extends Fake
    implements WatchlistTvStatusEvent {}

// Mock State
class FakeTvDetailState extends Fake implements TvDetailState {}

class FakeTvRecommendationsState extends Fake
    implements TvRecommendationsState {}

class FakeTvWatchlistStatusState extends Fake
    implements WatchlistTvStatusState {}

void main() {
  late MockTvDetailBloc mockTvDetailBloc;
  late MockTvRecommendationsBloc mockTvRecommendationsBloc;
  late MockTvWatchlistStatusBloc mockTvWatchlistStatusBloc;

  setUpAll(() {
    registerFallbackValue(FakeTvDetailEvent());
    registerFallbackValue(FakeTvDetailState());
    registerFallbackValue(FakeTvRecommendationsEvent());
    registerFallbackValue(FakeTvRecommendationsState());
    registerFallbackValue(FakeTvWatchlistStatusEvent());
    registerFallbackValue(FakeTvWatchlistStatusState());
  });

  setUp(() {
    mockTvDetailBloc = MockTvDetailBloc();
    mockTvRecommendationsBloc = MockTvRecommendationsBloc();
    mockTvWatchlistStatusBloc = MockTvWatchlistStatusBloc();
  });

  tearDown(() {
    mockTvDetailBloc.close();
    mockTvRecommendationsBloc.close();
    mockTvWatchlistStatusBloc.close();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<TvDetailBloc>(create: (_) => mockTvDetailBloc),
          BlocProvider<TvRecommendationsBloc>(
              create: (_) => mockTvRecommendationsBloc),
          BlocProvider<WatchlistTvStatusBloc>(
              create: (_) => mockTvWatchlistStatusBloc),
        ],
        child: MaterialApp(
          home: body,
        ));
  }

  final tId = 1399;

  final tTv = Tv(
    backdropPath: '/gFZriCkpJYsApPZEF3jhxL4yLzG.jpg',
    genreIds: const [80, 18],
    id: 71446,
    originalName: 'Money Heist',
    overview:
    'To carry out the biggest heist in history, a mysterious man called The Professor recruits a band of eight robbers who have a single characteristic: none of them has anything to lose. Five months of seclusion - memorizing every step, every detail, every probability - culminate in eleven days locked up in the National Coinage and Stamp Factory of Spain, surrounded by police forces and with dozens of hostages in their power, to find out whether their suicide wager will lead to everything or nothing.',
    popularity: 906.295,
    posterPath: '/reEMJA1uzscCbkpeRJeTT2bjqUp.jpg',
    firstAirDate: '2017-05-02',
    name: 'Money Heist',
    voteAverage: 8.3,
    voteCount: 14669,
  );
  final tTvs = <Tv>[tTv];



  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockTvDetailBloc.add(FetchTvDetail(tId)))
        .thenAnswer((invocation) {});
    when(() => mockTvDetailBloc.state)
        .thenAnswer((invocation) => const TvDetailHasData(testTvDetail));
    when(() =>
            mockTvRecommendationsBloc.add(FetchTvRecommendations(tId)))
        .thenAnswer((invocation) {});
    when(() => mockTvRecommendationsBloc.state)
        .thenAnswer((invocation) => TvRecommendationsHasData(tTvs));
    when(() => mockTvWatchlistStatusBloc.add(LoadWatchlistTvStatus(tId)))
        .thenAnswer((invocation) {});
    when(() => mockTvWatchlistStatusBloc.state)
        .thenAnswer((invocation) => const WatchlistTvStatusState(false, ''));

    final watchlistButtonIcon = find.byIcon(Icons.add);
    await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));
    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(() => mockTvDetailBloc.add(FetchTvDetail(tId)))
        .thenAnswer((invocation) {});
    when(() => mockTvDetailBloc.state)
        .thenAnswer((invocation) => const TvDetailHasData(testTvDetail));
    when(() =>
            mockTvRecommendationsBloc.add(FetchTvRecommendations(tId)))
        .thenAnswer((invocation) {});
    when(() => mockTvRecommendationsBloc.state)
        .thenAnswer((invocation) => TvRecommendationsHasData(tTvs));
    when(() => mockTvWatchlistStatusBloc.add(LoadWatchlistTvStatus(tId)))
        .thenAnswer((invocation) {});
    when(() => mockTvWatchlistStatusBloc.add(const AddToWatchlistTvs(testTvDetail)))
        .thenAnswer((invocation) {});
    when(() => mockTvWatchlistStatusBloc.state).thenAnswer(
        (invocation) => const WatchlistTvStatusState(true, 'Added to Watchlist'));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

   testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(() => mockTvDetailBloc.add(FetchTvDetail(tId)))
        .thenAnswer((invocation) {});
    when(() => mockTvDetailBloc.state)
        .thenAnswer((invocation) => const TvDetailHasData(testTvDetail));
    when(() =>
            mockTvRecommendationsBloc.add(FetchTvRecommendations(tId)))
        .thenAnswer((invocation) {});
    when(() => mockTvRecommendationsBloc.state)
        .thenAnswer((invocation) => TvRecommendationsHasData(tTvs));
    when(() => mockTvWatchlistStatusBloc.add(LoadWatchlistTvStatus(tId)))
        .thenAnswer((invocation) {});
    when(() => mockTvWatchlistStatusBloc.state)
        .thenAnswer((invocation) => const WatchlistTvStatusState(false, ''));

    final watchlistButton = find.byType(ElevatedButton);
    final expectedStates = [
      const WatchlistTvStatusState(false, ''),
      const WatchlistTvStatusState(true, 'Added to Watchlist')
    ];

    whenListen(mockTvWatchlistStatusBloc, Stream.fromIterable(expectedStates));
    await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: tId)));

    expect(find.byIcon(Icons.add), findsOneWidget);
    await tester.tap(watchlistButton);

    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(() => mockTvDetailBloc.add(FetchTvDetail(tId)))
        .thenAnswer((invocation) {});
    when(() => mockTvDetailBloc.state)
        .thenAnswer((invocation) => const TvDetailHasData(testTvDetail));
    when(() =>
            mockTvRecommendationsBloc.add(FetchTvRecommendations(tId)))
        .thenAnswer((invocation) {});
    when(() => mockTvRecommendationsBloc.state)
        .thenAnswer((invocation) => TvRecommendationsHasData(tTvs));
    when(() => mockTvWatchlistStatusBloc.add(LoadWatchlistTvStatus(tId)))
        .thenAnswer((invocation) {});
    when(() => mockTvWatchlistStatusBloc.state)
        .thenAnswer((invocation) => const WatchlistTvStatusState(false, ''));

    final watchlistButton = find.byType(ElevatedButton);
    whenListen(
        mockTvWatchlistStatusBloc,
        Stream.fromIterable([
          const WatchlistTvStatusState(false, ''),
          const WatchlistTvStatusState(false, 'Failed')
        ]));
    await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);
    expect(find.byType(AlertDialog), findsNothing);
    expect(find.text('Failed'), findsNothing);
    await tester.tap(watchlistButton, warnIfMissed: false);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
}
