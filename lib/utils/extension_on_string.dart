
extension StringExtension on String {
  String sentenceCapitalization() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  String capitalizeFirstOfEach() {
    return split(" ")
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(" ");
  }

  String firstTwoLettersOfFullNameToUpperCase() {
    return split(" ").map((letter) => letter[0].toUpperCase()).join("");
  }

  String formatStringTime() {
    var time = '';
    var timeSplit = split(':');
    var hour = int.parse(timeSplit[0]);
    if (hour < 12) {
      time = '$hour:${timeSplit[1]}AM';
    } else if (hour == 12) {
      time = '$hour:${timeSplit[1]}PM';
    } else {
      time = '${hour % 12}:${timeSplit[1]}PM';
    }
    return time;
  }
}
