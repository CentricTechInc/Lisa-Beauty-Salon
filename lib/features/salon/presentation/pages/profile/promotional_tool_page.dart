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
import 'package:lisa_beauty_salon/shared/widgets/common_dropdown_field.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_scaffold_widget.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_button.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text_field.dart';

class PromotionalToolPage extends StatefulWidget {
  const PromotionalToolPage({super.key});

  @override
  State<PromotionalToolPage> createState() => _PromotionalToolPageState();
}

class _PromotionalToolPageState extends State<PromotionalToolPage> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    return CommonScaffoldWidget(
      padding: EdgeInsets.zero,
      systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: AppColors.whiteTwo,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      resizeToAvoidBottomInset: true,
      child: Column(
        children: [
          VerticalSpacing(30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.greyThree),
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 16,
                      color: AppColors.blackOne,
                    ),
                  ),
                ),
                const HorizontalSpacing(15),
                CommonText(
                  Strings.promotionalToolText,
                  fontSize: 20,
                  fontWeight: 700,
                  color: AppColors.blackTwo,
                ),
              ],
            ),
          ),
          VerticalSpacing(20),
          Expanded(
            child: Obx(() {
              if (authController.showAddPromotionForm.value) {
                return _AddPromotionForm(
                  onSaved: () {
                    authController.toggleAddPromotionForm();
                  },
                );
              } else {
                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _PromotionListSection(
                        promotions: authController.promotions,
                        onAddPromotion: authController.toggleAddPromotionForm,
                        onSelect: (index) {
                          selectedIndex = index;
                          final p = authController.promotions[index];
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(16),
                              ),
                            ),
                            builder: (_) => Padding(
                              padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom,
                              ),
                              child: _PromotionBottomSheet(promotion: p),
                            ),
                          );
                        },
                      ),
                      VerticalSpacing(20),
                    ],
                  ),
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}

class _PromotionListSection extends StatelessWidget {
  final List<PromotionDto> promotions;
  final ValueChanged<int> onSelect;
  final VoidCallback onAddPromotion;

  const _PromotionListSection({
    required this.promotions,
    required this.onSelect,
    required this.onAddPromotion,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.greyOne),
        color: AppColors.transparent,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CommonText(
              'Click the “Add a Promotion” button to create packages or offers.',
              fontSize: 14,
              fontWeight: 400,
              color: AppColors.greyTwo,
            ),
            VerticalSpacing(16),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: promotions.length,
              separatorBuilder: (_, __) => const VerticalSpacing(12),
              itemBuilder: (context, index) {
                final p = promotions[index];
                return InkWell(
                  onTap: () => onSelect(index),
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.whiteOne,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                      border: Border.all(color: AppColors.greyOne),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonText(
                                p.title,
                                fontSize: 16,
                                fontWeight: 700,
                                color: AppColors.blackTwo,
                              ),
                              const VerticalSpacing(4),
                              CommonText(
                                p.subtitle,
                                fontSize: 14,
                                fontWeight: 400,
                                color: AppColors.greyTwo,
                              ),
                            ],
                          ),
                        ),
                        CommonText(
                          p.priceText,
                          fontSize: 14,
                          fontWeight: 700,
                          color: AppColors.pinkTwo,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            VerticalSpacing(20),
            CommonButton(
              onPressed: onAddPromotion,
              text: "+ Add a Promotion",
              width: 180,
              backgroundColor: AppColors.transparent,
              borderColor: AppColors.pinkTwo,
              textColor: AppColors.pinkTwo,
              radius: 12,
            ),
            VerticalSpacing(20),
          ],
        ),
      ),
    );
  }
}

