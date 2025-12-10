import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
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

class BuildYourProfilePageOneState extends State<BuildYourProfilePageOne> {

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
                    labelSize: 15,
                    labelColor: AppColors.greyTwo,
                    hintText: Strings.firstNamePlaceholderText,
                    hintSize: 15,
                    hintColor: AppColors.greyTwo,
                  ),
                ),
                HorizontalSpacing(10),
                Expanded(
                  child: CommonTextField(
                    titleLabelText: Strings.lastNameText,
                    controller: firstNameController,
                    labelText: Strings.lastNamePlaceholderText,
                    labelSize: 15,
                    labelColor: AppColors.greyTwo,
                    hintText: Strings.lastNamePlaceholderText,
                    hintSize: 15,
                    hintColor: AppColors.greyTwo,
                  ),
                ),
              ],
            ),
            VerticalSpacing(10),
            CommonTextField(
              titleLabelText: Strings.ageText,
              controller: ageController,
              labelText: Strings.agePlaceholderText,
              labelSize: 15,
              labelColor: AppColors.greyTwo,
              hintText: Strings.agePlaceholderText,
              hintSize: 15,
              hintColor: AppColors.greyTwo,
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
              )
              ).toList(),
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
              cursorColor: AppColors.blackTwo,
              initialValue: PhoneNumber(isoCode: 'ZA'),
              spaceBetweenSelectorAndTextField: 0,
              selectorConfig: SelectorConfig(
                  selectorType: PhoneInputSelectorType.BOTTOM_SHEET
              ),
              onInputChanged: (value) {
                LoggerService.info("mobileNumberController.text ${mobileNumberController.text}");
              },
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
              controller: streetAddressController,
              labelText: Strings.businessNamePlaceholderText,
              labelSize: 15,
              labelColor: AppColors.greyTwo,
              hintText: Strings.businessNamePlaceholderText,
              hintSize: 15,
              hintColor: AppColors.greyTwo,
            ),
            VerticalSpacing(20),
            CommonTextField(
              titleLabelText: Strings.streetAddressText,
              controller: streetAddressController,
              labelText: Strings.streetAddressPlaceholderText,
              labelSize: 15,
              labelColor: AppColors.greyTwo,
              hintText: Strings.streetAddressPlaceholderText,
              hintSize: 15,
              hintColor: AppColors.greyTwo,
            ),
            VerticalSpacing(20),
            CommonDropdownField(
              titleLabelText: Strings.stateText,
              items: (authController.countryDataOfUs?.states ?? []).map(
                      (state) => DropdownMenuItem(
                    value: state,
                    child: CommonText(
                      state.name,
                      fontSize: 15,
                      color: AppColors.greyTwo,
                    ),
                  )
              ).toList(),
              onChanged: (value) {
                stateController.text = value?.name ?? '';
                authController.setCitiesAccordingToState(
                    stateController.text
                );
                cityController.text = '';
              },
            ),
            VerticalSpacing(20),
            Obx(() {
              final cities = authController.citiesList;
              final isDisabled = cities.isEmpty;

              return CommonDropdownField<int>(
                titleLabelText: Strings.cityText,
                value: cityController.text.isEmpty ? null :
                cities.indexWhere((c) => c.name == cityController.text) >= 0
                    ? cities.indexWhere((c) => c.name == cityController.text)
                    : null,
                items: isDisabled ? <DropdownMenuItem<int>>[]
                    : cities.asMap().entries.map((entry) {
                  final index = entry.key;
                  final city = entry.value;
                  return DropdownMenuItem(
                    value: index, // Always unique
                    child: CommonText(
                      city.name,
                      fontSize: 15,
                      color: AppColors.greyTwo,
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  if (isDisabled == false && value != null && value >= 0 && value < cities.length) {
                    cityController.text = cities[value].name;
                  }
                },
                hintText: isDisabled ? 'No cities available' : 'Select City',
              );
            }),
            VerticalSpacing(20),
            CommonTextField(
              titleLabelText: Strings.zipCodeText,
              controller: zipCodeController,
              labelText: Strings.zipCodePlaceholderText,
              labelSize: 15,
              labelColor: AppColors.greyTwo,
              hintText: Strings.zipCodePlaceholderText,
              hintSize: 15,
              hintColor: AppColors.greyTwo,
            ),
            VerticalSpacing(20),
            CommonButton(
              text: Strings.continueText,
              backgroundColor: AppColors.pinkTwo,
              onPressed: () {
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
              },
            )
          ],
        ),
      ),
    );
  }
}