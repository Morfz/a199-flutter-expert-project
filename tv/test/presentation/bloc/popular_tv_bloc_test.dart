import 'package:bloc_test/bloc_test.dart';
import 'package:tv/presentation/bloc/tv_list_page/popular_tv/popular_tv_bloc.dart';
import 'package:core/core.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_popular_tv.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_tv_bloc_test.mocks.dart';

@GenerateMocks([
  GetPopularTv,
])
void main() {
  late PopularTvBloc popularTvBloc;
  late MockGetPopularTv mockGetPopularTv;

  setUp(() {
    mockGetPopularTv = MockGetPopularTv();
    popularTvBloc = PopularTvBloc(mockGetPopularTv);
  });

  final tTvList = <Tv>[];

  group('Now Playing Movies BLoC Test', () {
    blocTest<PopularTvBloc, PopularTvState>(
        'Should emit [loading, loaded] when data is loaded successfully',
        build: () {
          when(mockGetPopularTv.execute())
              .thenAnswer((_) async => Right(tTvList));
          return popularTvBloc;
        },
        act: (bloc) => bloc.add(FetchPopularTv()),
        expect: () => [PopularTvLoading(), PopularTvHasData(tTvList)],
        verify: (bloc) {
          verify(mockGetPopularTv.execute());
        });

    blocTest<PopularTvBloc, PopularTvState>(
        'Should emit [loading, error] when data is failed to loaded',
        build: () {
          when(mockGetPopularTv.execute())
              .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
          return popularTvBloc;
        },
        act: (bloc) => bloc.add(FetchPopularTv()),
        expect: () => [PopularTvLoading(), const PopularTvError('Server Failure')],
        verify: (bloc) {
          verify(mockGetPopularTv.execute());
        });
  });
}
