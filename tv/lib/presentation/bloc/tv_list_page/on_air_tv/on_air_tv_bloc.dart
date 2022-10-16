import 'package:bloc/bloc.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_on_air_tv.dart';
import 'package:equatable/equatable.dart';

part 'on_air_tv_event.dart';
part 'on_air_tv_state.dart';

class OnAirTvBloc extends Bloc<OnAirTvEvent, OnAirTvState> {
  final GetOnAirTv getOnAirTv;

  OnAirTvBloc(this.getOnAirTv) : super(OnAirTvEmpty()) {
    on<FetchOnAirTv>((event, emit) async {
      emit(OnAirTvLoading());

      final result = await getOnAirTv.execute();
      result.fold(
        (failure) {
          emit(OnAirTvError(failure.message));
        },
        (data) {
          emit(OnAirTvHasData(data));
        }
      );
    });
  }
}
