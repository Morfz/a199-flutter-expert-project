import 'package:bloc/bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:equatable/equatable.dart';

part 'nowplaying_movies_event.dart';
part 'nowplaying_movies_state.dart';

class NowplayingMoviesBloc extends Bloc<NowPlayingMoviesEvent, NowplayingMoviesState> {
  final GetNowPlayingMovies getNowPlayingMovies;
  NowplayingMoviesBloc(this.getNowPlayingMovies) : super(NowplayingMoviesEmpty()) {
    on<FetchNowPlayingMovies>((event, emit) async {
      emit(NowplayingMoviesLoading());

      final result = await getNowPlayingMovies.execute();
      result.fold(
              (failure) {
            emit(NowplayingMoviesError(failure.message));
          },
              (data)  {
            emit(NowPlayingMoviesHasData(data));
          }
      );
    });
  }
}
