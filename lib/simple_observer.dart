import 'package:bloc/bloc.dart';

class TimerObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print('📢 Event: $event in ${bloc.runtimeType}');
  }

  // @override
  // void onChange(BlocBase bloc, Change change) {
  //   super.onChange(bloc, change);
  //   print('🔄 State Change: ${change.currentState} → ${change.nextState}');
  // }

  // @override
  // void onTransition(Bloc bloc, Transition transition) {
  //   super.onTransition(bloc, transition);
  //   print('🔀 Transition: $transition');
  // }

  // @override
  // void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
  //   print('❌ Error in ${bloc.runtimeType}: $error');
  //   super.onError(bloc, error, stackTrace);
  // }
}
