import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:lisa_beauty_salon/core/constants/app_constants.dart';
import 'package:lisa_beauty_salon/core/services/logger_service.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/input_formatters.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/features/auth/data/dto/build_profile_dto.dart';
import 'package:lisa_beauty_salon/features/auth/presentation/controllers/auth_controller.dart';
import 'package:lisa_beauty_salon/features/auth/presentation/pages/build_your_profile/components/profile_photo_picker_component.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_back_button.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_button.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_dropdown_field.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_file_upload_component.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_scaffold_widget.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_switch_widget.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text_field.dart';
import 'package:lisa_beauty_salon/shared/widgets/custom_slider_thumb_circle.dart';

class BuildYourProfilePage extends StatefulWidget {
  const BuildYourProfilePage({super.key});

  @override
  State<BuildYourProfilePage> createState() => _BuildYourProfilePageState();
}

class _BuildYourProfilePageState extends State<BuildYourProfilePage> {

  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _totalPages = 11;


  @override
  Widget build(BuildContext context) {
    return CommonScaffoldWidget(
      padding: EdgeInsets.zero,
      systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: AppColors.whiteTwo,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            VerticalSpacing(30),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: CommonBackButton(
                        iconColor: AppColors.blackTwo,
                      ),
                    ),
                    CommonText(
                      Strings.buildYourProfileText,
                      fontSize: 24,
                      fontWeight: 600,
                      color: AppColors.blackTwo,
                    ),
                  ],
                ),
              ),
            ),
            VerticalSpacing(20),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20
              ),
              child: IgnorePointer(
                ignoring: true,
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: Colors.pink,
                    inactiveTrackColor: Colors.grey[300],
                    trackHeight: 3.0,
                    thumbShape: CustomSliderThumbCircle(
                      thumbRadius: 8
                    ),
                    overlayShape: SliderComponentShape.noOverlay,
                    trackShape: RoundedRectSliderTrackShape(),
                  ),
                  child: Slider(
                    value: (_currentPage + 1) / _totalPages,
                    onChanged: (value) {},
                    min: 0,
                    max: 1,
                  ),
                ),
              ),
            ),
            VerticalSpacing(20),
            SizedBox(
              height: context.height * 0.8,
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: [
                  _BuildYourProfilePageOne(
                    pageController: _pageController,
                  ),
                  _BuildYourProfilePageTwo(
                    pageController: _pageController,
                  ),
                  _BuildYourProfilePageThree(
                    pageController: _pageController,
                  ),
                  _BuildYourProfilePageFour(
                    pageController: _pageController,
                  ),
                  _BuildYourProfilePageFive(
                    pageController: _pageController,
                  ),
                ],
              ),
            ),
            VerticalSpacing(20),
            VerticalSpacing(20),
          ],
        ),
      ),
    );
  }
}

class _BuildYourProfilePageOne extends StatefulWidget {
  const _BuildYourProfilePageOne({
    required this.pageController,
  });

  final PageController pageController;

  @override
  State<_BuildYourProfilePageOne> createState() => _BuildYourProfilePageOneState();
}

class _BuildYourProfilePageOneState extends State<_BuildYourProfilePageOne> {

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

class _BuildYourProfilePageTwo extends StatefulWidget {
  const _BuildYourProfilePageTwo({
    required this.pageController,
  });

  final PageController pageController;

  @override
  State<_BuildYourProfilePageTwo> createState() => _BuildYourProfilePageTwoState();
}

class _BuildYourProfilePageTwoState extends State<_BuildYourProfilePageTwo> {

