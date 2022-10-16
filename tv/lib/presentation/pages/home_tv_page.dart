import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/presentation/bloc/tv_list_page/on_air_tv/on_air_tv_bloc.dart';
import 'package:tv/presentation/bloc/tv_list_page/popular_tv/popular_tv_bloc.dart';
import 'package:tv/presentation/bloc/tv_list_page/top_rated_tv/top_rated_tv_bloc.dart';
import 'package:tv/presentation/pages/popular_tv_page.dart';
import 'package:tv/presentation/pages/top_rated_tv_page.dart';
import 'package:tv/presentation/pages/tv_detail_page.dart';

class HomeTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/home-tv-page';

  const HomeTvPage({super.key});

  @override
  _HomeTvPageState createState() => _HomeTvPageState();
}

class _HomeTvPageState extends State<HomeTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<OnAirTvBloc>(context).add(FetchOnAirTv());
      BlocProvider.of<PopularTvBloc>(context).add(FetchPopularTv());
      BlocProvider.of<TopRatedTvBloc>(context).add(FetchTopRatedTv());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'On Air',
              style: kHeading6,
            ),
            BlocBuilder<OnAirTvBloc, OnAirTvState>(builder: (context, state) {
              if (state is OnAirTvLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is OnAirTvHasData) {
                final tv = state.onAirTv;
                return TvList(tv);
              } else {
                return const Text('Failed');
              }
            }),
            _buildSubHeading(
              title: 'Popular',
              onTap: () => Navigator.pushNamed(context, PopularTvPage.ROUTE_NAME),
            ),
            BlocBuilder<PopularTvBloc, PopularTvState>(
                builder: (context, state) {
                  if (state is PopularTvLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is PopularTvHasData) {
                    final tv = state.popularTv;
                    return TvList(tv);
                  } else {
                    return const Text('Failed');
                  }
                }),
            _buildSubHeading(
              title: 'Top Rated',
              onTap: () => Navigator.pushNamed(context, TopRatedTvPage.ROUTE_NAME),
            ),
            BlocBuilder<TopRatedTvBloc, TopRatedTvState>(
                builder: (context, state) {
                  if (state is TopRatedTvLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TopRatedTvHasData) {
                    final tv = state.topRatedTv;
                    return TvList(tv);
                  } else {
                    return const Text('Failed');
                  }
                }),
          ],
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TvList extends StatelessWidget {
  final List<Tv> tv;
  const TvList(this.tv, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = tv[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TvDetailPage.ROUTE_NAME,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tv.length,
      ),
    );
  }
}
