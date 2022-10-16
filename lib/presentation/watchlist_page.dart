import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:movie/presentation/pages/watchlist_movies_page.dart';
import 'package:tv/presentation/pages/watchlist_tv_page.dart';

class WatchlistPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist';

  const WatchlistPage({Key? key}) : super(key: key);

  @override
  _WatchlistPageState createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> with RouteAware {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Watchlist'),
          bottom: TabBar(
            indicatorColor: kMikadoYellow,
            tabs: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text("Movies"),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text("TV Series"),
              )
            ],
          ),
        ),
        body: TabBarView(children: [WatchlistMoviesPage(), WatchlistTvPage()]),
      ),
    );
  }
}
