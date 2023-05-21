import 'dart:async';
import 'package:flutter/material.dart';

class TimerWidget extends StatefulWidget {
  const TimerWidget({Key? key, required this.changeResendClicked})
      : super(key: key);
  //final int duration;
  final Function() changeResendClicked;
  //final String slotNumber;
  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  Duration? duration;
  Timer? timer;
  bool isCountdown = true;

  @override
  void initState() {
    super.initState();
    duration = const Duration(seconds: 60);
    //setState(() {});
    startTimer();
  }

  Future<void> addTimer() async {
    final addSeconds = isCountdown ? -1 : 1;

    if (mounted) {
      setState(() {
        final seconds = duration!.inSeconds + addSeconds;
        if (seconds <= 0) {
          widget.changeResendClicked();
        } else {
          duration = Duration(seconds: seconds);
        }
      });
      if (!timer!.isActive) {}
    }
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      return await addTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: buildTimer()),
    );
  }

  Widget buildTimer() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    //final hours = twoDigits(duration!.inHours);
    final minutes = twoDigits(duration!.inMinutes.remainder(60));
    final seconds = twoDigits(duration!.inSeconds.remainder(60));

    return SizedBox(
      width: 50,
      height: 20,
      child: Text(
        '$minutes:$seconds',
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }
}
