RegExp thirdNumberCommaPattern = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
String mathFunc(Match match) => '${match[1]},';

String getShortForm(int number) {
  if (number < 1000) {
    return number.toString(); // Return the number as is if it's less than 1000
  } else if (number < 1000000) {
    double shortNumber = number / 1000; // Convert to thousands
    return '${shortNumber.toStringAsFixed(0)}K'; // Format to no decimal places and append 'k'
  } else {
    double shortNumber = number / 1000000; // Convert to millions
    return '${shortNumber.toStringAsFixed(0)}M'; // Format to no decimal places and append 'M'
  }
}
