import 'package:flutter/material.dart';

class TextView extends StatelessWidget {
  const TextView({super.key, required this.duration});
  final int duration;

  @override
  Widget build(BuildContext context) {
    // final duration = context.select((TimerBloc bloc) => bloc.state.duration);

    final hourStr =
        duration >= 60 * 60
            ? "${((duration / 60 / 60) % 60).floor().toString().padLeft(2, '0')}:"
            : "";

    final minuteStr = ((duration / 60) % 60).floor().toString().padLeft(2, '0');
    final secondStr = (duration % 60).toString().padLeft(2, '0');
    return Text(
      "$hourStr$minuteStr:$secondStr",
      style: TextStyle(fontSize: 50),
    );
  }
}