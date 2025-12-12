import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:lisa_beauty_salon/app/mixins/validations.dart';
import 'package:lisa_beauty_salon/core/constants/app_constants.dart';
import 'package:lisa_beauty_salon/core/services/logger_service.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/features/auth/presentation/controllers/auth_controller.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_button.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_dropdown_field.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text_field.dart';

class BuildYourProfilePageOne extends StatefulWidget {
  const BuildYourProfilePageOne({
    required this.pageController,
    super.key,
  });

  final PageController pageController;

  @override
  State<BuildYourProfilePageOne> createState() => BuildYourProfilePageOneState();
}

class BuildYourProfilePageOneState extends State<BuildYourProfilePageOne> with FieldsValidation {

  final _formKey = GlobalKey<FormState>();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final ageController = TextEditingController();
  final genderController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final businessNameController = TextEditingController();
  final streetAddressController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final zipCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 20
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: CommonTextField(
                      titleLabelText: Strings.firstNameText,
                      controller: firstNameController,
                      labelText: Strings.firstNamePlaceholderText,
                      hintText: Strings.firstNamePlaceholderText,
                      labelSize: 15,
                      hintSize: 15,
                      labelColor: AppColors.greyTwo,
                      hintColor: AppColors.greyTwo,
                      textColor: AppColors.blackTwo,
                      cursorColor: AppColors.blackTwo,
                      validator: validateName,
                    ),
                  ),
                  HorizontalSpacing(10),
                  Expanded(
                    child: CommonTextField(
                      titleLabelText: Strings.lastNameText,
                      controller: lastNameController,
                      labelText: Strings.lastNamePlaceholderText,
                      hintText: Strings.lastNamePlaceholderText,
                      labelSize: 15,
                      hintSize: 15,
                      labelColor: AppColors.greyTwo,
                      hintColor: AppColors.greyTwo,
                      textColor: AppColors.blackTwo,
                      cursorColor: AppColors.blackTwo,
                      validator: validateName,
                    ),
                  ),
                ],
              ),
              VerticalSpacing(10),
              CommonTextField(
                titleLabelText: Strings.ageText,
                controller: ageController,
                labelText: Strings.agePlaceholderText,
                hintText: Strings.agePlaceholderText,
                labelSize: 15,
                hintSize: 15,
                labelColor: AppColors.greyTwo,
                hintColor: AppColors.greyTwo,
                textColor: AppColors.blackTwo,
                cursorColor: AppColors.blackTwo,
                validator: validateOnlyIntNumber,
              ),
              VerticalSpacing(10),
              CommonDropdownField(
                titleLabelText: Strings.genderText,
                items: [
                  Strings.otherText,
                  Strings.maleText,
                  Strings.femaleText
                ].map((value) => DropdownMenuItem(
                  value: value,
                  child: CommonText(
                    value,
                    fontSize: 15,
                    color: AppColors.greyTwo,
                  ),
                )).toList(),
                onChanged: (value) {
                  genderController.text = value ?? '';
                },
              ),
              VerticalSpacing(20),
              CommonText(
                Strings.mobileNumberText,
                fontSize: 12,
                fontWeight: 400,
                color: AppColors.blackTwo,
              ),
              VerticalSpacing(5),
              InternationalPhoneNumberInput(
                textFieldController: mobileNumberController,
                inputDecoration: InputDecoration(
                  labelText: Strings.mobileNumberPlaceholderText,
                  hintText: Strings.mobileNumberPlaceholderText,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: AppConstants.dropdownBorder,
                  focusedBorder: AppConstants.dropdownBorder,
                  errorBorder: AppConstants.dropdownBorder,
                  enabledBorder: AppConstants.dropdownBorder,
                  disabledBorder: AppConstants.dropdownBorder,
                ),
                formatInput: false,
                keyboardType: TextInputType.number,
                textStyle: TextStyle(
                  color: AppColors.blackTwo,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
                cursorColor: AppColors.blackTwo,
                initialValue: PhoneNumber(isoCode: 'ZA'),
                spaceBetweenSelectorAndTextField: 0,
                selectorConfig: SelectorConfig(
                    selectorType: PhoneInputSelectorType.BOTTOM_SHEET
                ),
                onInputChanged: (value) {
                  LoggerService.info("mobileNumberController.text ${mobileNumberController.text}");
                },
                validator: validateTextNotEmpty,
              ),
              VerticalSpacing(30),
              CommonText(
                Strings.businessAddressText,
                fontSize: 16,
                fontWeight: 700,
                color: AppColors.blackTwo,
              ),
              VerticalSpacing(20),
              CommonTextField(
                titleLabelText: Strings.businessNameText,
                controller: businessNameController,
                labelText: Strings.businessNamePlaceholderText,
                hintText: Strings.businessNamePlaceholderText,
                labelSize: 15,
                hintSize: 15,
                labelColor: AppColors.greyTwo,
                hintColor: AppColors.greyTwo,
                textColor: AppColors.blackTwo,
                validator: validateBusinessName,
              ),
              VerticalSpacing(20),
              CommonTextField(
                titleLabelText: Strings.streetAddressText,
                controller: streetAddressController,
                labelText: Strings.streetAddressPlaceholderText,
                hintText: Strings.streetAddressPlaceholderText,
                labelSize: 15,
                hintSize: 15,
                labelColor: AppColors.greyTwo,
                hintColor: AppColors.greyTwo,
                textColor: AppColors.blackTwo,
                cursorColor: AppColors.blackTwo,
                validator: validateTextNotEmpty,
              ),
              VerticalSpacing(20),
              CommonDropdownField(
                titleLabelText: Strings.stateText,
                items: (authController.countryDataOfUs?.states ??
                  []).map(
                    (state) => DropdownMenuItem(
                      value: state,
                      child: CommonText(
                        state.name,
                        fontSize: 15,
                        color: AppColors.greyTwo,
                      ),
                    )
                ).toList(),
                validator: (value) => validateTextWithDashes(value?.name),
                onChanged: (value) {
                  stateController.text = value?.name ?? '';
                  authController.setCitiesAccordingToState(
                    stateController.text,
                    Strings.buildYourProfileDropdownScenario,
                  );
                },
              ),
              VerticalSpacing(20),
              Obx(() {
                final cities = authController.citiesList;
                final selectedIndex = cities.indexWhere(
                  (c) => c.name == authController.selectedCityForBuildYourProfile.value,
                );
                final int? safeIndex = selectedIndex >= 0 ? selectedIndex : null;

                return CommonDropdownField<int>(
                  titleLabelText: Strings.cityText,
                  value: safeIndex,
                  items: cities.asMap().entries.map((entry) {
                    final index = entry.key;
                    final city = entry.value;
                    return DropdownMenuItem(
                      value: index,
                      child: CommonText(
                        city.name,
                        fontSize: 15,
                        color: AppColors.greyTwo,
                      ),
                    );
                  }).toList(),
                  validator: (value) {
                    String cityName = '';
                    if ((value != null && value >= 0 && value < cities.length)) {
                      cityName = authController.selectedCityForBuildYourProfile.value = cities[value].name;
                      return validateTextOnly(cityName);
                    }
                    else {
                      return validateTextOnly(cityName);
                    }
                  },
                  onChanged: (value) {
                    if (value != null && value >= 0 && value < cities.length) {
                      authController.selectedCityForBuildYourProfile.value = cities[value].name;
                    } else {
                      authController.selectedCityForBuildYourProfile.value = '';
                    }
                  },
                  hintText: cities.isEmpty ? 'No cities available' : 'Select City',
                );
              }),
              VerticalSpacing(20),
              CommonTextField(
                titleLabelText: Strings.zipCodeText,
                controller: zipCodeController,
                labelText: Strings.zipCodePlaceholderText,
                hintText: Strings.zipCodePlaceholderText,
                labelSize: 15,
                hintSize: 15,
                labelColor: AppColors.greyTwo,
                hintColor: AppColors.greyTwo,
                textColor: AppColors.blackTwo,
                cursorColor: AppColors.blackTwo,
                validator: validateZipCode,
              ),
              VerticalSpacing(20),
              CommonButton(
                text: Strings.continueText,
                backgroundColor: AppColors.pinkTwo,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    authController.setBasicProfileData(
                        firstName: firstNameController.text,
                        lastName: lastNameController.text,
                        age: ageController.text,
                        gender: genderController.text,
                        phoneNumber: mobileNumberController.text
                    );

                    widget.pageController.animateToPage(
                        1,
                        duration: Duration(milliseconds: 50),
                        curve: Curves.easeInOut
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}