// // ignore_for_file: library_private_types_in_public_api

// import 'dart:async';
// import 'package:ability/src/constants/app_text_style/poppins.dart';
// import 'package:ability/src/constants/colors.dart';
// import 'package:flutter/material.dart';

// class OtpTimer extends StatefulWidget {
//   const OtpTimer({Key? key}) : super(key: key);

//   @override
//   _OtpTimerState createState() => _OtpTimerState();
// }

// class _OtpTimerState extends State<OtpTimer> {
//   int _startMinutes = 1;
//   int _startSeconds = 0;
//   late Timer _timer;

//   @override
//   void initState() {
//     super.initState();
//     startTimer();
//   }

//   void startTimer() {
//     const oneSec = Duration(seconds: 1);
//     _timer = Timer.periodic(
//       oneSec,
//       (Timer timer) {
//         if (_startSeconds == 0) {
//           if (_startMinutes == 0) {
//             timer.cancel();
//             // Timer has completed, implement your logic here
//           } else {
//             setState(() {
//               _startMinutes--;
//               _startSeconds = 59;
//             });
//           }
//         } else {
//           setState(() {
//             _startSeconds--;
//           });
//         }
//       },
//     );
//   }

//   @override
//   void dispose() {
//     _timer.cancel(); // Cancel the timer when the widget is disposed
//     super.dispose();
//   }

//   void resetTimer() {
//     setState(() {
//       _startMinutes = 1;
//       _startSeconds = 0;
//     });
//     startTimer();
//   }

//   @override
//   Widget build(BuildContext context) {
//     String formattedTime =
//         '${_startMinutes.toString().padLeft(1, '0')}.${_startSeconds.toString().padLeft(2, '0')}';

//     return Center(
//       child: Text(formattedTime,
//           style:
//               AppStylePoppins.kFontW5.copyWith(fontSize: 10, color: kPrimary)),
//     );
//   }
// }
import 'dart:async';
import 'package:flutter/material.dart';

class AgentOTPTimer extends StatefulWidget {
  final VoidCallback resetTimer;

  const AgentOTPTimer({Key? key, required this.resetTimer}) : super(key: key);

  @override
  State<AgentOTPTimer> createState() => _AgentOTPTimerState();
}

class _AgentOTPTimerState extends State<AgentOTPTimer> {
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
            setState(() {
              _startMinutes--;
              _startSeconds = 59;
            });
          }
        } else {
          setState(() {
            _startSeconds--;
          });
        }
      },
    );
  }

  void stopTimer() {
    _timer.cancel();
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String formattedTime =
        '${_startMinutes.toString().padLeft(1, '0')}.${_startSeconds.toString().padLeft(2, '0')}';

    return Text(
      formattedTime,
      style: const TextStyle(fontSize: 10),
    );
  }
}
