import 'package:core/core.dart';
import 'package:movie/presentation/bloc/movie_list_page/top_rated_movies/top_rated_movies_bloc.dart';
import 'package:movie/presentation/widgets/movie_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-movie';

  const TopRatedMoviesPage({super.key});

  @override
  _TopRatedMoviesPageState createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => BlocProvider.of<TopRatedMoviesBloc>(context).add(FetchTopRatedMovies()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedMoviesBloc, TopRatedMoviesState>(
          builder: (context, state) {
            if (state is TopRatedMoviesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TopRatedMoviesHasData) {
              final result = state.topRatedMovie;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = result[index];
                  return MovieCard(movie);
                },
                itemCount: result.length,
              );
            } else if (state is TopRatedMoviesEmpty) {
              return Center(
                child: Text('Empty Top Rated Movie', style: kSubtitle),
              );
            } else if (state is TopRatedMoviesError) {
              return Center(
                key: Key('error_message'),
                child: Text(state.message, style: kSubtitle),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
