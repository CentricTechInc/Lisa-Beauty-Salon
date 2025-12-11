

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lisa_beauty_salon/app/mixins/validations.dart';
import 'package:lisa_beauty_salon/core/services/logger_service.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/features/auth/presentation/controllers/auth_controller.dart';
import 'package:lisa_beauty_salon/features/auth/presentation/pages/build_your_profile/components/profile_photo_picker_component.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_button.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text_field.dart';

class BuildYourProfilePageThree extends StatefulWidget {
  const BuildYourProfilePageThree({
    required this.pageController,
  });

  final PageController pageController;

  @override
  State<BuildYourProfilePageThree> createState() => BuildYourProfilePageThreeState();
}

class BuildYourProfilePageThreeState extends State<BuildYourProfilePageThree> with FieldsValidation {

  final _formKey = GlobalKey<FormState>();

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
        child: Form(
          key: _formKey,
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
              VerticalSpacing(60),
              CommonButton(
                text: Strings.continueText,
                textColor: AppColors.whiteOne,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    authController.setProfessionalData(
                      professionalBio: professionalBioController.text,
                      yearsOfExperience: int.tryParse(yearsOfExperienceController.text) ?? 0,
                      profilePhotoFile: photoNotifier.value.toString()
                    );

                    widget.pageController.animateToPage(
                      3,
                      duration: Duration(milliseconds: 50),
                      curve: Curves.easeInOut
                    );
                  }
                  else {
                   Get.snackbar(
                     "Error",
                     "Please make sure sure to enter the age"
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