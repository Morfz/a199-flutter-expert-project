import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_tv_recommendation.dart';

part 'tv_recommendations_event.dart';
part 'tv_recommendations_state.dart';

class TvRecommendationsBloc
    extends Bloc<TvRecommendationsEvent, TvRecommendationsState> {
  final GetTvRecommendations getTvRecommendations;
  TvRecommendationsBloc(this.getTvRecommendations)
      : super(TvRecommendationsEmpty()) {
    on<OnFetchTvRecommendations>((event, emit) async {
      emit(TvRecommendationsLoading());

      final result = await getTvRecommendations.execute(event.id);
      result.fold((failure) {
        emit(TvRecommendationsError(failure.message));
      }, (data) {
        emit(TvRecommendationsHasData(data));
      });
    });
  }
}
