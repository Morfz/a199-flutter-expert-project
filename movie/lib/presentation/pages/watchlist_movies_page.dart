import 'package:movie/presentation/bloc/watchlist_movie_page/watchlist_page_bloc.dart';
import 'package:movie/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/core.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  const WatchlistMoviesPage({super.key});

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        BlocProvider.of<MovieWatchlistPageBloc>(context, listen: false).add(FetchWatchlistMoviePage()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    BlocProvider.of<MovieWatchlistPageBloc>(context, listen: false).add(FetchWatchlistMoviePage());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<MovieWatchlistPageBloc, WatchlistMoviePageState>(
          builder: (context, state) {
            if (state is WatchlistPageLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WatchlistPageHasData) {
              final result = state.movie;
              if (result.isEmpty) {
                return const Center(child: Text("Nothing to see here"));
              }
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = result[index];
                  return MovieCard(movie);
                },
                itemCount: result.length,
              );
            } else if (state is WatchlistPageError) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return const Text("");
            }
          },
        ),
      );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
