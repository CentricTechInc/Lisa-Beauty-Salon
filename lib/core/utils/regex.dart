class RegularExpressions {
  /// Email validation
  static RegExp emailRegex = RegExp(
    r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$',
  );

  /// Password validation (your existing requirement)
  static RegExp passwordRegex = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*#?&]{8,}$',
  );

  /// Verse lookup pattern (your existing one)
  static RegExp versesByChapterRegex = RegExp(
    r'^(\d+)\s*[:.]\s*(\d+)$',
  );

  /// Text with number (your existing one)
  static RegExp textWithNumberRegex = RegExp(
    r'^([a-zA-Z]+(-|_)?([0-9]+(\.[0-9]+)?))$',
  );

  /// Text only (alphabets + spaces)
  static RegExp textOnlyRegex = RegExp(
    r'^([a-zA-Z ])+$',
  );

  /// Test With Dashes
  static RegExp textWithDashesAndSpaceRegex = RegExp(
    r'^[A-Za-z\- ]+$',
    caseSensitive: false,
  );

  /// Only numbers (integer)
  static RegExp onlyNumbersRegex = RegExp(
    r'^[0-9]+$',
  );

  /// Salary limit numeric check (same as numbers only)
  static RegExp salaryNumberRegex = RegExp(
    r'^[0-9]+$',
  );

  /// Number with decimal
  static RegExp numberWithDecimalRegex = RegExp(
    r'^[0-9]+(\.[0-9]+)?$',
  );

  /// Number with optional dashes (e.g. 123-456-789)
  static RegExp numberWithDashesRegex = RegExp(
    r'^([0-9]+-?)+$',
  );

  /// Strong password pattern
  static RegExp strongPasswordRegex = RegExp(
    r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)',
  );

  /// Phone number (supports +1, +971, +92 etc.)
  static RegExp phoneRegex = RegExp(
    r'^\+?(1|971|92)?[-.\s]?\(?\d{2,3}\)?[-.\s]?\d{3,4}[-.\s]?\d{4}$',
  );

  /// Number + alphabets only
  static RegExp numberAndAlphabetRegex = RegExp(
    r'^[0-9]*[A-Za-z]\w+$',
  );

  /// VIN pattern (17 chars, excludes O, I, Q)
  static RegExp vinRegex = RegExp(
    r'^[A-HJ-NPR-Z0-9]{17}$',
    caseSensitive: false,
  );

  /// ZIP/Postal validation (US ZIP + Canada postal)
  static RegExp zipCodeRegex = RegExp(
    r'^\d{4}$',
    caseSensitive: false,
  );


}
