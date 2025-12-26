import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lisa_beauty_salon/app/mixins/validations.dart';
import 'package:lisa_beauty_salon/core/services/logger_service.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/input_formatters.dart';
import 'package:lisa_beauty_salon/core/utils/message.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/features/auth/data/dto/build_profile_dto.dart';
import 'package:lisa_beauty_salon/features/auth/presentation/controllers/auth_controller.dart';
import 'package:lisa_beauty_salon/core/services/loading_service.dart';
import 'package:lisa_beauty_salon/features/salon/presentation/pages/build_your_profile/components/profile_photo_picker_component.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_button.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_dropdown_field.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text_field.dart';

class AddServiceFormComponent extends StatelessWidget with FieldsValidation {
  final VoidCallback onSaved;

  AddServiceFormComponent({
    required this.onSaved,
    super.key,
  });

  final _formKey = GlobalKey<FormState>();

  final serviceCategoryNameController = TextEditingController();
  final subCategoryController = TextEditingController();
  final serviceForController = TextEditingController();
  final serviceNameController = TextEditingController();
  final servicePriceController = TextEditingController();
  final serviceDescription = TextEditingController();
  final photoNotifier = ValueNotifier<String?>(null);
  final subCategoryListNotifier = ValueNotifier<List<String>>([]);

