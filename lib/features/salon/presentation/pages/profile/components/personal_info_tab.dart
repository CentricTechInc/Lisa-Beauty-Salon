import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:lisa_beauty_salon/app/mixins/validations.dart';
import 'package:lisa_beauty_salon/core/constants/app_constants.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/features/auth/presentation/controllers/auth_controller.dart';
import 'package:lisa_beauty_salon/features/salon/presentation/pages/build_your_profile/components/profile_photo_picker_component.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_button.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_dropdown_field.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text_field.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:lisa_beauty_salon/core/services/logger_service.dart';

class PersonalInfoTab extends StatefulWidget {
  const PersonalInfoTab({super.key});

  @override
  State<PersonalInfoTab> createState() => _PersonalInfoTabState();
}

class _PersonalInfoTabState extends State<PersonalInfoTab>
    with FieldsValidation {
  final _formKey = GlobalKey<FormState>();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final ageController = TextEditingController();
  final genderController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final businessNameController = TextEditingController();
  final streetAddressController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final zipCodeController = TextEditingController();

  final photoNotifier = ValueNotifier<String?>(null);

  Future<File?> pickImageFromGallery() async {
    try {
      final picker = ImagePicker();

      final picked = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (picked == null) {
        return null;
      }

      return File(picked.path);
    } catch (e) {
      LoggerService.info("Image pick error: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    final genders = [Strings.maleText, Strings.femaleText, Strings.otherText];

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ValueListenableBuilder(
                valueListenable: photoNotifier,
                builder: (context, path, _) {
                  return PhotoPickerComponent(
                    imagePath: path,
                    onTap: () async {
                      final file = await pickImageFromGallery();
                      if (file != null) {
                        photoNotifier.value = file.path;
                      }
                    },
                  );
                },
              ),
            ),
            VerticalSpacing(20),
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
            VerticalSpacing(20),
            CommonTextField(
              titleLabelText: Strings.emailText,
              controller: emailController,
              labelText: Strings.emailPlaceholderText,
              hintText: Strings.emailPlaceholderText,
              labelSize: 15,
              hintSize: 15,
              labelColor: AppColors.greyTwo,
              hintColor: AppColors.greyTwo,
              textColor: AppColors.blackTwo,
              cursorColor: AppColors.blackTwo,
              validator: validateEmail,
            ),
            VerticalSpacing(20),
            Row(
              children: [
                Expanded(
                  child: CommonTextField(
                    titleLabelText: Strings.ageText,
                    controller: ageController,
                    labelText: "25",
                    hintText: "25",
                    labelSize: 15,
                    hintSize: 15,
                    labelColor: AppColors.greyTwo,
                    hintColor: AppColors.greyTwo,
                    textColor: AppColors.blackTwo,
                    cursorColor: AppColors.blackTwo,
                    inputType: TextInputType.number,
                    validator: validateOnlyIntNumber,
                  ),
                ),
                HorizontalSpacing(10),
                Expanded(
                  child: CommonDropdownField(
                    titleLabelText: Strings.genderText,
                    items: genders
                        .map(
                          (value) => DropdownMenuItem(
                            value: value,
                            child: CommonText(
                              value,
                              fontSize: 15,
                              color: AppColors.greyTwo,
                            ),
                          ),
                        )
                        .toList(),
                    selectedItemBuilder: (context) => genders
                        .map(
                          (value) => CommonText(
                            value,
                            fontSize: 15,
                            color: AppColors.blackTwo,
                          ),
                        )
                        .toList(),
                    validator: validateTextNotEmpty,
                    onChanged: (value) {
                      genderController.text = value ?? '';
                    },
                  ),
                ),
              ],
            ),
            VerticalSpacing(20),
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
                selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
              ),
              onInputChanged: (value) {
                LoggerService.info(
                  "mobileNumberController.text ${mobileNumberController.text}",
                );
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
            VerticalSpacing(15),
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
              cursorColor: AppColors.blackTwo,
              validator: validateTextNotEmpty,
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
              items: (authController.countryDataOfUs?.states ?? [])
                  .map(
                    (state) => DropdownMenuItem(
                      value: state,
                      child: CommonText(
                        state.name,
                        fontSize: 15,
                        color: AppColors.greyTwo,
                      ),
                    ),
                  )
                  .toList(),
              selectedItemBuilder: (context) =>
                  (authController.countryDataOfUs?.states ?? [])
                      .map(
                        (state) => CommonText(
                          state.name,
                          fontSize: 15,
                          color: AppColors.blackTwo,
                        ),
                      )
                      .toList(),
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
                (c) =>
                    c.name ==
                    authController.selectedCityForBuildYourProfile.value,
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
                selectedItemBuilder: (context) =>
                    cities.asMap().entries.map((entry) {
                      final city = entry.value;
                      return CommonText(
                        city.name,
                        fontSize: 15,
                        color: AppColors.blackTwo,
                      );
                    }).toList(),
                validator: (value) {
                  String cityName = '';
                  if ((value != null && value >= 0 && value < cities.length)) {
                    cityName =
                        authController.selectedCityForBuildYourProfile.value =
                            cities[value].name;
                    return validateTextOnly(cityName);
                  } else {
                    return validateTextOnly(cityName);
                  }
                },
                onChanged: (value) {
                  if (value != null && value >= 0 && value < cities.length) {
                    authController.selectedCityForBuildYourProfile.value =
                        cities[value].name;
                  } else {
                    authController.selectedCityForBuildYourProfile.value = '';
                  }
                },
                hintText: cities.isEmpty
                    ? 'No cities available'
                    : 'Select City',
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
              inputType: TextInputType.number,
              validator: validateOnlyIntNumber,
            ),
            VerticalSpacing(30),
            CommonButton(
              text: "Save",
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // TODO: Implement save functionality
                  Get.back();
                }
              },
              backgroundColor: AppColors.pinkTwo,
              textColor: AppColors.whiteOne,
            ),
            VerticalSpacing(20),
          ],
        ),
      ),
    );
  }
}
