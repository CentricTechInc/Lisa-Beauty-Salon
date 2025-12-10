

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/features/auth/presentation/controllers/auth_controller.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_button.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_dropdown_field.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_file_upload_component.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text_field.dart';

class BuildYourProfilePageTwo extends StatefulWidget {
  const BuildYourProfilePageTwo({
    required this.pageController,
  });

  final PageController pageController;

  @override
  State<BuildYourProfilePageTwo> createState() => BuildYourProfilePageTwoState();
}

class BuildYourProfilePageTwoState extends State<BuildYourProfilePageTwo> {

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
                  2,
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