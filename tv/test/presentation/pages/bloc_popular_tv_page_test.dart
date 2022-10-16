import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/presentation/bloc/tv_list_page/popular_tv/popular_tv_bloc.dart';
import 'package:tv/presentation/pages/popular_tv_page.dart';

class MockPopularTvBloc extends MockBloc<PopularTvEvent, PopularTvState>
    implements PopularTvBloc {}

class FakePopularTvEvent extends Fake implements PopularTvEvent {}

class FakePopularTvState extends Fake implements PopularTvState {}

void main() {
  late MockPopularTvBloc mockPopularTvBloc;

  setUpAll(() {
    registerFallbackValue(FakePopularTvEvent());
    registerFallbackValue(FakePopularTvState());
  });

  setUp(() {
    mockPopularTvBloc = MockPopularTvBloc();
  });

  tearDown(() {
    mockPopularTvBloc.close();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularTvBloc>(
      create: (_) => mockPopularTvBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockPopularTvBloc.add(FetchPopularTv()))
        .thenAnswer((invocation) {});
    when(() => mockPopularTvBloc.state)
        .thenAnswer((invocation) => PopularTvLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(PopularTvPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockPopularTvBloc.add(FetchPopularTv()))
        .thenAnswer((invocation) {});
    when(() => mockPopularTvBloc.state)
        .thenAnswer((invocation) => PopularTvHasData(<Tv>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(PopularTvPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Empty',
          (WidgetTester tester) async {
        when(() => mockPopularTvBloc.state).thenReturn(PopularTvEmpty());

        final textFinder = find.text('Empty Popular Tv');

        await tester.pumpWidget(_makeTestableWidget(PopularTvPage()));

        expect(textFinder, findsOneWidget);
      });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockPopularTvBloc.add(FetchPopularTv()))
        .thenAnswer((invocation) {});
    when(() => mockPopularTvBloc.state)
        .thenAnswer((invocation) => PopularTvError('Error Message'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(PopularTvPage()));

    expect(textFinder, findsOneWidget);
  });
}
