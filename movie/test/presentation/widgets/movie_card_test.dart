import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/presentation/widgets/movie_card.dart';

void main() {
  final movie = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
    'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );

  group('Movie card Widget Test', () {
    Widget _makeTestableWidget() {
      return MaterialApp(home: Scaffold(body: MovieCard(movie)));
    }

    testWidgets('Testing if title movie shows', (WidgetTester tester) async {
      await tester.pumpWidget(_makeTestableWidget());
      expect(find.byType(Text), findsWidgets);
      expect(find.byType(InkWell), findsOneWidget);
      expect(find.byType(Card), findsOneWidget);
      expect(find.byType(ClipRRect), findsOneWidget);
      expect(find.byType(CachedNetworkImage), findsOneWidget);
    });

    // testWidgets('Testing if title movie loading', (WidgetTester tester) async {
    //   await tester.pumpWidget(_makeTestableWidget());
    //   expect(find.byType(ClipRRect), findsOneWidget);
    //   expect(find.byType(CachedNetworkImage), findsOneWidget);
    //   expect(find.byType(CircularProgressIndicator), findsOneWidget);
    // });

    // testWidgets('Testing if title movie error', (WidgetTester tester) async {
    //   await tester.pumpWidget(_makeTestableWidget());
    //   final iconFinder = find.byIcon(Icons.error);
    //   expect(iconFinder, findsOneWidget);
    // });
  });
}