import 'package:flutter/services.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  final String currencySymbol;

  CurrencyInputFormatter({this.currencySymbol = 'R '});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    String newText = newValue.text;

    String value = newText.replaceAll(RegExp(r'[^\d.]'), '');

    if (!newText.startsWith(currencySymbol)) {
      newText = currencySymbol + value;
    } else if (newText.length < currencySymbol.length) {
      newText = currencySymbol;
    }

    int prefixLength = currencySymbol.length;
    int selectionIndex = newValue.selection.end > prefixLength
        ? newValue.selection.end
        : prefixLength;

    if (selectionIndex > newText.length) {
      selectionIndex = newText.length;
    }

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}