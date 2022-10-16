import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/tv_watchlist_page/watchlist_page_bloc.dart';
import 'package:tv/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:core/core.dart';

class WatchlistTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-tv';

  const WatchlistTvPage({super.key});

  @override
  _WatchlistTvPageState createState() => _WatchlistTvPageState();
}

class _WatchlistTvPageState extends State<WatchlistTvPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        BlocProvider.of<WatchlistTvPageBloc>(context, listen: false).add(FetchWatchlistTvPage()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
        BlocProvider.of<WatchlistTvPageBloc>(context, listen: false).add(FetchWatchlistTvPage());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistTvPageBloc, WatchlistTvPageState>(
          builder: (context, state) {
            if (state is WatchlistTvPageLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WatchlistTvPageHasData) {
              final result = state.tv;
              if (result.isEmpty) {
                return const Center(child: Text("Nothing to see here"));
              }
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = result[index];
                  return TvCard(tv);
                },
                itemCount: result.length,
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
