import 'package:tv/presentation/bloc/tv_list_page/on_air_tv/on_air_tv_bloc.dart';
import 'package:tv/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnAirTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/on-air-tv';

  const OnAirTvPage({super.key});

  @override
  _OnAirTvPageState createState() => _OnAirTvPageState();
}

class _OnAirTvPageState extends State<OnAirTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        BlocProvider.of<OnAirTvBloc>(context).getOnAirTv);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('On Air TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<OnAirTvBloc, OnAirTvState>(
          builder: (context, state) {
            if (state is OnAirTvLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is OnAirTvHasData) {
              final result = state.onAirTv;
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
      ),
    );
  }
}
