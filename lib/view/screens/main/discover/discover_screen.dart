import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_more/bloc/regions_bloc.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({Key? key}) : super(key: key);
  
  @override
  State<StatefulWidget> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  @override
  void initState() {
    super.initState();
    context.read<RegionsBloc>().add(LoadEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegionsBloc, RegionsBlocState>(
      builder: (context, state) {
        if (state is LoadingState) {
          return const Center(child: Text("Loading..."));
        }

        if (state is ReadyState) {
          return ListView.builder(
            itemCount: state.regions.length,
            itemBuilder: (context, index) =>
                Text(state.regions[index].title),
          );
        }

        throw Exception();
      },
    );
  }
}