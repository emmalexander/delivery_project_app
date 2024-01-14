class PhoneNumberHelper {
  /// This method is responsible for processing inputted phone number, appending
  /// the country code to the phone number and removing starting "0" is any from
  /// the phone number
  static String processPhoneNumber({
    required String countryCode,
    required String phoneNumber,
  }) {
    countryCode.trim();
    phoneNumber.trim();
    if (phoneNumber[0] == "0") {
      return "$countryCode${phoneNumber.substring(1)}";
    }

    return "$countryCode$phoneNumber";
  }
}
