import 'package:bloc/bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:equatable/equatable.dart';

part 'nowplaying_movies_event.dart';
part 'nowplaying_movies_state.dart';

class NowPlayingMoviesBloc extends Bloc<NowPlayingMoviesEvent, NowPlayingMoviesState> {
  final GetNowPlayingMovies getNowPlayingMovies;

  NowPlayingMoviesBloc(this.getNowPlayingMovies) : super(NowPlayingMoviesEmpty()) {
    on<FetchNowPlayingMovies>((event, emit) async {
      emit(NowPlayingMoviesLoading());

      final result = await getNowPlayingMovies.execute();
      result.fold(
        (failure) {
          emit(NowPlayingMoviesError(failure.message));
        },
        (data)  {
          emit(NowPlayingMoviesHasData(data));
        }
      );
    });
  }
}
