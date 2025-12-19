import 'package:intl/intl.dart';
import 'package:lisa_beauty_salon/core/utils/regex.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';

mixin FieldsValidation {
  String? dateValidation(String startDateString, DateTime endDate) {
    final parts = startDateString.split('-');
    DateTime startDate = DateTime(
      int.parse(parts[2]),
      int.parse(parts[1]),
      int.parse(parts[0]),
    );
    if (endDate.isAfter(startDate)) {
      return DateFormat('yyyy-MM-dd').format(endDate);
    } else {
      return "To date should be greater than or equal to from date.";
    }
  }

  String? dateReminderValidation(String startDateString, DateTime endDate) {
    final parts = startDateString.split('-');
    DateTime startDate = DateTime(
      int.parse(parts[2]),
      int.parse(parts[1]),
      int.parse(parts[0]),
    );
    if (endDate.isAfter(startDate)) {
      return DateFormat('yyyy-MM-dd').format(endDate);
    } else {
      return "End date should be greater than start date";
    }
  }

  String? validateTextWithNumber(String? value) {
    if (value == null || value.isEmpty) {
      return "Required*";
    }
    if (!RegularExpressions.textWithNumberRegex.hasMatch(value)) {
      return "Invalid Input";
    }
    return null;
  }

  String? validateBusinessName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Required*";
    }
    if (!RegularExpressions.businessNameRegex.hasMatch(value.trim())) {
      return "Invalid business name";
    }
    return null;
  }

  String? validateTextOnly(String? value) {
    if (value == null || value.isEmpty) {
      return "Required*";
    }
    if (!RegularExpressions.textOnlyRegex.hasMatch(value)) {
      return "Invalid Input";
    }
    return null;
  }

  String? validateTextNotEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return "Required*";
    }
    return null;
  }

  String? validateTextWithDashes(String? value) {
    if (value == null || value.isEmpty) {
      return "Required*";
    }
    if (!RegularExpressions.textWithDashesAndSpaceRegex.hasMatch(value)) {
      return "Invalid Input";
    }
    return null;
  }

  String? validateEmailSimple(String? email) {
    if (email == null || email.isEmpty) {
      return Strings.pleaseEnterYourEmailText;
    }
    return null;
  }

  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return Strings.pleaseEnterYourEmailText;
    }
    if (!RegularExpressions.emailRegex.hasMatch(email)) {
      return Strings.pleaseMakeSureYourEmailIsInCorrectFormat;
    }
    return null;
  }

  String? validatePasswordSimple(String? password) {
    if (password == null || password.isEmpty) {
      return Strings.pleaseEnterYourPasswordText;
    }
    return null;
  }

  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return Strings.pleaseEnterYourPasswordText;
    }
    if (!RegularExpressions.passwordRegex.hasMatch(password)) {
      return Strings.passwordRequirementsText;
    }
    return null;
  }

  String? validateConfirmPassword(String? password, String? confirmPassword) {
    if (password == null || password.isEmpty) {
      return Strings.pleaseEnterYourPasswordText;
    }
    if (!RegularExpressions.passwordRegex.hasMatch(password)) {
      return Strings.passwordRequirementsText;
    }
    if (password != confirmPassword) {
      return Strings.passwordAndConfirmPasswordNotText;
    }
    return null;
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return Strings.pleaseEnterYourName;
    }
    return null;
  }

  String? validateDateOfBirth(String? value) {
    if (value == null || value.isEmpty) {
      return Strings.pleaseEnterYourDateOfBirth;
    }
    return null;
  }

  String? validateNonMandatoryTextOnly(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    if (!RegularExpressions.textOnlyRegex.hasMatch(value)) {
      return "Invalid Input";
    }
    return null;
  }

  String? validateNonMandatoryNumberOnly(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    if (!RegularExpressions.onlyNumbersRegex.hasMatch(value)) {
      return "Invalid Input please enter numbers only";
    }
    return null;
  }

  String? validateOnlyIntNumber(String? value) {
    if (value == null || value.isEmpty) {
      return "Required*";
    }
    if (!RegularExpressions.onlyNumbersRegex.hasMatch(value)) {
      return "Invalid Input";
    }
    return null;
  }

  String? salaryLimit(String? value) {
    if (value == null || value.isEmpty) {
      return "Required*";
    }
    if (!RegularExpressions.salaryNumberRegex.hasMatch(value)) {
      return "Invalid Input";
    }
    if (int.parse(value) < 5000) {
      return "value should be greater than starting range ";
    }
    return null;
  }

  String? validateOnlyNumberWithDecimal(String? value) {
    if (value == null || value.isEmpty) {
      return "Required*";
    }
    if (!RegularExpressions.numberWithDecimalRegex.hasMatch(value)) {
      return "Invalid Input";
    }
    return null;
  }

  String? validateNumberWithDashes(String? value) {
    if (value == null || value.isEmpty) {
      return "Required*";
    }
    // avoid trailing dash
    if (value.endsWith('-')) {
      return "Invalid Input";
    }
    if (!RegularExpressions.numberWithDashesRegex.hasMatch(value)) {
      return "Invalid Input";
    }
    return null;
  }

  String? passwordValidation(String? value) {
    if (value == null || value.isEmpty) {
      return "Required*";
    }
    if (!RegularExpressions.strongPasswordRegex.hasMatch(value)) {
      return "Hint: Aabc@123";
    }
    if (value.length < 8) {
      return "Password must be at least 8 characters long";
    }
    if (value.length > 12) {
      return "Password must be at most 12 characters long";
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return "Required*";
    }
    if (!RegularExpressions.phoneRegex.hasMatch(value)) {
      return "Invalid Phone Number";
    }
    return null;
  }

  String? emptyFieldValidation(String? value) {
    if (value == null) {
      return "Required*";
    }
    final text = value.trim();
    if (text.isEmpty || value.startsWith(' ')) {
      return "Required*";
    }
    return null;
  }

  String? matchPass(String? value, String? value2) {
    if (value == null || value.isEmpty) {
      return "Required*";
    }
    if (value != value2) {
      return "*password does not match";
    }
    return null;
  }

  String? validateNumberAndAlphabetsOnly(String? value) {
    if (value == null || value.isEmpty) {
      return "Required*";
    }
    if (!RegularExpressions.numberAndAlphabetRegex.hasMatch(value)) {
      return "Invalid Input";
    }
    return null;
  }

  String? validateTextOnlyDropdown<T>(T? value) {
    if (value == null || value.toString().isEmpty) {
      return "Required*";
    }
    if (value == '') {
      return "is Empty*";
    }
    return null;
  }

  String? validateVin(String? vin) {
    if (vin == null || vin.isEmpty) {
      return "Required*";
    }
    if (vin.length != 17) {
      return "VIN must be exactly 17 characters";
    }
    if (!RegularExpressions.vinRegex.hasMatch(vin)) {
      return "Invalid Input";
    }
    return null;
  }

  String? zipCodeOptionalValidation(String? zipCode) {
    if (zipCode == null || zipCode.isEmpty) {
      return null;
    }
    if (!RegularExpressions.fourDigitCodeRegex.hasMatch(zipCode)) {
      return "Zip/Postal code invalid!";
    }
    return null;
  }

  String? validateZipCode(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Zip code is required';
    }

    final zipRegex = RegularExpressions.fourDigitCodeRegex;

    if (!zipRegex.hasMatch(value.trim())) {
      return 'Enter a valid zip/postal code';
    }

    return null;
  }

  String? validateOtpCode(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Otp Code is required';
    }

    final otpCode = RegularExpressions.fourDigitCodeRegex;

    if (!otpCode.hasMatch(value.trim())) {
      return 'Enter a valid OTP code';
    }

    return null;
  }

  String? validatePrice(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Price is required';
    }
    final sanitized = value.replaceAll(' ', '').replaceAll('R', '');
    if (double.tryParse(sanitized) == null) {
      return 'Enter a valid price';
    }
    return null;
  }

  String? validateAccountNumber(String? value) {
    if (value == null || value.isEmpty) {
      return "Required*";
    }
    if (!RegularExpressions.textWithNumberRegex.hasMatch(value)) {
      return "Invalid Input";
    }
    return null;
  }

  String? validateConfirmAccountNumber(String? accountNumber, confirmAccountNumber) {
    if (accountNumber == null || accountNumber.isEmpty) {
      return "Required*";
    }
    if (!RegularExpressions.textWithNumberRegex.hasMatch(accountNumber)) {
      return "Invalid Input";
    }
    if (accountNumber != confirmAccountNumber) {
      return 'Account Number and Confirm Account Number not matched';
    }
    return null;
  }

  String? validateListNotEmpty<T>(List<T>? value) {
    if (value == null || value.isEmpty) {
      return "Required*";
    }
    return null;
  }
}
