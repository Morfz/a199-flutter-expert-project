import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:search/presentation/pages/movie_search_page.dart';
import 'package:search/presentation/pages/tv_search_page.dart';

class SearchPage extends StatefulWidget {
  static const ROUTE_NAME = '/search';

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Search'),
          bottom: TabBar(
            indicatorColor: kMikadoYellow,
            tabs: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text("Movie"),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text("TV Series"),
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SearchMoviePage(),
            SearchTvPage()
          ],
        ),
      ),
    );
  }
}
