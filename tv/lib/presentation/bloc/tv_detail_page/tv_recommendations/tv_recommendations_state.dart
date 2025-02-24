part of 'tv_recommendations_bloc.dart';

abstract class TvRecommendationsState extends Equatable {
  const TvRecommendationsState();

  @override
  List<Object> get props => [];
}

class TvRecommendationsEmpty extends TvRecommendationsState {}

class TvRecommendationsLoading extends TvRecommendationsState {}

class TvRecommendationsError extends TvRecommendationsState {
  final String message;

  const TvRecommendationsError(this.message);

  @override
  List<Object> get props => [message];
}

class TvRecommendationsHasData extends TvRecommendationsState {
  final List<Tv> tvRecommendation;

  const TvRecommendationsHasData(this.tvRecommendation);

  @override
  List<Object> get props => [tvRecommendation];
}
