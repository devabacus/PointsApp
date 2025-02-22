part of 'timer_bloc.dart';

sealed class TimerState extends Equatable {
  final int duration;
  const TimerState(this.duration);

  @override
  List<Object> get props => [duration];
}

class TimerInitial extends TimerState {
  const TimerInitial(super.duration);

  @override
  List<Object> get props => [duration];
}

class TimerRunPause extends TimerState {
  const TimerRunPause(super.duration);

  @override
  List<Object> get props => [duration];
}

class TimerRunInProgress extends TimerState {
  const TimerRunInProgress(super.duration);

  @override
  List<Object> get props => [duration];
}

final class TimerRunComplete extends TimerState {
  const TimerRunComplete() : super(0);
}
