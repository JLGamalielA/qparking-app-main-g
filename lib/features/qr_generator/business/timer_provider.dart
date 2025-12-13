import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vibration/vibration.dart';

final qrTimerProvider = StateNotifierProvider<QrTimerNotifier, QrTimerState>((
  ref,
) {
  return QrTimerNotifier();
});

class QrTimerNotifier extends StateNotifier<QrTimerState> {
  QrTimerNotifier() : super(QrTimerState());

  void resetQrTimer() {
    state = state.copyWith(startCount: false, time: 15);
  }

  void startQrTimer() async {
    if (!state.startCount) {
      Vibration.cancel();
      Vibration.vibrate(duration: 1500);
      state = state.copyWith(startCount: true);
      while (state.time >= 0) {
        await Future.delayed(Duration(seconds: 1));
        state = state.copyWith(time: state.time - 1);
      }
      Vibration.vibrate(duration: 1500);
      resetQrTimer();
    }
  }
}

class QrTimerState {
  int time;
  bool startCount;
  QrTimerState({this.time = 15, this.startCount = false});

  QrTimerState copyWith({int? time, bool? startCount}) {
    return QrTimerState(
      time: time ?? this.time,
      startCount: startCount ?? this.startCount,
    );
  }
}
