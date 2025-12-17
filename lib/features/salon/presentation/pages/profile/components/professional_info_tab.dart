import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:lisa_beauty_salon/app/mixins/validations.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/message.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/features/auth/presentation/controllers/auth_controller.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_button.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_dropdown_field.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_file_upload_component.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text_field.dart';

class ProfessionalInfoTab extends StatefulWidget {
  const ProfessionalInfoTab({super.key});

  @override
  State<ProfessionalInfoTab> createState() => _ProfessionalInfoTabState();
}

class _ProfessionalInfoTabState extends State<ProfessionalInfoTab>
    with FieldsValidation {
  final _formKey = GlobalKey<FormState>();

  final professionalBioController = TextEditingController();
  final yearsOfExperienceController = TextEditingController();
  final professionalsOnTeamController = TextEditingController();
  final licenseTypeController = TextEditingController();
  final licenseNumberController = TextEditingController();
  final issuanceStateOrCountryController = TextEditingController();

  final ValueNotifier<List<XFile>> _imageFilesNotifier = ValueNotifier([]);
  final ValueNotifier<List<File>> _documentFilesNotifier = ValueNotifier([]);

  String? validateFileSelection({
    required List<XFile> images,
    required List<File> documents,
  }) {
    // Making it optional for edit page unless user wants to change it
    // But based on UI it looks like a required field or at least displayed prominent
    // For now keeping optional or required based on business logic.
    // Assuming required if empty for new profile, but for edit maybe not.
    // Let's keep it consistent with registration for now.
    // if ((images.isEmpty) && (documents.isEmpty)) {
    //   return 'Please upload at least one image or document';
    // }
    return null;
  }

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

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonTextField(
            titleLabelText: Strings.professionalAndBioOrHeadlineText,
            controller: professionalBioController,
            hintText: Strings.descriptionPlaceholderText,
            labelText: null,
            labelSize: 15,
            hintSize: 15,
            minLines: 6,
            maxLines: 8,
            labelColor: AppColors.greyTwo,
            hintColor: AppColors.greyTwo,
            cursorColor: AppColors.blackTwo,
            textColor: AppColors.blackTwo,
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
            validator: validateOnlyIntNumber,
          ),
          VerticalSpacing(20),
          CommonTextField(
            titleLabelText: "How Many Professionals Are On Your Team?",
            controller: professionalsOnTeamController,
            labelText: "07",
            hintText: "07",
            labelSize: 15,
            hintSize: 15,
            labelColor: AppColors.greyTwo,
            hintColor: AppColors.greyTwo,
            cursorColor: AppColors.blackTwo,
            inputType: TextInputType.number,
            validator: validateOnlyIntNumber,
          ),
          VerticalSpacing(20),
          CommonDropdownField(
            titleLabelText: Strings.licenseTypeText,
            items: licenseTypesList
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
            selectedItemBuilder: (context) => licenseTypesList
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
              licenseTypeController.text = value ?? '';
            },
          ),
          VerticalSpacing(20),
          CommonTextField(
            titleLabelText: Strings.licenseNumberText,
            controller: licenseNumberController,
            labelText: Strings.licenseNumberPlaceholderText,
            hintText: Strings.licenseNumberPlaceholderText,
            labelSize: 15,
            hintSize: 15,
            labelColor: AppColors.greyTwo,
            hintColor: AppColors.greyTwo,
            textColor: AppColors.blackTwo,
            cursorColor: AppColors.blackTwo,
            validator: validateOnlyIntNumber,
          ),
          VerticalSpacing(20),
          CommonDropdownField(
            titleLabelText: Strings.issuanceStateOrCountryNumberText,
            items: authController.countriesList
                .map(
                  (value) => DropdownMenuItem(
                    value: value,
                    child: CommonText(
                      value.name,
                      fontSize: 15,
                      color: AppColors.greyTwo,
                    ),
                  ),
                )
                .toList(),
            selectedItemBuilder: (context) => authController.countriesList
                .map(
                  (value) => CommonText(
                    value.name,
                    fontSize: 15,
                    color: AppColors.blackTwo,
                  ),
                )
                .toList(),
            validator: (value) => validateTextWithDashes(value?.name),
            onChanged: (value) {
              issuanceStateOrCountryController.text = value?.name ?? '';
            },
          ),
          VerticalSpacing(20),
          // Simulating the License Photo link as per UI
          CommonText(
            "License Photo.jpeg", // This would dynamic
            fontSize: 14,
            color: AppColors.pinkTwo,
            // textDecoration: TextDecoration.underline,
            // decorationColor: AppColors.pinkTwo,
          ),
          VerticalSpacing(10),
          CommonText(
            Strings
                .uploadLicensePhotoText, // "Upload Another License" in UI maybe? UI says "Upload Another License"
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
          VerticalSpacing(30),
          CommonButton(
            text: "Save",
            onPressed: () {
              final fileError = validateFileSelection(
                images: _imageFilesNotifier.value,
                documents: _documentFilesNotifier.value,
              );

              if (_formKey.currentState!.validate() && fileError == null) {
                // TODO: Implement Save
                Get.back();
              } else if (fileError != null) {
                MessageUtils.showErrorSnackBar(fileError);
              }
            },
            backgroundColor: AppColors.pinkTwo,
            textColor: AppColors.whiteOne,
          ),
          VerticalSpacing(20),
        ],
      ),
    );
  }
}
