part of 'on_air_tv_bloc.dart';

abstract class OnAirTvState extends Equatable {
  const OnAirTvState();
  
  @override
  List<Object> get props => [];
}

class OnAirTvEmpty extends OnAirTvState {}

class OnAirTvLoading extends OnAirTvState {}

class OnAirTvError extends OnAirTvState {
  final String message;
 
  const OnAirTvError(this.message);
 
  @override
  List<Object> get props => [message];
}

class OnAirTvHasData extends OnAirTvState {
  final List<Tv> tv;
 
  const OnAirTvHasData(this.tv);
 
  @override
  List<Object> get props => [tv];
}