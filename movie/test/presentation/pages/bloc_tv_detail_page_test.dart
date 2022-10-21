import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/presentation/bloc/movie_detail_page/movie_detail/movie_detail_bloc.dart';
import 'package:movie/presentation/bloc/movie_detail_page/movie_recommendation/movie_recommendation_bloc.dart';
import 'package:movie/presentation/bloc/movie_detail_page/watchlist_status/watchlist_movie_status_bloc.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

// Mock Bloc
class MockMovieDetailBloc extends MockBloc<MovieDetailEvent, MovieDetailState>
    implements MovieDetailBloc {}

class MockMovieRecommendationBloc
    extends MockBloc<MovieRecommendationEvent, MovieRecommendationState>
    implements MovieRecommendationBloc {}

class MockWatchlistMovieStatusBloc
    extends MockBloc<WatchListMovieStatusEvent, WatchListMovieStatusState>
    implements WatchlistMovieStatusBloc {}

// Mock event
class FakeMovieDetailEvent extends Fake implements MovieDetailEvent {}

class FakeMovieRecommendationEvent extends Fake
    implements MovieRecommendationEvent {}

class FakeWatchListMovieStatusEvent extends Fake implements WatchListMovieStatusEvent {}

// Mock state
class FakeMovieDetailState extends Fake implements MovieDetailState {}

class FakeMovieRecommendationState extends Fake
    implements MovieRecommendationState {}

class FakeWatchListMovieStatusState extends Fake implements WatchListMovieStatusState {}

void main() {
  late MockMovieDetailBloc mockMovieDetailBloc;
  late MockMovieRecommendationBloc mockMovieRecommendationBloc;
  late MockWatchlistMovieStatusBloc mockWatchlistMovieStatusBloc;

  setUpAll(() {
    registerFallbackValue(FakeMovieDetailEvent());
    registerFallbackValue(FakeMovieDetailState());
    registerFallbackValue(FakeMovieRecommendationEvent());
    registerFallbackValue(FakeMovieRecommendationState());
    registerFallbackValue(FakeWatchListMovieStatusEvent());
    registerFallbackValue(FakeWatchListMovieStatusState());
  });

  setUp(() {
    mockMovieDetailBloc = MockMovieDetailBloc();
    mockMovieRecommendationBloc = MockMovieRecommendationBloc();
    mockWatchlistMovieStatusBloc = MockWatchlistMovieStatusBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<MovieDetailBloc>(create: (_) => mockMovieDetailBloc),
          BlocProvider<MovieRecommendationBloc>(
              create: (_) => mockMovieRecommendationBloc),
          BlocProvider<WatchlistMovieStatusBloc>(
              create: (_) => mockWatchlistMovieStatusBloc),
        ],
        child: MaterialApp(
          home: body,
        ));
  }

  tearDown(() {
    mockMovieDetailBloc.close();
    mockMovieRecommendationBloc.close();
    mockWatchlistMovieStatusBloc.close();
  });

  final tId = 1;

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );
  final tMovies = <Movie>[tMovie];

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.add(FetchMovieDetail(tId)))
        .thenAnswer((invocation) {});
    when(() => mockMovieDetailBloc.state)
        .thenAnswer((invocation) => MovieDetailHasData(testMovieDetail));
    when(() =>
            mockMovieRecommendationBloc.add(FetchMovieRecommendation(tId)))
        .thenAnswer((invocation) {});
    when(() => mockMovieRecommendationBloc.state)
        .thenAnswer((invocation) => MovieRecommendationHasData(tMovies));
    when(() => mockWatchlistMovieStatusBloc.add(LoadWatchListMovieStatus(tId)))
        .thenAnswer((invocation) {});
    when(() => mockWatchlistMovieStatusBloc.state)
        .thenAnswer((invocation) => WatchListMovieStatusState(false, ''));

    final watchlistButtonIcon = find.byIcon(Icons.add);
    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));
    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.add(FetchMovieDetail(tId)))
        .thenAnswer((invocation) {});
    when(() => mockMovieDetailBloc.state)
        .thenAnswer((invocation) => MovieDetailHasData(testMovieDetail));
    when(() =>
            mockMovieRecommendationBloc.add(FetchMovieRecommendation(tId)))
        .thenAnswer((invocation) {});
    when(() => mockMovieRecommendationBloc.state)
        .thenAnswer((invocation) => MovieRecommendationHasData(tMovies));
    when(() => mockWatchlistMovieStatusBloc.add(LoadWatchListMovieStatus(tId)))
        .thenAnswer((invocation) {});
    when(() => mockWatchlistMovieStatusBloc.add(AddToWatchListMovie(testMovieDetail)))
        .thenAnswer((invocation) {});
    when(() => mockWatchlistMovieStatusBloc.state).thenAnswer(
        (invocation) => WatchListMovieStatusState(true, 'Added to Watchlist'));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.add(FetchMovieDetail(tId)))
        .thenAnswer((invocation) {});
    when(() => mockMovieDetailBloc.state)
        .thenAnswer((invocation) => MovieDetailHasData(testMovieDetail));
    when(() =>
            mockMovieRecommendationBloc.add(FetchMovieRecommendation(tId)))
        .thenAnswer((invocation) {});
    when(() => mockMovieRecommendationBloc.state)
        .thenAnswer((invocation) => MovieRecommendationHasData(tMovies));
    when(() => mockWatchlistMovieStatusBloc.add(LoadWatchListMovieStatus(tId)))
        .thenAnswer((invocation) {});
    when(() => mockWatchlistMovieStatusBloc.state)
        .thenAnswer((invocation) => WatchListMovieStatusState(false, ''));

    final watchlistButton = find.byType(ElevatedButton);
    final expectedStates = [
      WatchListMovieStatusState(false, ''),
      WatchListMovieStatusState(true, 'Added to Watchlist')
    ];

    whenListen(mockWatchlistMovieStatusBloc, Stream.fromIterable(expectedStates));
    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: tId)));

    expect(find.byIcon(Icons.add), findsOneWidget);
    await tester.tap(watchlistButton);

    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.add(FetchMovieDetail(tId)))
        .thenAnswer((invocation) {});
    when(() => mockMovieDetailBloc.state)
        .thenAnswer((invocation) => MovieDetailHasData(testMovieDetail));
    when(() =>
            mockMovieRecommendationBloc.add(FetchMovieRecommendation(tId)))
        .thenAnswer((invocation) {});
    when(() => mockMovieRecommendationBloc.state)
        .thenAnswer((invocation) => MovieRecommendationHasData(tMovies));
    when(() => mockWatchlistMovieStatusBloc.add(LoadWatchListMovieStatus(tId)))
        .thenAnswer((invocation) {});
    when(() => mockWatchlistMovieStatusBloc.state)
        .thenAnswer((invocation) => WatchListMovieStatusState(false, ''));

    final watchlistButton = find.byType(ElevatedButton);
    whenListen(
        mockWatchlistMovieStatusBloc,
        Stream.fromIterable([
          WatchListMovieStatusState(false, ''),
          WatchListMovieStatusState(false, 'Failed')
        ]));
    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);
    expect(find.byType(AlertDialog), findsNothing);
    expect(find.text('Failed'), findsNothing);
    await tester.tap(watchlistButton, warnIfMissed: false);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
}
