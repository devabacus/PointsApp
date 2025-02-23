import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pointsapp/timer/bloc/timer_bloc.dart';
import 'package:pointsapp/timer/view/dropdown_picker.dart';
import 'package:pointsapp/timer/view/timer_background.dart';
import 'package:pointsapp/timer/view/timer_text.dart';

import 'timer_actions.dart';

class TimerView extends StatelessWidget {
  const TimerView({super.key});

  void _onTimerValueChanged(BuildContext context, int? newValue) {
    context.read<TimerBloc>().add(
      TimerDurationChanged(duration: newValue! * 60),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TimerBloc, TimerState>(
        builder: (context, state) {
          return Stack(
            children: [
              const Background(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TimerValuePicker(
                    onValueSelected:
                        (value) => _onTimerValueChanged(context, value),
                    selectedValue: context.select(
                      (TimerBloc bloc) => bloc.state.duration ~/ 60,
                    ),
                    options: [25, 30, 40, 60, 90, 120, 180],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 100),
                    child: BlocSelector<TimerBloc, TimerState, int>(
                      selector: (state) => state.duration,
                      builder: (context, duration) {
                        return TextView(duration: duration);
                      },
                    ),
                  ),
                  TimerActions(
                    state: state,
                    onStart:
                        () => context.read<TimerBloc>().add(
                          TimerStarted(
                            duration: context.read<TimerBloc>().state.duration,
                          ),
                        ),
                    onPause: () => context.read<TimerBloc>().add(TimerPaused()),
                    onResume:
                        () => context.read<TimerBloc>().add(TimerResumed()),
                    onReset: () => context.read<TimerBloc>().add(TimerReset()),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
