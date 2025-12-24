import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/app/mixins/validations.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_scaffold_widget.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text_field.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_button.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_checkbox.dart';
import 'package:intl/intl.dart';

class CardExpiryInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      if (text[i] != '/') {
        buffer.write(text[i]);
      }
      var nonZeroIndex = buffer.length;
      if (nonZeroIndex % 2 == 0 && nonZeroIndex != 0 && i != text.length - 1 && !text.contains('/', i)) {
        if (nonZeroIndex <= 2) {
          buffer.write('/');
        }
      }
    }

    var string = buffer.toString();
    
    // Limit to 5 characters (MM/YY)
    if (string.length > 5) {
      string = string.substring(0, 5);
    }

    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}

class CustomerAddPaymentMethodPage extends StatefulWidget {
  const CustomerAddPaymentMethodPage({super.key});

  @override
  State<CustomerAddPaymentMethodPage> createState() => _CustomerAddPaymentMethodPageState();
}

class _CustomerAddPaymentMethodPageState extends State<CustomerAddPaymentMethodPage> with FieldsValidation {

  final _formkey = GlobalKey<FormState>();

  final _cardNumberController = TextEditingController();
  final _cardHolderController = TextEditingController();
  final _expDateController = TextEditingController();
  final _cvvController = TextEditingController();
  bool _isDefault = true;


  @override
  Widget build(BuildContext context) {
    return CommonScaffoldWidget(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 25
      ),
      systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: AppColors.whiteTwo,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      bgColor: AppColors.whiteTwo,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const VerticalSpacing(20),
                    _buildTextField(
                      "Card Number",
                      _cardNumberController,
                      hint: "4950 4545 1234 9876",
                      validator: validateOnlyIntNumber,
                      inputType: TextInputType.number,
                    ),
                    const VerticalSpacing(20),
                    _buildTextField(
                      "Card Holder",
                      _cardHolderController,
                      hint: "Eleanor",
                      validator: validateTextOnly,
                    ),
                    const VerticalSpacing(20),
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            "Exp. Date",
                            _expDateController,
                            hint: "MM/YY",
                            validator: validateExpiryDate,
                            inputFormatter: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(4),
                              CardExpiryInputFormatter(),
                            ],
                            inputType: TextInputType.number,
                            suffix: Icon(Icons.calendar_today,
                                size: 18, color: AppColors.greyOne),
                            suffixIconOnTap: () => _selectExpiryDate(context),
                            textOnTap: () => _selectExpiryDate(context),
                          ),
                        ),
                        const HorizontalSpacing(16),
                        Expanded(
                          child: _buildTextField(
                            "CVV",
                            _cvvController,
                            hint: "000",
                            inputType: TextInputType.number,
                            inputFormatter: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(3),
                            ],
                            validator: validateOnlyIntNumber,
                          ),
                        ),
                      ],
                    ),
                    const VerticalSpacing(18),
                    CommonCheckbox(
                      value: _isDefault,
                      onChanged: (value) => setState(() => _isDefault = value!),
                      label: "Set as your default payment method",
                      labelFontSize: 16,
                      labelFontWeight: 500,
                      labelColor: AppColors.blackTwo,
                      activeColor: AppColors.pinkTwo,
                      borderColor: AppColors.greyOne,
                    ),
                    const VerticalSpacing(32),
                  ],
                ),
              ),
            ),
          ),
          CommonButton(
            onPressed: () {
              if (_formkey.currentState!.validate()) {
                Get.back();
              }
            },
            text: "Add",
            width: double.infinity,
            backgroundColor: AppColors.pinkTwo,
          ),
          const VerticalSpacing(40)
        ],
      ),
    );
  }

  void _selectExpiryDate(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: MediaQuery.of(context).size.height / 3,
          color: Colors.white,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                    child: const Text('Cancel'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  CupertinoButton(
                    child: const Text('Done'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.monthYear,
                  onDateTimeChanged: (DateTime value) {
                    setState(() {
                      _expDateController.text =
                          DateFormat('MM/yy').format(value);
                    });
                  },
                  initialDateTime: DateTime.now(),
                  minimumYear: DateTime.now().year,
                  maximumYear: 2050,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    String? hint,
    List<TextInputFormatter>? inputFormatter,
    TextInputType? inputType,
    Widget? suffix,
    VoidCallback? suffixIconOnTap,
    VoidCallback? textOnTap,
    String? Function(String?)? validator,
    bool readOnly = false,
  }) {
    return CommonTextField(
      controller: controller,
      titleLabelText: label,
      hintText: hint ?? "Enter $label",
      labelText: hint ?? "Enter $label",
      fillColor: AppColors.whiteOne,
      textColor: AppColors.blackTwo,
      cursorColor: AppColors.blackTwo,
      borderColor: AppColors.greyOne,
      borderRadius: 12,
      inputFormatter: inputFormatter,
      inputType: inputType ?? TextInputType.text,
      suffix: suffix,
      suffixIconOnTap: suffixIconOnTap,
      textOnTap: textOnTap,
      readOnly: readOnly,
      validator: validator,
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
                color: AppColors.whiteOne,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.greyOne)),
            child: Center(
              child: Icon(
                CupertinoIcons.chevron_back,
                color: AppColors.blackTwo,
              ),
            ),
          ),
        ),
        HorizontalSpacing(15),
        const CommonText(
          "Add Payment Method",
          fontSize: 24,
          fontWeight: 600,
          color: AppColors.blackTwo,
        ),
      ],
    );
  }
}
