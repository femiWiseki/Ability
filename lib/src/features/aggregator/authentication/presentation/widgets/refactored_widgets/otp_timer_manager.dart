import 'dart:async';

class OtpTimerManager {
  int _startMinutes = 1;
  int _startSeconds = 0;
  late Timer _timer;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_startSeconds == 0) {
          if (_startMinutes == 0) {
            timer.cancel();
            // Timer has completed, implement your logic here
          } else {
            _startMinutes--;
            _startSeconds = 59;
          }
        } else {
          _startSeconds--;
        }
      },
    );
  }

  void stopTimer() {
    _timer.cancel();
  }

  String getFormattedTime() {
    return '${_startMinutes.toString().padLeft(1, '0')}.${_startSeconds.toString().padLeft(2, '0')}';
  }
}
