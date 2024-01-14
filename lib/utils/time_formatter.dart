class TimeFormatter {
  static String timeToDoubleDigitStringValue(int value) =>
      value.toString().padLeft(2, "0");

  static String durationInMillisecondsToStringValue(double value) {
    final hours = timeToDoubleDigitStringValue(
        Duration(milliseconds: value.toInt()).inHours.remainder(60));
    final minutes = timeToDoubleDigitStringValue(
        Duration(milliseconds: value.toInt()).inMinutes.remainder(60));
    final seconds = timeToDoubleDigitStringValue(
        Duration(milliseconds: value.toInt()).inSeconds.remainder(60) % 60);

    return "$hours:$minutes:$seconds";
  }

  static String timeDurationToReadableText(int timeDuration) {

    String readableDuration = "";

    // final hours = timeDuration.inHours.remainder(60);
    // final minutes = timeDuration.inMinutes.remainder(60);
    // final seconds = timeDuration.inSeconds.remainder(60) % 60;

    final hours = Duration(milliseconds: timeDuration).inHours.remainder(60);
    final minutes = Duration(milliseconds: timeDuration).inMinutes.remainder(60);
    final seconds = Duration(milliseconds: timeDuration).inSeconds.remainder(60) % 60;

    if (hours != 0) {
      readableDuration = "$hours${hours > 1 ? "hrs" : "hr"}";
    }

    if (minutes != 0) {
      readableDuration = "$readableDuration $minutes${minutes > 1 ? "mins" : "min"}";
    }

    if (seconds != 0) {
      readableDuration = "$readableDuration $seconds${seconds > 1 ? "secs" : "sec"}";
    }

    return readableDuration.trim();
  }
}
