import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_more/bloc/trail_bloc.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<TrailBloc, TrailBlocState>(builder: (context, state) {
        return Center(
            child: Column(children: [
          Text(state.trail.title),
          Text(state.trail.description),
        ]));
      }),
    );
  }
}
