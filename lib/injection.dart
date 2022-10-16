import 'package:core/core.dart';
import 'package:movie/presentation/bloc/movie_detail_page/movie_detail/movie_detail_bloc.dart';
import 'package:movie/presentation/bloc/movie_detail_page/movie_recommendation/movie_recommendation_bloc.dart';
import 'package:movie/presentation/bloc/movie_detail_page/watchlist_status/watchlist_movie_status_bloc.dart';
import 'package:movie/presentation/bloc/movie_list_page/nowplaying_movies/nowplaying_movies_bloc.dart';
import 'package:movie/presentation/bloc/movie_list_page/popular_movies/popular_movies_bloc.dart';
import 'package:movie/presentation/bloc/movie_list_page/top_rated_movies/top_rated_movies_bloc.dart';
import 'package:movie/presentation/bloc/watchlist_movie_page/watchlist_movie_page_bloc.dart';
import 'package:search/presentation/bloc/search_movie_bloc.dart';
import 'package:search/presentation/bloc/search_tv_bloc.dart';
import 'package:search/domain/usecases/search_movies.dart';
import 'package:search/domain/usecases/search_tv.dart';
import 'package:movie/data/datasources/db/movie_database_helper.dart';
import 'package:movie/data/datasources/movie_local_data_source.dart';
import 'package:movie/data/datasources/movie_remote_data_source.dart';
import 'package:movie/data/repositories/movie_repository_impl.dart';
import 'package:tv/data/datasources/db/tv_database_helper.dart';
import 'package:tv/data/datasources/tv_local_data_source.dart';
import 'package:tv/data/datasources/tv_remote_data_source.dart';
import 'package:tv/data/repositories/tv_repository_impl.dart';
import 'package:movie/domain/repositories/movie_repository.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';
import 'package:movie/domain/usecases/get_watchlist_movie_status.dart';
import 'package:movie/domain/usecases/remove_watchlist_movie.dart';
import 'package:movie/domain/usecases/save_watchlist_movie.dart';
import 'package:tv/domain/usecases/get_top_rated_tv.dart';
import 'package:tv/domain/usecases/get_tv_detail.dart';
import 'package:tv/domain/usecases/get_tv_recommendation.dart';
import 'package:tv/domain/usecases/get_watchlist_tv_status.dart';
import 'package:tv/domain/usecases/remove_watchlist_tv.dart';
import 'package:tv/domain/usecases/save_watchlist_tv.dart';
import 'package:tv/domain/usecases/get_on_air_tv.dart';
import 'package:tv/domain/usecases/get_popular_tv.dart';
import 'package:tv/domain/usecases/get_watchlist_tv.dart';
import 'package:tv/domain/repositories/tv_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:tv/presentation/bloc/tv_detail_page/tv_detail/tv_detail_bloc.dart';
import 'package:tv/presentation/bloc/tv_detail_page/tv_recommendations/tv_recommendations_bloc.dart';
import 'package:tv/presentation/bloc/tv_detail_page/tv_watchlist_status/tv_watchlist_status_bloc.dart';
import 'package:tv/presentation/bloc/tv_list_page/on_air_tv/on_air_tv_bloc.dart';
import 'package:tv/presentation/bloc/tv_list_page/popular_tv/popular_tv_bloc.dart';
import 'package:tv/presentation/bloc/tv_list_page/top_rated_tv/top_rated_tv_bloc.dart';
import 'package:tv/presentation/bloc/tv_watchlist_page/watchlist_page_bloc.dart';

final locator = GetIt.instance;

void init() {
  // bloc
  locator.registerFactory(() => NowPlayingMoviesBloc(locator()));
  locator.registerFactory(() => MovieDetailBloc(getMovieDetail: locator()));
  locator.registerFactory(() => MovieRecommendationBloc(locator()));
  locator.registerFactory(() => SearchMovieBloc(locator()));
  locator.registerFactory(() => PopularMoviesBloc(locator()));
  locator.registerFactory(() => TopRatedMoviesBloc(locator()));
  locator.registerFactory(() => MovieWatchlistPageBloc(locator()));
  locator.registerFactory(() => WatchlistMovieStatusBloc(
      getWatchlistStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator()));

  locator.registerFactory(() => OnAirTvBloc(locator()));
  locator.registerFactory(() => TvDetailBloc(locator()));
  locator.registerFactory(() => TvRecommendationsBloc(locator()));
  locator.registerFactory(() => SearchTvBloc(locator()));
  locator.registerFactory(() => PopularTvBloc(locator()));
  locator.registerFactory(() => TopRatedTvBloc(locator()));
  locator.registerFactory(() => WatchlistTvPageBloc(locator()));
  locator.registerFactory(() => WatchlistTvStatusBloc(
      saveTvWatchlist: locator(),
      removeTvWatchlist: locator(),
      getWatchlistTvStatus: locator()));

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListMovieStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlistMovie(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistMovie(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  locator.registerLazySingleton(() => GetOnAirTv(locator()));
  locator.registerLazySingleton(() => GetPopularTv(locator()));
  locator.registerLazySingleton(() => GetTopRatedTv(locator()));
  locator.registerLazySingleton(() => GetTvDetail(locator()));
  locator.registerLazySingleton(() => GetTvRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTv(locator()));
  locator.registerLazySingleton(() => GetWatchListTvStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTv(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTv(locator()));
  locator.registerLazySingleton(() => GetWatchlistTv(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
        () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  locator.registerLazySingleton<TvRepository>(
        () => TvRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
          () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
          () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  locator.registerLazySingleton<TvRemoteDataSource>(
          () => TvRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvLocalDataSource>(
          () => TvLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<MovieDatabaseHelper>(() => MovieDatabaseHelper());

  locator.registerLazySingleton<TvDatabaseHelper>(() => TvDatabaseHelper());

  // external
  locator.registerLazySingleton(() => HttpSSLPinning.client);
}
