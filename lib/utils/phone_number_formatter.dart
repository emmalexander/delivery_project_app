import 'package:flutter/services.dart';

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Replace characters not allowed with an empty string
    final cleanedText = newValue.text.replaceAll(RegExp(r'[()\sN;,.#+*-]'), '');

    return TextEditingValue(
      text: cleanedText,
      selection: TextSelection.collapsed(offset: cleanedText.length),
    );
  }
}
