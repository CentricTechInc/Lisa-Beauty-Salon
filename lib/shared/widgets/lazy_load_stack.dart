import 'package:flutter/material.dart';

class LazyLoadStack extends StatefulWidget {
  final int index;
  final List<WidgetBuilder> builders;

  const LazyLoadStack({
    super.key,
    required this.index,
    required this.builders,
  });

  @override
  State<LazyLoadStack> createState() => _LazyLoadStackState();
}

class _LazyLoadStackState extends State<LazyLoadStack> {
  late List<bool> _initialized;

  @override
  void initState() {
    super.initState();
    _initialized = List.filled(widget.builders.length, false);
  }

  @override
  Widget build(BuildContext context) {
    _initialized[widget.index] = true;

    return IndexedStack(
      index: widget.index,
      children: List.generate(widget.builders.length, (i) {
        if (_initialized[i]) {
          return widget.builders[i](context);
        } else {
          return const SizedBox.shrink();
        }
      }),
    );
  }
}
