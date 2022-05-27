import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_more/bloc/trail_bloc.dart';
import 'package:travel_more/view/screens/trail/trail_details.dart';
import 'package:travel_more/view/screens/trail/trail_header.dart';
import 'package:travel_more/view/screens/trail/trail_map.dart';
import 'package:travel_more/view/widgets/scroll_translation.dart';

class TrailScreen extends StatelessWidget {
  final String trailId;
  final ScrollController _scrollController = ScrollController();

  TrailScreen({Key? key, required this.trailId}) : super(key: key);

  static MaterialPageRoute route(String trailId) => MaterialPageRoute(
        builder: (context) => TrailScreen(trailId: trailId),
        settings: const RouteSettings(name: "/trail"),
      );

  @override
  Widget build(BuildContext context) {
    var safeArea = MediaQuery.of(context).padding;
    var colors = Theme.of(context).colorScheme;

    var mapSize = 400 + safeArea.top;
    var overlap = 128.0;
    var boxShadow = const BoxShadow(
      color: Colors.black26,
      blurRadius: 24,
    );

    return BlocProvider(
      create: (context) => TrailBloc()..add(LoadTrailEvent(trailId)),
      child: Stack(children: [
        Positioned(
          left: 0,
          right: 0,
          top: 0,
          height: mapSize,
          child: ScrollTranslation(
            controller: _scrollController,
            direction: const Offset(0, 0.4),
            child: const TrailMap(),
          ),
        ),
        Positioned.fill(
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: mapSize - overlap),
                    SizedBox(
                      height: overlap,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              colors.surface.withAlpha(0),
                              colors.surface,
                            ],
                          ),
                        ),
                        child: const TrailHeader(),
                      ),
                    ),
                    Expanded(
                      child: Material(
                        color: colors.surface,
                        child: const TrailDetails(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Material(
                type: MaterialType.circle,
                color: colors.surface,
                clipBehavior: Clip.hardEdge,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
