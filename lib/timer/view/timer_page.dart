import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pointsapp/ticker.dart';
import 'package:pointsapp/timer/bloc/timer_bloc.dart';

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
      body: Stack(
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
                child: TextView(),
              ),
              Actions(),
            ],
          ),
        ],
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

class TextView extends StatelessWidget {
  const TextView({super.key});

  @override
  Widget build(BuildContext context) {
    final duration = context.select((TimerBloc bloc) => bloc.state.duration);

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

class Actions extends StatelessWidget {
  const Actions({super.key});

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
                  child: const Icon(Icons.play_arrow),
                  onPressed:
                      () => context.read<TimerBloc>().add(
                        TimerStarted(duration: state.duration),
                      ),
                ),
              ],

              TimerRunInProgress() => [
                FloatingActionButton(
                  child: const Icon(Icons.pause),
                  onPressed: () => context.read<TimerBloc>().add(TimerPaused()),
                ),
                FloatingActionButton(
                  child: const Icon(Icons.replay),
                  onPressed: () => context.read<TimerBloc>().add(TimerReset()),
                ),
              ],

              TimerRunPause() => [
                FloatingActionButton(
                  child: Icon(Icons.play_arrow),
                  onPressed:
                      () => context.read<TimerBloc>().add(TimerResumed()),
                ),

                FloatingActionButton(
                  child: const Icon(Icons.replay),
                  onPressed: () => context.read<TimerBloc>().add(TimerReset()),
                ),
              ],

              TimerRunComplete() => [
                FloatingActionButton(
                  child: const Icon(Icons.replay),
                  onPressed: () => context.read<TimerBloc>().add(TimerReset()),
                ),
              ],
            },
          ],
        );
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
