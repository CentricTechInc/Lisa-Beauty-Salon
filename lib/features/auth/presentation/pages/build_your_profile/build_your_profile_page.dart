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
            CommonText(
              Strings.verifyYourProfessionalStatusText,
              fontSize: 20,
              fontWeight: 700,
              color: AppColors.blackTwo,
            ),
            VerticalSpacing(10),
            CommonText(
              Strings.verifyYourProfessionalStatusDescriptionText,
              fontSize: 16,
              fontWeight: 400,
              color: AppColors.greyTwo,
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

class _BuildYourProfilePageFour extends StatefulWidget {
  const _BuildYourProfilePageFour({
    required this.pageController
  });

  final PageController pageController;

  @override
  State<_BuildYourProfilePageFour> createState() => _BuildYourProfilePageFourState();
}

class _BuildYourProfilePageFourState extends State<_BuildYourProfilePageFour> {

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
                return _ShowServiceWidget();
              }
            }),
            VerticalSpacing(80),
            CommonButton(
              onPressed: () {
                widget.pageController.animateToPage(
                  5,
                  duration: Duration(milliseconds: 50),
                  curve: Curves.easeInOut
                );
              },
              text: Strings.continueText,
              textColor: AppColors.whiteOne,
            )
          ],
        ),
      ),
    );
  }
}

class _ShowServiceWidget extends StatelessWidget {
  const _ShowServiceWidget();

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

class _BuildYourProfilePageFive extends StatefulWidget {
  const _BuildYourProfilePageFive({
    required this.pageController,
  });

  final PageController pageController;

  @override
  State<_BuildYourProfilePageFive> createState() => _BuildYourProfilePageFiveState();
}

class _BuildYourProfilePageFiveState extends State<_BuildYourProfilePageFive> {
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
                SwitchTheme(
                  data: SwitchThemeData(
                    trackOutlineColor: WidgetStateProperty.resolveWith<Color?>(
                          (states) => Colors.transparent,
                    ),
                  ),
                  child: Obx(() => Switch(
                    value: authController.isCustomScheduleEnabled.value,
                    onChanged: authController.toggleCustomSchedule,
                    activeThumbColor: AppColors.whiteOne,
                    activeTrackColor: AppColors.greenOne,
                    inactiveThumbColor: AppColors.whiteOne,
                    inactiveTrackColor: AppColors.greyFour,
                  )),
                ),
              ],
            ),
            VerticalSpacing(20),
            Obx(() {
              if (authController.isCustomScheduleEnabled.value) {
                // RENDER CUSTOM DAY-BY-DAY SCHEDULE
                return _buildCustomScheduleUI(authController);
              } else {
                // RENDER DEFAULT SCHEDULE FOR ALL DAYS
                return _buildDefaultScheduleUI(authController);
              }
            }),
        
            VerticalSpacing(30),
            CommonButton(
              onPressed: () {
                // Navigate to the next screen
              },
              child: const CommonText("Almost Done!"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDefaultScheduleUI(AuthController controller) {
    final defaultSchedule = controller.defaultSchedule.value;

    // UI that looks like the first screenshot (Mon, Tue, Wed, Thu, Fri, Sat, Sun buttons)
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Time Slots (From/To) for Work
        _buildTimeSlotEditor(
          title: "From",
          timeSlot: defaultSchedule.workSlots.isNotEmpty ? defaultSchedule.workSlots.first : null,
          onTimeSelected: (time) { /* Logic to update work slot time */ },
        ),

        VerticalSpacing(20),

        // Add Break Time
        const CommonText("Add Break Time (Optional)"),
        _buildTimeSlotEditor(
          title: "Break From",
          timeSlot: defaultSchedule.breakSlots.isNotEmpty ? defaultSchedule.breakSlots.first : null,
          onTimeSelected: (time) { /* Logic to update break slot time */ },
        ),
        // ... more complex UI elements for time/AMPM selection
      ],
    );
  }

  Widget _buildCustomScheduleUI(AuthController controller) {
    // The list of all days
    final List<String> days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];

    return Column(
      children: days.map((day) {
        // Fetch the schedule for the current day from the main DTO
        final DayScheduleDto daySchedule = controller.buildProfileData?.weeklySchedule[day] ?? DayScheduleDto();

        return Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: _buildDayToggleAndSchedule(
            day: day,
            schedule: daySchedule,
            controller: controller,
          ),
        );
      }).toList(),
    );
  }

  // Helper widget to build the individual day's toggle and time slots (as seen in the second screenshot)
  Widget _buildDayToggleAndSchedule({
    required String day,
    required DayScheduleDto schedule,
    required AuthController controller,
  }) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonText(day, fontWeight: 700),
            Switch(
              value: schedule.isEnabled,
              onChanged: (isEnabled) {
                // Update the state for THIS specific day
                controller.setDailySchedule(
                    day,
                    DayScheduleDto(
                        isEnabled: isEnabled,
                        workSlots: schedule.workSlots,
                        breakSlots: schedule.breakSlots
                    )
                );
              },
              activeColor: AppColors.pinkTwo,
            ),
          ],
        ),
        // Renders time slots only if the day is enabled
        if (schedule.isEnabled) ...[
          // Time slots editor (like in the screenshot)
          _buildTimeSlotEditor(
            title: "From/To",
            timeSlot: schedule.workSlots.isNotEmpty ? schedule.workSlots.first : null,
            onTimeSelected: (time) {
              // Logic to update time slot for THIS specific day
            },
          ),
          // ... Add Break Time editor for the day
        ]
      ],
    );
  }

  // Dummy widget for time editing (Replace with your actual time picker widget)
  Widget _buildTimeSlotEditor({String? title, TimeSlotDto? timeSlot, required Function(TimeSlotDto) onTimeSelected}) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.greyOne),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(title ?? ''),
          // Implement your actual Time picker widgets here
          // Example: Text(timeSlot?.fromTime ?? 'Select Time'),
        ],
      ),
    );
  }
}



