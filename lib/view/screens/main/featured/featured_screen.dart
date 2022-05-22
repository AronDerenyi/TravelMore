import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_more/bloc/featured_trails_bloc.dart';

class FeaturedScreen extends StatefulWidget {
  const FeaturedScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FeaturedScreenState();
}

class _FeaturedScreenState extends State<FeaturedScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FeaturedTrailsBloc>().add(LoadTrailsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeaturedTrailsBloc, FeaturedTrailsBlocState>(
      builder: (context, state) {
        if (state is LoadingTrailsState) {
          return const Center(child: Text("Loading..."));
        }

        if (state is TrailsReadyState) {
          return ListView.builder(
            itemCount: state.featuredTrails.length,
            itemBuilder: (context, index) =>
                Text(state.featuredTrails[index].title),
          );
        }

        throw Exception();
      },
    );
  }
}
