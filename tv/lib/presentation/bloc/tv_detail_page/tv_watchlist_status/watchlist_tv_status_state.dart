part of 'tv_watchlist_status_bloc.dart';

class WatchlistTvStatusState extends Equatable {
  final bool status;
  final String message;
  const WatchlistTvStatusState(this.status, this.message);

  @override
  List<Object> get props => [status, message];
}
