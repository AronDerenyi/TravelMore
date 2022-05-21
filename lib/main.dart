import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_more/bloc/favorite_trails_bloc.dart';
import 'package:travel_more/bloc/featured_trails_bloc.dart';
import 'package:travel_more/bloc/region_trails_bloc.dart';
import 'package:travel_more/bloc/trail_bloc.dart';
import 'package:travel_more/view/screens/main/main_screen.dart';

import 'bloc/regions_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => FavoriteTrailsBloc()),
          BlocProvider(create: (context) => FeaturedTrailsBloc()),
          BlocProvider(create: (context) => RegionTrailsBloc()),
          BlocProvider(create: (context) => RegionsBloc()),
          BlocProvider(create: (context) => TrailBloc()),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const MainScreen(),
        ));
  }
}
