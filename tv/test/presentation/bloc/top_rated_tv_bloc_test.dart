import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_top_rated_tv.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/presentation/bloc/tv_list_page/top_rated_tv/top_rated_tv_bloc.dart';

import 'top_rated_tv_bloc_test.mocks.dart';



@GenerateMocks([
  GetTopRatedTv,
])
void main() {
  late TopRatedTvBloc topRatedTvBloc;
  late MockGetTopRatedTv mockGetTopRatedTv;

  setUp(() {
    mockGetTopRatedTv = MockGetTopRatedTv();
    topRatedTvBloc = TopRatedTvBloc(mockGetTopRatedTv);
  });

  final tTvList = <Tv>[];

  group('Now Playing Movies BLoC Test', () {
    blocTest<TopRatedTvBloc, TopRatedTvState>(
        'Should emit [loading, loaded] when data is loaded successfully',
        build: () {
          when(mockGetTopRatedTv.execute())
              .thenAnswer((_) async => Right(tTvList));
          return topRatedTvBloc;
        },
        act: (bloc) => bloc.add(FetchTopRatedTv()),
        expect: () => [TopRatedTvLoading(), TopRatedTvHasData(tTvList)],
        verify: (bloc) {
          verify(mockGetTopRatedTv.execute());
        });

    blocTest<TopRatedTvBloc, TopRatedTvState>(
        'Should emit [loading, error] when data is failed to loaded',
        build: () {
          when(mockGetTopRatedTv.execute())
              .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
          return topRatedTvBloc;
        },
        act: (bloc) => bloc.add(FetchTopRatedTv()),
        expect: () => [TopRatedTvLoading(), const TopRatedTvError('Server Failure')],
        verify: (bloc) {
          verify(mockGetTopRatedTv.execute());
        });
  });
}