  final licenseTypeController = TextEditingController();
  final licenseNumberController = TextEditingController();
  final issuanceStateOrCountryController = TextEditingController();
  final ValueNotifier<List<XFile>> _imageFilesNotifier = ValueNotifier([]);
  final ValueNotifier<List<File>> _documentFilesNotifier = ValueNotifier([]);

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    final licenseTypesList = [
      Strings.barberLicenseType,
      Strings.cosmetologistLicenseType,
      Strings.estheticianLicenseType,
      Strings.nailTechnicianLicenseType,
      Strings.makeupArtistLicenseType,
      Strings.hairStylistLicenseType,
      Strings.massageTherapistLicenseType,
      Strings.skinCareSpecialistLicenseType,
      Strings.beautyConsultantLicenseType,
      Strings.permanentMakeupArtistLicenseType,
      Strings.eyebrowSpecialistLicenseType,
      Strings.lashTechnicianLicenseType,
      Strings.pedicuristLicenseType,
      Strings.manicuristLicenseType,
      Strings.tanningSpecialistLicenseType,
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VerticalSpacing(20),
            Center(
              child: CommonText(
                Strings.verifyYourProfessionalStatusText,
                fontSize: 20,
                fontWeight: 700,
                color: AppColors.blackTwo,
              ),
            ),
            VerticalSpacing(10),
            CommonText(
              Strings.verifyYourProfessionalStatusDescriptionText,
              fontSize: 16,
              fontWeight: 400,
              color: AppColors.greyTwo,
              textOverflow: TextOverflow.visible,
              textAlign: TextAlign.center,
            ),
            VerticalSpacing(30),
            CommonDropdownField(
              titleLabelText: Strings.licenseTypeText,
              items: licenseTypesList.map((value) => DropdownMenuItem(
                value: value,
                child: CommonText(
                  value,
                  fontSize: 15,
                  color: AppColors.greyTwo,
                ),
              )
              ).toList(),
              onChanged: (value) {
                licenseTypeController.text = value ?? '';
              },
            ),
            VerticalSpacing(20),
            CommonTextField(
              titleLabelText: Strings.licenseNumberText,
              controller: licenseNumberController,
              labelText: Strings.licenseNumberPlaceholderText,
              labelSize: 15,
              labelColor: AppColors.greyTwo,
              hintText: Strings.licenseNumberPlaceholderText,
              hintSize: 15,
              hintColor: AppColors.greyTwo,
            ),
            VerticalSpacing(20),
            CommonDropdownField(
              titleLabelText: Strings.issuanceStateOrCountryNumberText,
              items: authController.countriesList.map((value) => DropdownMenuItem(
                value: value,
                child: CommonText(
                  value.name,
                  fontSize: 15,
                  color: AppColors.greyTwo,
                ),
              )
              ).toList(),
              onChanged: (value) {
                issuanceStateOrCountryController.text = value?.name ?? '';
              },
            ),
            VerticalSpacing(20),
            CommonText(
              Strings.uploadLicensePhotoText,
              fontSize: 12,
              fontWeight: 400,
              color: AppColors.blackTwo,
            ),
            VerticalSpacing(5),
            CommonText(
              Strings.uploadLicensePhotoDescriptionText,
              fontSize: 12,
              fontWeight: 400,
              color: AppColors.blackTwo,
            ),
            VerticalSpacing(10),
            FileUploadComponent(
              documentFilesNotifier: _documentFilesNotifier,
              imageFilesNotifier: _imageFilesNotifier,
            ),
            VerticalSpacing(20),
            CommonButton(
              text: Strings.continueText,
              onPressed: () {
                authController.setLicenseData(
                  licenseType: licenseTypeController.text,
                  licenseNumber: licenseNumberController.text,
                  licenseIssuanceStateOrCountry: issuanceStateOrCountryController.text,
                  licenseFile: ''
                );

                widget.pageController.animateToPage(
                  3,
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

class _BuildYourProfilePageThree extends StatefulWidget {
  const _BuildYourProfilePageThree({
    required this.pageController,
  });

  final PageController pageController;

  @override
  State<_BuildYourProfilePageThree> createState() => _BuildYourProfilePageThreeState();
}

class _BuildYourProfilePageThreeState extends State<_BuildYourProfilePageThree> {

  final professionalBioController = TextEditingController();
  final yearsOfExperienceController = TextEditingController();

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

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 20
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VerticalSpacing(20),
            Center(
              child: CommonText(
                Strings.createYourProfessionalProfileText,
                fontSize: 20,
                fontWeight: 700,
                color: AppColors.blackTwo,
              ),
            ),
            VerticalSpacing(10),
            Center(
              child: CommonText(
                Strings.createYourProfessionalProfileDescriptionText,
                fontSize: 16,
                fontWeight: 400,
                color: AppColors.greyTwo,
              ),
            ),
            VerticalSpacing(30),
            CommonText(
              Strings.uploadYourProfilePhotoText,
              fontSize: 12,
              fontWeight: 400,
              color: AppColors.blackTwo,
            ),
            VerticalSpacing(10),
            ValueListenableBuilder(
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
            VerticalSpacing(20),
            CommonTextField(
              titleLabelText: Strings.professionalAndBioOrHeadlineText,
              controller: professionalBioController,
              labelText: null,
              hintText: Strings.descriptionPlaceholderText,
              labelSize: 15,
              hintSize: 15,
              labelColor: AppColors.greyTwo,
              hintColor: AppColors.greyTwo,
              cursorColor: AppColors.blackTwo,
              minLines: 6,
              maxLines: 8,
              fillColor: AppColors.greyFour,
              borderColor: AppColors.transparent,
            ),
            VerticalSpacing(20),
            CommonTextField(
              titleLabelText: Strings.yearsOfExperienceText,
              controller: yearsOfExperienceController,
              labelText: Strings.yearsOfExperiencePlaceholderText,
              hintText: Strings.yearsOfExperiencePlaceholderText,
              labelSize: 15,
              hintSize: 15,
              labelColor: AppColors.greyTwo,
              hintColor: AppColors.greyTwo,
              cursorColor: AppColors.blackTwo,
              inputType: TextInputType.number,
            ),
            VerticalSpacing(60),
            CommonButton(
              text: Strings.continueText,
              textColor: AppColors.whiteOne,
              onPressed: () {

                authController.setProfessionalData(
                  professionalBio: professionalBioController.text,
                  yearsOfExperience: int.tryParse(yearsOfExperienceController.text) ?? 0,
                  profilePhotoFile: photoNotifier.value.toString()
                );

                widget.pageController.animateToPage(
                  4,
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

class _BuildYourProfilePageFour extends StatelessWidget {
  const _BuildYourProfilePageFour({
    required this.pageController
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            VerticalSpacing(20),
            Center(
              child: CommonText(
                Strings.setUpYourServicesAndPricing,
                fontSize: 20,
                fontWeight: 700,
                color: AppColors.blackTwo,
              ),
            ),
            VerticalSpacing(10),
            Obx(() {
              if (authController.showAddServiceForm.value) {
                return _ShowAddServiceForm();
              }
              else {
                return _ShowServicesWidget(
                  pageController: pageController,
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}

class _ShowServicesWidget extends StatelessWidget {
  const _ShowServicesWidget({
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return Column(
      children: [
        if ((authController.buildProfileData?.services ?? []).isNotEmpty)...[
          Center(
            child: Wrap(
              alignment: WrapAlignment.center,
              children: [
                CommonText(
                  Strings.setUpYourServicesAndPricingAlternateDescriptionOneText,
                  fontSize: 16,
                  fontWeight: 400,
                  color: AppColors.greyTwo,
                ),
                CommonText(
                  Strings.setUpYourServicesAndPricingAlternateDescriptionTwoText,
                  fontSize: 16,
                  fontWeight: 400,
                  color: AppColors.blackTwo,
                ),
                CommonText(
                  Strings.setUpYourServicesAndPricingAlternateDescriptionThreeText,
                  fontSize: 16,
                  fontWeight: 400,
                  color: AppColors.greyTwo,
                ),
              ],
            ),
          ),
          for (ServiceDto service in authController.buildProfileData?.services ?? [])...[
            Container(
              height: 70,
              decoration: BoxDecoration(
                color: AppColors.whiteOne,
                border: Border.all(
                  color: AppColors.greyOne,
                  width: 1
                ),
                borderRadius: BorderRadius.circular(20)
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 15
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: context.width / 2,
                    child: CommonText(
                      service.serviceName,
                      fontSize: 16,
                      fontWeight: 500,
                      color: AppColors.greyTwo,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CommonText(
                        service.serviceCategory,
                        fontSize: 16,
                        fontWeight: 500,
                        color: AppColors.blackTwo,
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: AppColors.blackTwo,
                        size: 30,
                      )
                    ],
                  ),
                ],
              ),
            ),
            VerticalSpacing(10)
          ]
        ]
        else...[
          Center(
            child: Wrap(
              alignment: WrapAlignment.center,
              children: [
                CommonText(
                  Strings.setUpYourServicesAndPricingDescriptionOneText,
                  fontSize: 16,
                  fontWeight: 400,
                  color: AppColors.greyTwo,
                ),
                CommonText(
                  Strings.setUpYourServicesAndPricingDescriptionTwoText,
                  fontSize: 16,
                  fontWeight: 400,
                  color: AppColors.blackTwo,
                ),
                CommonText(
                  Strings.setUpYourServicesAndPricingDescriptionThreeText,
                  fontSize: 16,
                  fontWeight: 400,
                  color: AppColors.greyTwo,
                ),
              ],
            ),
          ),
        ],
        VerticalSpacing(30),
        CommonButton(
          width: 152,
          height: 50,
          radius: 12,
          borderColor: AppColors.pinkTwo,
          backgroundColor: AppColors.pinkTwo.withValues(
              alpha: 0.2
          ),
          onPressed: () {
            authController.toggleAddServiceForm();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add,
                color: AppColors.pinkTwo,
                size: 18,
              ),
              CommonText(
                Strings.addAServiceText,
                fontSize: 16,
                fontWeight: 600,
                color: AppColors.pinkTwo,
              )
            ],
          ),
        ),
        VerticalSpacing(80),
        CommonButton(
          onPressed: () {
            pageController.animateToPage(
              5,
              duration: Duration(milliseconds: 50),
              curve: Curves.easeInOut
            );
          },
          text: Strings.continueText,
          textColor: AppColors.whiteOne,
        )
      ],
    );
  }
}

class _ShowAddServiceForm extends StatelessWidget {
  final serviceCategoryNameController = TextEditingController();

  final serviceForController = TextEditingController();

  final serviceNameController = TextEditingController();

  final servicePriceController = TextEditingController();

  final serviceDescription = TextEditingController();

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
    final serviceCategories = [
      Strings.hairCategoryText,
      Strings.nailsCategoryText,
      Strings.makeupCategoryText,
      Strings.massageCategoryText,
      Strings.skinCareCategoryText,
      Strings.tanningCategoryText,
      Strings.waxingCategoryText,
      Strings.spaTreatmentsCategoryText,
      Strings.lashesAndBrowsCategoryText,
      Strings.permanentMakeupCategoryText,
    ];
    final serviceFor = [
      Strings.menText,
      Strings.womenText,
      Strings.bothText,
    ];
    return Column(
      children: [
        CommonDropdownField(
          titleLabelText: Strings.serviceCategoryText,
          items: serviceCategories.map((value) => DropdownMenuItem(
            value: value,
            child: CommonText(
              value,
              fontSize: 15,
              color: AppColors.greyTwo,
            ),
          )
          ).toList(),
          onChanged: (value) {
            serviceCategoryNameController.text = value ?? '';
          },
        ),
        VerticalSpacing(20),
        CommonDropdownField(
          titleLabelText: Strings.serviceForText,
          items: serviceFor.map((value) => DropdownMenuItem(
            value: value,
            child: CommonText(
              value,
              fontSize: 15,
              color: AppColors.greyTwo,
            ),
          )
          ).toList(),
          onChanged: (value) {
            serviceForController.text = value ?? '';
          },
        ),
        VerticalSpacing(20),
        CommonTextField(
          titleLabelText: Strings.serviceNameText,
          controller: serviceNameController,
          labelText: Strings.serviceNamePlaceholderText,
          labelSize: 15,
          labelColor: AppColors.greyTwo,
          hintText: Strings.serviceNamePlaceholderText,
          hintSize: 15,
          hintColor: AppColors.greyTwo,
        ),
        VerticalSpacing(20),
        CommonTextField(
          titleLabelText: Strings.priceText,
          controller: servicePriceController,
          labelText: Strings.pricePlaceholderText,
          labelSize: 15,
          labelColor: AppColors.greyTwo,
          hintText: Strings.pricePlaceholderText,
          hintSize: 15,
          hintColor: AppColors.greyTwo,
          inputFormatter: [
            FilteringTextInputFormatter.allow(RegExp(r'[R\s\d.]')),

            CurrencyInputFormatter(currencySymbol: "R "),
          ],
        ),
        VerticalSpacing(20),

        CommonText(
          Strings.uploadYourProfilePhotoText,
          fontSize: 12,
          fontWeight: 400,
          color: AppColors.blackTwo,
        ),
        VerticalSpacing(10),
        ValueListenableBuilder(
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
        VerticalSpacing(20),
        CommonTextField(
          titleLabelText: Strings.descriptionText,
          controller: serviceDescription,
          labelText: null,
          hintText: Strings.descriptionPlaceholderText,
          labelSize: 15,
          hintSize: 15,
          labelColor: AppColors.greyTwo,
          hintColor: AppColors.greyTwo,
          cursorColor: AppColors.blackTwo,
          minLines: 6,
          maxLines: 8,
          fillColor: AppColors.greyFour,
          borderColor: AppColors.transparent,
        ),
        VerticalSpacing(20),
        CommonButton(
          width: context.width * 0.8,
          height: 50,
          text: Strings.addText,
          textColor: AppColors.whiteOne,
          onPressed: () {
            authController.addService(
              ServiceDto(
                serviceCategory: serviceCategoryNameController.text,
                serviceFor: serviceForController.text,
                serviceName: serviceNameController.text,
                serviceDescription: serviceDescription.text,
                servicePhoto: photoNotifier.value.toString(),
                servicePrice: double.tryParse(servicePriceController.text) ?? 0,
              )
            );
            authController.toggleAddServiceForm();
          },
        )
      ],
    );
  }
}

class _BuildYourProfilePageFive extends StatelessWidget {
  final PageController pageController;

  const _BuildYourProfilePageFive({
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            CommonText(
              Strings.yourDefaultWeeklyScheduleText,
              fontSize: 20,
              fontWeight: 700,
              color: AppColors.blackTwo,
            ),
            VerticalSpacing(20),
            CommonText(
              Strings.yourDefaultWeeklyScheduleDescriptionText,
              fontSize: 16,
              fontWeight: 400,
              color: AppColors.greyTwo,
            ),
            VerticalSpacing(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CommonText(
                  Strings.customizeText,
                  fontSize: 14,
                  fontWeight: 500,
                  color: AppColors.blackTwo,
                ),
                HorizontalSpacing(8),
                CommonSwitchComponentReactive(
                  value: authController.isCustomScheduleEnabled,
                  onChanged: authController.toggleCustomSchedule,
                )
              ],
            ),
            VerticalSpacing(20),
            Obx(() {
              return authController.isCustomScheduleEnabled.value
                  ? CustomScheduleUI(controller: authController)
                  : DefaultScheduleUI(controller: authController);
            }),
            VerticalSpacing(30),
            CommonButton(
              onPressed: () {},
              text: Strings.almostDoneText,
              textFontSize: 18,
              textFontWeight: 600,
            ),
          ],
        ),
      ),
    );
  }
}

class DefaultScheduleUI extends StatelessWidget {
  final AuthController controller;

  const DefaultScheduleUI({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final defaultSchedule = controller.defaultSchedule.value;
    final defaultBreakSchedule = controller.defaultBreakSchedule.value;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TimeSlotEditor(
          fromTitle: Strings.fromText,
          toTitle: Strings.toText,
          timeSlot: defaultSchedule.workSlots.isNotEmpty ?
            defaultSchedule.workSlots.first : null,
          onTimeSelected: (_) {

          },
        ),
        VerticalSpacing(20),
        Row(
          children: [
            CommonText(
              Strings.addBreakTimeText,
              fontSize: 20,
              fontWeight: 700,
              color: AppColors.blackTwo,
            ),
            CommonText(
              " (${Strings.optionalText})",
              fontSize: 16,
              fontWeight: 400,
              color: AppColors.blackTwo,
            )
          ],
        ),
        VerticalSpacing(20),
        TimeSlotEditor(
          fromTitle: Strings.fromText,
          toTitle: Strings.toText,
          timeSlot: defaultBreakSchedule,
          onTimeSelected: (_) {},
        ),
      ],
    );
  }
}

class CustomScheduleUI extends StatelessWidget {
  final AuthController controller;

  const CustomScheduleUI({
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final defaultBreakSchedule = controller.defaultBreakSchedule;
    return Column(
      children: [
        ...AppConstants.fullWeekDaysNames.map((day) {
          final DayScheduleDto daySchedule = controller
            .buildProfileData?.weeklySchedule[day] ?? DayScheduleDto();

          return Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: DayScheduleRow(
              day: day,
              schedule: daySchedule,
              controller: controller,
            ),
          );
        }),
        VerticalSpacing(10),
        Container(
          decoration: BoxDecoration(
            color: AppColors.whiteOne,
            border: Border.all(
              color: AppColors.greyOne,
            ),
            borderRadius: BorderRadius.circular(16)
          ),
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              Row(
                children: [
                  CommonText(
                    Strings.addBreakTimeText,
                    fontSize: 20,
                    fontWeight: 700,
                    color: AppColors.blackTwo,
                  ),
                  CommonText(
                    " (${Strings.optionalText})",
                    fontSize: 16,
                    fontWeight: 400,
                    color: AppColors.blackTwo,
                  )
                ],
              ),
              VerticalSpacing(20),
              TimeSlotEditor(
                fromTitle: Strings.fromText,
                toTitle: Strings.toText,
                timeSlot: defaultBreakSchedule.value,
                onTimeSelected: (_) {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DayScheduleRow extends StatelessWidget {
  final String day;
  final DayScheduleDto schedule;
  final AuthController controller;

  const DayScheduleRow({
    super.key,
    required this.day,
    required this.schedule,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteOne,
        border: Border.all(
          color: AppColors.greyOne,
        ),
        borderRadius: BorderRadius.circular(16)
      ),
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonText(
                day,
                fontSize: 16,
                fontWeight: 700,
                color: AppColors.blackTwo,
              ),
              CommonSwitchComponentNonReactive(
                value: schedule.isEnabled,
                onChanged: (enabled) {
                  final scheduleData = schedule.copyWith(
                    isEnabled: enabled
                  );
                  controller.setDailySchedule(
                    day,
                    scheduleData,
                  );
                },
              )
            ],
          ),

          if (schedule.isEnabled)
            TimeSlotEditor(
              fromTitle: Strings.fromText,
              toTitle: Strings.toText,
              timeSlot: schedule.workSlots.isNotEmpty
                  ? schedule.workSlots.first
                  : null,
              onTimeSelected: (time) {},
            ),
        ],
      ),
    );
  }
}

class TimeSlotEditor extends StatelessWidget {
  final String? fromTitle;
  final String? toTitle;
  final TimeSlotDto? timeSlot;
  final Function(TimeSlotDto) onTimeSelected;

  const TimeSlotEditor({
    super.key,
    required this.onTimeSelected,
    this.fromTitle,
    this.toTitle,
    this.timeSlot,
  });

  @override
  Widget build(BuildContext context) {
    final fromController = TextEditingController(
      text: timeSlot?.fromTime ?? ""
    );
    final toController = TextEditingController(
      text: timeSlot?.toTime ?? ""
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText(
          fromTitle ?? '',
          fontSize: 14,
          fontWeight: 400,
          color: AppColors.blackTwo,
        ),
        VerticalSpacing(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: context.width / 2.5,
              height: 50,
              child: CommonTextField(
                controller: fromController,
                fillColor: AppColors.greyFour,
                borderRadius: 12,
                textColor: AppColors.blackTwo,
                labelText: null,
                hintText: Strings.fromPlaceholderText,
                cursorColor: AppColors.blackTwo,
                textAlign: TextAlign.center,
              ),
            ),
            HorizontalSpacing(20),
            SizedBox(
              width: context.width / 3,
              child: AmPmToggleButtons(
                onPeriodSelected: (period) {

                },
              ),
            )
          ],
        ),
        VerticalSpacing(20),
        CommonText(
          toTitle ?? '',
          fontSize: 14,
          fontWeight: 400,
          color: AppColors.blackTwo,
        ),
        VerticalSpacing(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: context.width / 2.5,
              height: 50,
              child: CommonTextField(
                controller: toController,
                fillColor: AppColors.greyFour,
                borderRadius: 12,
                textColor: AppColors.blackTwo,
                labelText: null,
                hintText: Strings.toPlaceholderText,
                cursorColor: AppColors.blackTwo,
                textAlign: TextAlign.center,
              ),
            ),
            HorizontalSpacing(20),
            SizedBox(
              width: context.width / 3,
              child: AmPmToggleButtons(
                onPeriodSelected: (period) {

                },
              ),
            )
          ],
        ),
        VerticalSpacing(20),
      ],
    );
  }
}

class AmPmToggleButtons extends StatelessWidget {
  final String? initialPeriod;
  final Function(String selectedPeriod) onPeriodSelected;

  final ValueNotifier<int> _selectedIndexNotifier;

  AmPmToggleButtons({
    super.key,
    this.initialPeriod,
    required this.onPeriodSelected,
  }) : _selectedIndexNotifier = ValueNotifier<int>(initialPeriod == "PM" ? 1 : 0) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onPeriodSelected(_selectedIndexNotifier.value == 0 ? Strings.amText : Strings.pmText);
    });
  }

  @override
  Widget build(BuildContext context) {
    const activeColor = AppColors.pinkTwo;
    const inactiveColor = AppColors.greyFour;

    return ValueListenableBuilder<int>(
      valueListenable: _selectedIndexNotifier,
      builder: (context, selectedIndex, child) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildToggleButton(
              context: context,
              index: 0,
              label: Strings.amText,
              activeColor: activeColor,
              inactiveColor: inactiveColor,
              selectedIndex: selectedIndex
            ),
            _buildToggleButton(
              context: context,
              index: 1,
              label: Strings.pmText,
              activeColor: activeColor,
              inactiveColor: inactiveColor,
              selectedIndex: selectedIndex
            ),
          ],
        );
      },
    );
  }

  Widget _buildToggleButton({
    required BuildContext context,
    required int index,
    required String label,
    required Color activeColor,
    required Color inactiveColor,
    required int selectedIndex,
  }) {
    final bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        _selectedIndexNotifier.value = index;
        onPeriodSelected(label);
      },
      child: Container(
        // width: 90,
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? activeColor : inactiveColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(
              index == 1 ? 12 : 0
            ),
            topLeft: Radius.circular(
              index == 0 ? 12 : 0
            ),
            bottomLeft: Radius.circular(
              index == 0 ? 12 : 0
            ),
            bottomRight: Radius.circular(
              index == 1 ? 12 : 0
            ),
          ),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 20
        ),
        child: CommonText(
          label,
          fontSize: 16,
          fontWeight: 600,
          color: isSelected ? Colors.white : Colors.grey,
        ),
      ),
    );
  }
}



