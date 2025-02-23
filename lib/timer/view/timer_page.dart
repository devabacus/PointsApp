import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pointsapp/ticker.dart';
import 'package:pointsapp/timer/bloc/timer_bloc.dart';
import 'package:pointsapp/timer/view/timer_text.dart';
import 'timer_actions.dart';

class TimerPage extends StatelessWidget {
  const TimerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TimerBloc(ticker: Ticker()),
      child: TimerView(),
    );
  }
}

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
              Background(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TimerValuePicker(
                    onTimerValueSelected:
                        (value) => _onTimerValueChanged(context, value),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 100),
                    child: TextView(
                      duration: context.select(
                        (TimerBloc bloc) => bloc.state.duration,
                      ),
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

class TimerValuePicker extends StatelessWidget {
  // final ValueChanged<int?> onTimerValueSelected;
  final ValueChanged<int> onTimerValueSelected;
  TimerValuePicker({super.key, required this.onTimerValueSelected});
  final List<int> _timerValues = [25, 30, 40, 60, 90, 120, 180];

  @override
  Widget build(BuildContext context) {
    final selectedValue = context.select(
      (TimerBloc bloc) => bloc.state.duration ~/ 60,
    );
    return DropdownMenu<int>(
      initialSelection: selectedValue,
      dropdownMenuEntries:
          _timerValues
              .map(
                (int item) =>
                    DropdownMenuEntry(value: item, label: item.toString()),
              )
              .toList(),
      onSelected: (value) {
        if (value != null) {
          onTimerValueSelected(value);
        }
      },
    );
  }
}



class Background extends StatelessWidget {
  const Background({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade50, Colors.blue.shade500],
          ),
        ),
      ),
    );
  }
}
