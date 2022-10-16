import 'package:bloc/bloc.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_popular_tv.dart';
import 'package:equatable/equatable.dart';

part 'popular_tv_event.dart';
part 'popular_tv_state.dart';

class PopularTvBloc extends Bloc<PopularTvEvent, PopularTvState> {
  final GetPopularTv getPopularTv;

  PopularTvBloc(this.getPopularTv) : super(PopularTvEmpty()) {
    on<FetchPopularTv>((event, emit) async {
      emit(PopularTvLoading());

      final result = await getPopularTv.execute();
      result.fold(
        (failure) {
          emit(PopularTvError(failure.message));
        },
        (data) {
          emit(PopularTvHasData(data));
        }
      );
    });
  }
}
