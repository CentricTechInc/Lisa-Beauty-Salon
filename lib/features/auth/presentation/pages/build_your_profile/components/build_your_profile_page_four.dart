

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lisa_beauty_salon/app/mixins/validations.dart';
import 'package:lisa_beauty_salon/core/services/logger_service.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/input_formatters.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/features/auth/data/dto/build_profile_dto.dart';
import 'package:lisa_beauty_salon/features/auth/presentation/controllers/auth_controller.dart';
import 'package:lisa_beauty_salon/features/auth/presentation/pages/build_your_profile/components/profile_photo_picker_component.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_button.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_dropdown_field.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text_field.dart';

class BuildYourProfilePageFour extends StatelessWidget {
  const BuildYourProfilePageFour({
    required this.pageController,
    super.key,
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
  const _ShowServicesWidget({required this.pageController, super.key});
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final services = authController.buildProfileData?.services ?? [];

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      child: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (services.isNotEmpty) ...[
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
                  const VerticalSpacing(20),
                  ...services.map((service) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _ServiceCard(service: service),
                  )),
                ] else ...[
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
                const VerticalSpacing(20),

                CommonButton(
                  width: 152,
                  height: 50,
                  radius: 12,
                  borderColor: AppColors.pinkTwo,
                  backgroundColor: AppColors.pinkTwo.withAlpha(50),
                  onPressed: () => authController.toggleAddServiceForm(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, color: AppColors.pinkTwo, size: 18),
                      CommonText(
                        Strings.addAServiceText,
                        fontSize: 16,
                        fontWeight: 600,
                        color: AppColors.pinkTwo,
                      ),
                    ],
                  ),
                ),
                const VerticalSpacing(80), // leave space for bottom button
              ],
            ),
          ),

          // Continue button pinned at bottom
          if (services.isNotEmpty)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: CommonButton(
                  onPressed: () {
                    pageController.animateToPage(
                      4,
                      duration: const Duration(milliseconds: 50),
                      curve: Curves.easeInOut,
                    );
                  },
                  text: Strings.continueText,
                  textColor: AppColors.whiteOne,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _ShowAddServiceForm extends StatefulWidget {

  @override
  State<_ShowAddServiceForm> createState() => _ShowAddServiceFormState();
}

class _ShowAddServiceFormState extends State<_ShowAddServiceForm> with FieldsValidation {

  final _formKey = GlobalKey<FormState>();

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
    return Form(
      key: _formKey,
      child: Column(
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
            )).toList(),
            validator: validateTextNotEmpty,
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
            )).toList(),
            validator: validateTextNotEmpty,
            onChanged: (value) {
              serviceForController.text = value ?? '';
            },
          ),
          VerticalSpacing(20),
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
          VerticalSpacing(20),
          CommonTextField(
            titleLabelText: Strings.priceText,
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
          VerticalSpacing(20),

          Align(
            alignment: Alignment.centerLeft,
            child: CommonText(
              Strings.uploadYourProfilePhotoText,
              fontSize: 12,
              fontWeight: 400,
              color: AppColors.blackTwo,
            ),
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
            minLines: 6,
            maxLines: 8,
            labelColor: AppColors.greyTwo,
            hintColor: AppColors.greyTwo,
            textColor: AppColors.blackTwo,
            cursorColor: AppColors.blackTwo,
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
              if (_formKey.currentState!.validate()) {
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
              }
              else{
                Get.snackbar(
                  "Error",
                  "Please make sure to fill the required fields"
                );
              }
            },
          )
        ],
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final ServiceDto service;
  final double? width;

  const _ServiceCard({
    required this.service,
    this.width,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cardWidth = width ?? context.width * 0.8;

    return Container(
      height: 70,
      width: cardWidth,
      decoration: BoxDecoration(
        color: AppColors.whiteOne,
        border: Border.all(color: AppColors.greyOne, width: 1),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: cardWidth / 2,
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}