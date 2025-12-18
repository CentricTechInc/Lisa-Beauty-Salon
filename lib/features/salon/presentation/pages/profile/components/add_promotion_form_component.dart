import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lisa_beauty_salon/app/mixins/validations.dart';
import 'package:lisa_beauty_salon/core/services/logger_service.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/core/utils/input_formatters.dart';
import 'package:lisa_beauty_salon/features/auth/presentation/controllers/auth_controller.dart';
import 'package:lisa_beauty_salon/features/promotions/data/dto/promotion_dto.dart';
import 'package:lisa_beauty_salon/features/salon/presentation/pages/build_your_profile/components/profile_photo_picker_component.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_button.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text_field.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_multi_select_dropdown.dart';

class AddPromotionFormComponent extends StatefulWidget {
  final VoidCallback onSaved;

  const AddPromotionFormComponent({super.key, required this.onSaved});

  @override
  State<AddPromotionFormComponent> createState() => _AddPromotionFormComponentState();
}

class _AddPromotionFormComponentState extends State<AddPromotionFormComponent> with FieldsValidation {
  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final subtitleController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();

  final selectedServices = <String>[].obs;
  final selectedCategories = <String>[].obs;
  final photoNotifier = ValueNotifier<String?>(null);

  final List<String> categories = const [
    'All Category',
    'Bridal',
    'Hair Care',
    'Skin Care',
    'Nail Care',
  ];

  final List<String> salonServices = const [
    'Hairstyling',
    'Nail',
    'Hair color',
    'Body Glowing',
    'Facial',
    'Spa',
    'Eyebrows',
    'Makeup',
    'Retouch',
    'Corner lashes',
  ];

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
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const VerticalSpacing(10),
            const CommonText(
              Strings.createPromotionText,
              fontSize: 18,
              fontWeight: 700,
              color: AppColors.blackTwo,
            ),
            const VerticalSpacing(20),
            ValueListenableBuilder(
              valueListenable: photoNotifier,
              builder: (context, path, _) {
                return PhotoPickerComponent(
                  title: Strings.uploadYourPictureOptionalText,
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
              titleLabelText: Strings.titleLabelText,
              controller: titleController,
              labelText: Strings.titlePlaceholderText,
              hintText: Strings.titlePlaceholderText,
              labelSize: 15,
              hintSize: 15,
              labelColor: AppColors.greyTwo,
              hintColor: AppColors.greyTwo,
              textColor: AppColors.blackTwo,
              cursorColor: AppColors.blackTwo,
              validator: validateTextNotEmpty,
            ),
            const VerticalSpacing(20),
            CommonTextField(
              titleLabelText: Strings.subtitleLabelText,
              controller: subtitleController,
              labelText: Strings.subtitlePlaceholderText,
              hintText: Strings.subtitlePlaceholderText,
              labelSize: 15,
              hintSize: 15,
              labelColor: AppColors.greyTwo,
              hintColor: AppColors.greyTwo,
              textColor: AppColors.blackTwo,
              cursorColor: AppColors.blackTwo,
              validator: validateTextNotEmpty,
            ),
            const VerticalSpacing(20),
            CommonTextField(
              titleLabelText: "${Strings.priceText}*",
              controller: priceController,
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
            Obx(() => CommonMultiSelectDropdown<String>(
                  titleLabelText: Strings.categoryLabelText,
                  items: categories,
                  selectedItems: selectedCategories.toList(),
                  itemLabelBuilder: (item) => item,
                  onChanged: (values) {
                    selectedCategories.assignAll(values);
                  },
                  hintText: Strings.selectCategoriesHintText,
                  validator: validateListNotEmpty,
                )),
            const VerticalSpacing(20),
            Obx(() => CommonMultiSelectDropdown<String>(
                  titleLabelText: Strings.servicesLabelText,
                  items: salonServices,
                  selectedItems: selectedServices.toList(),
                  itemLabelBuilder: (item) => item,
                  onChanged: (values) {
                    selectedServices.assignAll(values);
                  },
                  hintText: Strings.selectServicesHintText,
                  validator: validateListNotEmpty,
                )),
            const VerticalSpacing(20),
            CommonTextField(
              titleLabelText: "${Strings.descriptionText} (${Strings.optionalText})",
              controller: descriptionController,
              labelText: Strings.descriptionPlaceholderText,
              hintText: Strings.descriptionPlaceholderText,
              labelSize: 15,
              hintSize: 15,
              minLines: 6,
              maxLines: 8,
              labelColor: AppColors.greyTwo,
              hintColor: AppColors.greyTwo,
              textColor: AppColors.blackTwo,
              cursorColor: AppColors.blackTwo,
            ),
            const VerticalSpacing(24),
            CommonButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  final dto = PromotionDto(
                    title: titleController.text.trim(),
                    subtitle: subtitleController.text.trim(),
                    description: descriptionController.text.trim(),
                    priceText: priceController.text.trim(),
                    imagePath: photoNotifier.value ?? '',
                    services: selectedServices.toList(),
                    category: selectedCategories.join(', '),
                    subCategory: '', // We can use services as sub-services or add another dropdown
                  );
                  authController.addPromotion(dto);
                  widget.onSaved();
                }
              },
              text: Strings.saveText,
              backgroundColor: AppColors.pinkTwo,
              textColor: AppColors.whiteOne,
              height: 50,
            ),
            const VerticalSpacing(20),
          ],
        ),
      ),
    );
  }
}
