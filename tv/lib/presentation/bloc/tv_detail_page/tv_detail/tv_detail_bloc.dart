import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/domain/usecases/get_tv_detail.dart';

part 'tv_detail_event.dart';
part 'tv_detail_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  final GetTvDetail getTvDetail;

  TvDetailBloc(this.getTvDetail) : super(TvDetailEmpty()) {
    on<FetchTvDetail>((event, emit) async {
      emit(TvDetailLoading());

      final result = await getTvDetail.execute(event.id);
      result.fold((failure) {
        emit(TvDetailError(failure.message));
      }, (data) {
        emit(TvDetailHasData(data));
      });
    });
  }
}
