import 'package:firebase_core/firebase_core.dart';
import 'package:movie/presentation/bloc/movie_detail_page/movie_detail/movie_detail_bloc.dart';
import 'package:movie/presentation/bloc/movie_detail_page/movie_recommendation/movie_recommendation_bloc.dart';
import 'package:movie/presentation/bloc/movie_detail_page/watchlist_status/watchlist_movie_status_bloc.dart';
import 'package:movie/presentation/bloc/movie_list_page/nowplaying_movies/nowplaying_movies_bloc.dart';
import 'package:movie/presentation/bloc/movie_list_page/popular_movies/popular_movies_bloc.dart';
import 'package:movie/presentation/bloc/movie_list_page/top_rated_movies/top_rated_movies_bloc.dart';
import 'package:movie/presentation/bloc/watchlist_movie_page/watchlist_movie_page_bloc.dart';
import 'package:tv/presentation/bloc/tv_detail_page/tv_detail/tv_detail_bloc.dart';
import 'package:tv/presentation/bloc/tv_detail_page/tv_recommendations/tv_recommendations_bloc.dart';
import 'package:tv/presentation/bloc/tv_detail_page/tv_watchlist_status/tv_watchlist_status_bloc.dart';
import 'package:tv/presentation/bloc/tv_list_page/on_air_tv/on_air_tv_bloc.dart';
import 'package:tv/presentation/bloc/tv_list_page/popular_tv/popular_tv_bloc.dart';
import 'package:tv/presentation/bloc/tv_list_page/top_rated_tv/top_rated_tv_bloc.dart';
import 'package:tv/presentation/bloc/tv_watchlist_page/watchlist_page_bloc.dart';
import 'firebase_options.dart';
import 'package:ditonton/presentation/home.dart';
import 'package:ditonton/presentation/search_page.dart';
import 'package:ditonton/presentation/watchlist_page.dart';
import 'package:search/presentation/bloc/search_movie_bloc.dart';
import 'package:search/presentation/bloc/search_tv_bloc.dart';
import 'package:search/presentation/pages/movie_search_page.dart';
import 'package:search/presentation/pages/tv_search_page.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';
import 'package:movie/presentation/pages/popular_movies_page.dart';
import 'package:tv/presentation/pages/on_air_tv_page.dart';
import 'package:tv/presentation/pages/popular_tv_page.dart';
import 'package:movie/presentation/pages/top_rated_movies_page.dart';
import 'package:movie/presentation/pages/watchlist_movies_page.dart';
import 'package:tv/presentation/pages/tv_detail_page.dart';
import 'package:tv/presentation/pages/watchlist_tv_page.dart';
import 'package:tv/presentation/pages/top_rated_tv_page.dart';
import 'package:core/core.dart';
import 'package:about/about.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HttpSSLPinning.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<NowPlayingMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieRecommendationBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistMovieStatusBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistMoviePageBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<OnAirTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvRecommendationsBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistTvStatusBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistTvPageBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchTvBloc>(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme, colorScheme: kColorScheme.copyWith(secondary: kMikadoYellow),
        ),
        home: Home(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => Home());

            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SearchMoviePage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchMoviePage());
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());

            case PopularTvPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularTvPage());
            case TopRatedTvPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedTvPage());
            case TvDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvDetailPage(id: id),
                settings: settings,
              );
            case OnAirTvPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => OnAirTvPage());
            case SearchTvPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchTvPage());
            case WatchlistTvPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistTvPage());

            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case WatchlistPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found'),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