class _PromotionBottomSheet extends StatelessWidget {
  final PromotionDto promotion;
  const _PromotionBottomSheet({required this.promotion});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.whiteOne,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.greyOne),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Container(
                    height: 140,
                    color: AppColors.greyFour,
                    child: promotion.imagePath.isEmpty
                        ? const Icon(Icons.image,
                            color: AppColors.greyTwo, size: 48)
                        : Image.file(
                            File(promotion.imagePath),
                            fit: BoxFit.cover,
                            height: 140,
                            width: double.infinity,
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CommonText(
                        promotion.title,
                        fontSize: 18,
                        fontWeight: 700,
                        color: AppColors.blackTwo,
                      ),
                      const VerticalSpacing(4),
                      CommonText(
                        promotion.subtitle,
                        fontSize: 14,
                        fontWeight: 400,
                        color: AppColors.greyTwo,
                      ),
                      const VerticalSpacing(12),
                      CommonText(
                        promotion.description,
                        fontSize: 14,
                        fontWeight: 400,
                        color: AppColors.blackTwo,
                        lineHeight: 1.6,
                      ),
                      const VerticalSpacing(16),
                      CommonText(
                        "Services",
                        fontSize: 14,
                        fontWeight: 700,
                        color: AppColors.blackTwo,
                      ),
                      const VerticalSpacing(10),
                      Wrap(
                        spacing: 12,
                        runSpacing: 10,
                        children: promotion.services
                            .map((s) => _ServiceChip(text: s))
                            .toList(),
                      ),
                      const VerticalSpacing(16),
                      Row(
                        children: [
                          Expanded(
                            child: CommonButton(
                              onPressed: () {},
                              text: "Book Now",
                              backgroundColor: AppColors.blackThree,
                              textColor: AppColors.whiteOne,
                              radius: 12,
                              height: 48,
                            ),
                          ),
                          const HorizontalSpacing(12),
                          Container(
                            height: 48,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: AppColors.whiteOne,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: AppColors.greyOne),
                            ),
                            alignment: Alignment.center,
                            child: CommonText(
                              promotion.priceText,
                              fontSize: 16,
                              fontWeight: 700,
                              color: AppColors.blackTwo,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ServiceChip extends StatelessWidget {
  final String text;
  const _ServiceChip({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.whiteOne,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.greyOne),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 18,
            height: 18,
            decoration: const BoxDecoration(
              color: AppColors.success,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check, size: 14, color: AppColors.whiteOne),
          ),
          const HorizontalSpacing(8),
          CommonText(
            text,
            fontSize: 14,
            fontWeight: 500,
            color: AppColors.blackTwo,
          ),
        ],
      ),
    );
  }
}

class _AddPromotionForm extends StatefulWidget {
  final VoidCallback onSaved;
  const _AddPromotionForm({required this.onSaved});

  @override
  State<_AddPromotionForm> createState() => _AddPromotionFormState();
}

class _AddPromotionFormState extends State<_AddPromotionForm>
    with FieldsValidation {
  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final subtitleController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final addServiceController = TextEditingController();

  final services = <String>[].obs;
  final photoNotifier = ValueNotifier<String?>(null);
  String? _selectedCategory;
  String? _selectedSubCategory;

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
            VerticalSpacing(10),
            CommonText(
              "Create Promotion",
              fontSize: 18,
              fontWeight: 700,
              color: AppColors.blackTwo,
            ),
            VerticalSpacing(20),
            CommonTextField(
              titleLabelText: "Title*",
              controller: titleController,
              labelText: "Bridal Beauty Makeup",
              hintText: "Bridal Beauty Makeup",
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
              titleLabelText: "Subtitle*",
              controller: subtitleController,
              labelText: "Complete Package Offer",
              hintText: "Complete Package Offer",
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
              titleLabelText: Strings.descriptionText,
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
              validator: validateTextNotEmpty,
            ),
            VerticalSpacing(20),
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
            CommonText(
              "Category",
              fontSize: 14,
              fontWeight: 700,
              color: AppColors.blackTwo,
            ),
            VerticalSpacing(10),
            _CategorySubcategorySection(
              onChanged: (category, subCategory) {
                setState(() {
                  _selectedCategory = category;
                  _selectedSubCategory = subCategory;
                });
              },
            ),
            VerticalSpacing(20),
            CommonText(
              "Services",
              fontSize: 14,
              fontWeight: 700,
              color: AppColors.blackTwo,
            ),
            VerticalSpacing(10),
            Row(
              children: [
                Expanded(
                  child: CommonTextField(
                    controller: addServiceController,
                    labelText: "Add service",
                    hintText: "Add service",
                    labelSize: 15,
                    hintSize: 15,
                    labelColor: AppColors.greyTwo,
                    hintColor: AppColors.greyTwo,
                    textColor: AppColors.blackTwo,
                    cursorColor: AppColors.blackTwo,
                  ),
                ),
                const HorizontalSpacing(10),
                CommonButton(
                  onPressed: () {
                    final s = addServiceController.text.trim();
                    if (s.isNotEmpty) {
                      services.add(s);
                      addServiceController.clear();
                    }
                  },
                  text: Strings.addText,
                  width: 90,
                  height: 48,
                  backgroundColor: AppColors.pinkTwo.withAlpha(50),
                  textColor: AppColors.pinkTwo,
                  borderColor: AppColors.pinkTwo,
                  radius: 12,
                ),
              ],
            ),
            VerticalSpacing(12),
            Obx(() {
              return Wrap(
                spacing: 10,
                runSpacing: 10,
                children: services
                    .map(
                      (s) => GestureDetector(
                        onTap: () => services.remove(s),
                        child: _ServiceChip(text: s),
                      ),
                    )
                    .toList(),
              );
            }),
            VerticalSpacing(24),
            CommonButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  final dto = PromotionDto(
                    title: titleController.text.trim(),
                    subtitle: subtitleController.text.trim(),
                    description: descriptionController.text.trim(),
                    priceText: priceController.text.trim(),
                    imagePath: photoNotifier.value ?? '',
                    services: services.toList(),
                    category: _selectedCategory ?? '',
                    subCategory: _selectedSubCategory ?? '',
                  );
                  authController.addPromotion(dto);
                  widget.onSaved();
                }
              },
              text: "Save",
              backgroundColor: AppColors.pinkTwo,
              textColor: AppColors.whiteOne,
              height: 50,
            ),
            VerticalSpacing(20),
          ],
        ),
      ),
    );
  }
}

