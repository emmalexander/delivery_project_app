import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Validators {
  static String? validateFirstname(String? firstname, BuildContext context) {
    firstname = firstname?.trim();

    if (firstname == null || firstname == "") {
      return 'First Name cannot be empty';
    }

    if (firstname.length == 1) {
      return 'Mininmum of two (2) alphabetic characters';
    }

    RegExp _regExp = RegExp('[a-zA-Z0-9]');
    if (!_regExp.hasMatch(firstname)) {
      return 'Number is not allow';
    }
    return null;
  }

  static String? validateLastname(String? lastname, BuildContext context) {
    lastname = lastname?.trim();

    if (lastname == null || lastname == "") {
      return 'Last Name cannot be empty';
    }

    if (lastname.length == 1) {
      return 'Mininmum of two (2) alphabetic characters';
    }

    RegExp _regExp = RegExp('[a-zA-Z0-9]');
    if (!_regExp.hasMatch(lastname)) {
      return 'Number is not allow';
    }
    return null;
  }

  static String? validateEmail(String? email, BuildContext context) {
    email = email?.trim();

    if (email == null || email == "") {
      return 'Email cannot be empty';
    }

    if (!_emailRegExp.hasMatch(email)) {
      return 'Enter correct email address format e.g \nab@gmail.com';
    }
    return null;
  }

  static String? validateRef(String? refCode, BuildContext context) {
    refCode = refCode?.trim();

    if (!validCharacters.hasMatch(refCode!)) {
      return 'Input the Correct Referral code';
    }
    return null;
  }

  static String? validatePhone(
      String? phone, bool? isReg, BuildContext context) {
    phone = phone?.trim();
    // isReg = true;

    if (phone == null || phone == "") {
      return 'Phone Number cannot be empty';
    }

    if (phone.length != 11) {
      return isReg!
          ? 'Enter a valid 11 digits phone number'
          : 'Maximum of eleven (11) digits  e.g 080 324 567 22';
    }
    return null;
  }

  static String? validatePhoneNumber(String? phone) {
    phone = phone?.trim();
    // isReg = true;

    String pattern = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(phone!)) {
      return 'Must be 11 digits \nSpecial characters not allowed';
    } else if (phone.length < 11) {
      return 'Must be 11 digits \nSpecial characters not allowed';
    } else {
      return null;
    }
  }

  static String? validatePassword(String? password, BuildContext context) {
    password = password?.trim();

    if (password == null || password == "") {
      return 'Password cannot be empty';
    }

    if (password.length < 8) {
      return 'Password must be greater than 8';
    }

    return null;
  }

  /// Check if password and confirm password matches.
  static String? isMatched(
    String? password,
    String? confirmPassword,
    BuildContext context,
  ) {
    password = password?.trim();
    confirmPassword = confirmPassword?.trim();

    if (confirmPassword == null || confirmPassword == "") {
      return '';
    }

    if (password != confirmPassword) {
      return 'Password Does not match!';
    }
    return null;
  }

  static bool containsOnlyNumber(String? value) {
    if (value == null) {
      return false;
    }

    return _containsOnlyNumbers.hasMatch(value);
  }

  static final RegExp _emailRegExp = RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
  );

  static final RegExp _oneUpperCaseRegExp = RegExp(
    r"^(?=.*?[A-Z])",
  );

  static final RegExp _oneLowerCaseRegExp = RegExp(
    r"(?=.*?[a-z])",
  );

  static final RegExp _oneNumberRegExp = RegExp(
    r"(?=.*?[0-9])",
  );

  static final RegExp _oneSpecialCharacterRegExp = RegExp(
    r"(?=.*?[#?!@$%^&*-])",
  );

  static final RegExp _containsOnlyNumbers = RegExp(r"(^[0-9]+$)");

  static final validCharacters = RegExp(r'^[a-zA-Z0-9]+$');

  /// 8 characters, 1 uppercase, 1 number and 1 special character
  static final RegExp _passwordRegExp = RegExp(
    r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@\$!%*?&])[A-Za-z\d@\$!%*?&]{8,}\$",
  );

  static _isPasswordValid(String password) {
    return _passwordRegExp.hasMatch(password);
  }

  static _isEmailValid(String email) {
    return _emailRegExp.hasMatch(email);
  }

  static _hasUpperCase(String password) {
    return _oneUpperCaseRegExp.hasMatch(password);
  }

  static _hasLowerCase(String password) {
    return _oneLowerCaseRegExp.hasMatch(password);
  }

  static _hasNumber(String password) {
    return _oneNumberRegExp.hasMatch(password);
  }

  static _hasSpecialCharacter(String password) {
    return _oneSpecialCharacterRegExp.hasMatch(password);
  }
}
