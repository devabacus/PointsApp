import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pointsapp/features/timer/bloc/timer_bloc.dart';

class TimerActions extends StatelessWidget {
  final TimerState state;
  final VoidCallback onStart;
  final VoidCallback onPause;
  final VoidCallback onResume;
  final VoidCallback onReset;

  const TimerActions({
    super.key,
    required this.state,
    required this.onStart,
    required this.onPause,
    required this.onResume,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      // buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ...switch (state) {
              TimerInitial() => [
                FloatingActionButton(
                  onPressed: onStart,
                  child: const Icon(Icons.play_arrow),
                ),
              ],

              TimerRunInProgress() => [
                FloatingActionButton(
                  onPressed: onPause,
                  child: const Icon(Icons.pause),
                ),
              ],

              TimerRunPause() => [
                FloatingActionButton(
                  onPressed: onResume,
                  child: Icon(Icons.play_arrow),
                ),

                FloatingActionButton(
                  onPressed: onReset,
                  child: const Icon(Icons.replay),
                ),
              ],

              TimerRunComplete() => [
                FloatingActionButton(
                  onPressed: onReset,
                  child: const Icon(Icons.replay),
                ),
              ],
            },
          ],
        );
      },
    );
  }
}