class _CategorySubcategorySection extends StatefulWidget {
  final void Function(String? category, String? subCategory) onChanged;
  const _CategorySubcategorySection({required this.onChanged});

  @override
  State<_CategorySubcategorySection> createState() => _CategorySubcategorySectionState();
}

class _CategorySubcategorySectionState extends State<_CategorySubcategorySection>
    with FieldsValidation {
  final List<String> categories = const [
    'All Category',
    'Bridal',
    'Hair Care',
    'Skin Care',
    'Nail Care',
  ];

  final Map<String, List<String>> subcategories = const {
    'All Category': ['All Services'],
    'Bridal': ['Bridal Makeup', 'Bridal Hair', 'Bridal Package'],
    'Hair Care': ['Hair Cut', 'Hair Color', 'Hair Styling'],
    'Skin Care': ['Facial', 'Peel', 'Treatment'],
    'Nail Care': ['Manicure', 'Pedicure', 'Nail Art'],
  };

  String? selectedCategory;
  String? selectedSubServices;

  @override
  void initState() {
    super.initState();
    selectedCategory = categories.first;
    selectedSubServices = subcategories[selectedCategory]!.first;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onChanged(selectedCategory, selectedSubServices);
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentSubs = subcategories[selectedCategory] ?? const <String>[];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonDropdownField<String>(
          titleLabelText: 'Category*',
          value: selectedCategory,
          items: categories
              .map(
                (c) => DropdownMenuItem<String>(
                  value: c,
                  child: Row(
                    children: [
                      _CheckIcon(),
                      const HorizontalSpacing(8),
                      CommonText(c),
                    ],
                  ),
                ),
              )
              .toList(),
          selectedItemBuilder: (context) => categories
              .map(
                (c) => Row(
                  children: [
                    _CheckIcon(),
                    const HorizontalSpacing(8),
                    CommonText(c),
                  ],
                ),
              )
              .toList(),
          onChanged: (val) {
            setState(() {
              selectedCategory = val;
              selectedSubServices = subcategories[val]!.first;
            });
            widget.onChanged(selectedCategory, selectedSubServices);
          },
          validator: validateTextNotEmpty,
        ),
        VerticalSpacing(16),
        CommonDropdownField<String>(
          titleLabelText: 'Sub Services*',
          value: selectedSubServices,
          items: currentSubs
              .map(
                (sc) => DropdownMenuItem<String>(
                  value: sc,
                  child: Row(
                    children: [
                      _CheckIcon(),
                      const HorizontalSpacing(8),
                      CommonText(sc),
                    ],
                  ),
                ),
              )
              .toList(),
          selectedItemBuilder: (context) => currentSubs
              .map(
                (sc) => Row(
                  children: [
                    _CheckIcon(),
                    const HorizontalSpacing(8),
                    CommonText(sc),
                  ],
                ),
              )
              .toList(),
          onChanged: (val) {
            setState(() {
              selectedSubServices = val;
            });
            widget.onChanged(selectedCategory, selectedSubServices);
          },
          validator: validateTextNotEmpty,
        ),
      ],
    );
  }
}

class _CheckIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18,
      height: 18,
      decoration: const BoxDecoration(
        color: AppColors.success,
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.check, size: 14, color: AppColors.whiteOne),
    );
  }
}