  Future<File?> pickImageFromGallery() async {
    try {
      final picker = ImagePicker();
      final picked = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );
      if (picked == null) return null;
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

    final Map<String, List<String>> categorySubCategories = {
      Strings.hairCategoryText: [
        Strings.hairWashText,
        Strings.hairCutText,
        Strings.hairColoringText,
        Strings.stylingText,
        Strings.treatmentsText
      ],
      Strings.nailsCategoryText: [
        Strings.manicureText,
        Strings.pedicureText,
        Strings.gelPolishText,
        Strings.nailArtText,
        Strings.acrylicsText
      ],
      Strings.makeupCategoryText: [
        Strings.bridalMakeupText,
        Strings.fullGlamText,
        Strings.naturalLookText,
        Strings.partyMakeupText
      ],
      Strings.massageCategoryText: [
        Strings.swedishMassageText,
        Strings.deepTissueText,
        Strings.aromatherapyText,
        Strings.hotStoneText
      ],
      Strings.skinCareCategoryText: [
        Strings.classicFacialText,
        Strings.hydratingFacialText,
        Strings.chemicalPeelText,
        Strings.extractionText
      ],
      Strings.tanningCategoryText: [
        Strings.sprayTanText,
        Strings.uvTanningText
      ],
      Strings.waxingCategoryText: [
        Strings.legWaxingText,
        Strings.armWaxingText,
        Strings.bikiniWaxingText,
        Strings.fullBodyWaxingText
      ],
      Strings.spaTreatmentsCategoryText: [
        Strings.bodyScrubText,
        Strings.mudWrapText,
        Strings.steamBathText
      ],
      Strings.lashesAndBrowsCategoryText: [
        Strings.lashExtensionsText,
        Strings.lashLiftText,
        Strings.browThreadingText,
        Strings.hennaBrowsText
      ],
      Strings.permanentMakeupCategoryText: [
        Strings.microbladingText,
        Strings.lipBlushText,
        Strings.permanentEyelinerText
      ],
    };

    return Form(
      key: _formKey,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const VerticalSpacing(20),
                  CommonDropdownField(
                    titleLabelText: "${Strings.serviceCategoryText}*",
                    items: serviceCategories
                        .map((value) => DropdownMenuItem(
                              value: value,
                              child: CommonText(
                                value,
                                fontSize: 15,
                                color: AppColors.greyTwo,
                              ),
                            ))
                        .toList(),
                    selectedItemBuilder: (context) => serviceCategories
                        .map((value) => CommonText(
                              value,
                              fontSize: 15,
                              color: AppColors.blackTwo,
                            ))
                        .toList(),
                    validator: validateTextNotEmpty,
                    onChanged: (value) {
                      serviceCategoryNameController.text = value ?? '';
                      subCategoryController.clear();
                      subCategoryListNotifier.value = categorySubCategories[value] ?? [];
                    },
                  ),
                  const VerticalSpacing(20),
                  ValueListenableBuilder<List<String>>(
                    valueListenable: subCategoryListNotifier,
                    builder: (context, subCategories, child) {
                      return CommonDropdownField(
                        titleLabelText: Strings.subCategoryLabelText,
                        items: subCategories
                            .map((value) => DropdownMenuItem(
                                  value: value,
                                  child: CommonText(
                                    value,
                                    fontSize: 15,
                                    color: AppColors.greyTwo,
                                  ),
                                ))
                            .toList(),
                        selectedItemBuilder: (context) => subCategories
                            .map((value) => CommonText(
                                  value,
                                  fontSize: 15,
                                  color: AppColors.blackTwo,
                                ))
                            .toList(),
                        value: subCategoryController.text.isEmpty ? null : subCategoryController.text,
                        validator: validateTextNotEmpty,
                        onChanged: (value) {
                          subCategoryController.text = value ?? '';
                        },
                      );
                    },
                  ),
                  const VerticalSpacing(20),
                  CommonDropdownField(
                    titleLabelText: "${Strings.serviceForText}*",
                    items: serviceFor
                        .map((value) => DropdownMenuItem(
                              value: value,
                              child: CommonText(
                                value,
                                fontSize: 15,
                                color: AppColors.greyTwo,
                              ),
                            ))
                        .toList(),
                    selectedItemBuilder: (context) => serviceFor
                        .map((value) => CommonText(
                              value,
                              fontSize: 15,
                              color: AppColors.blackTwo,
                            ))
                        .toList(),
                    validator: validateTextNotEmpty,
                    onChanged: (value) {
                      serviceForController.text = value ?? '';
                    },
                  ),
                  const VerticalSpacing(20),
                  CommonTextField(
                    titleLabelText: Strings.serviceNameText,
                    controller: serviceNameController,
                    labelText: Strings.serviceNamePlaceholderText,
                    hintText: Strings.serviceNamePlaceholderText,
                    labelSize: 15,
                    hintSize: 15,
                    labelColor: AppColors.greyTwo,
                    hintColor: AppColors.greyTwo,
                    textColor: AppColors.blackTwo,
                    cursorColor: AppColors.blackTwo,
                    validator: validateBusinessName,
                  ),
                  const VerticalSpacing(20),
                  CommonTextField(
                    titleLabelText: "${Strings.priceText}*",
                    controller: servicePriceController,
                    labelText: Strings.pricePlaceholderText,
                    hintText: Strings.pricePlaceholderText,
                    labelSize: 15,
                    hintSize: 15,
                    labelColor: AppColors.greyTwo,
                    hintColor: AppColors.greyTwo,
                    textColor: AppColors.blackTwo,
                    cursorColor: AppColors.blackTwo,
                    validator: validatePrice,
                    inputFormatter: [
                      FilteringTextInputFormatter.allow(RegExp(r'[R\s\d.]')),
                      CurrencyInputFormatter(currencySymbol: "R "),
                    ],
                  ),
                  const VerticalSpacing(20),
                  const VerticalSpacing(10),
                  ValueListenableBuilder(
                    valueListenable: photoNotifier,
                    builder: (context, path, _) {
                      return PhotoPickerComponent(
                        title: Strings.uploadAPictureText,
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
                  const VerticalSpacing(20),
                  CommonTextField(
                    titleLabelText: "${Strings.descriptionText} (${Strings.optionalText})",
                    controller: serviceDescription,
                    labelText: null,
                    hintText: Strings.descriptionPlaceholderText,
                    labelSize: 15,
                    hintSize: 15,
                    minLines: 4,
                    maxLines: 6,
                    labelColor: AppColors.greyTwo,
                    hintColor: AppColors.greyTwo,
                    textColor: AppColors.blackTwo,
                    cursorColor: AppColors.blackTwo,
                    fillColor: AppColors.greyFour,
                    borderColor: AppColors.transparent,
                  ),
                  const VerticalSpacing(20),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: CommonButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final loadingService = Get.find<LoadingService>();
                  loadingService.show();

                  final price = servicePriceController.text
                      .replaceAll("R", '')
                      .replaceAll(' ', '');
                  
                  // Simulate network delay
                  await Future.delayed(const Duration(seconds: 2));
                  
                  authController.addService(
                    ServiceDto(
                      serviceCategory: serviceCategoryNameController.text,
                      subCategory: subCategoryController.text,
                      serviceFor: serviceForController.text,
                      serviceName: serviceNameController.text,
                      serviceDescription: serviceDescription.text,
                      servicePhoto: photoNotifier.value ?? "",
                      servicePrice: double.tryParse(price) ?? 0,
                    ),
                  );

                  loadingService.hide();
                  
                  // Small delay to ensure dialog is completely closed before navigating
                  await Future.delayed(const Duration(milliseconds: 100));
                  
                  onSaved();
                  MessageUtils.showSuccessSnackBar(
                    "Service added successfully",
                  );
                } else {
                  MessageUtils.showErrorSnackBar(
                    Strings.fillRequiredFieldsText,
                  );
                }
              },
              text: Strings.addText,
              textColor: AppColors.whiteOne,
              radius: 12,
              textFontWeight: 600,
              textFontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
