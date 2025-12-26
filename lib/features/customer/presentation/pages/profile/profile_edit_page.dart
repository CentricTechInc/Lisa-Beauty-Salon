import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/app/mixins/validations.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_scaffold_widget.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';
import 'package:lisa_beauty_salon/features/auth/presentation/controllers/auth_controller.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text_field.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_button.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_dropdown_field.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/core/services/loading_service.dart';
import 'package:lisa_beauty_salon/core/utils/message.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lisa_beauty_salon/core/services/logger_service.dart';

class CustomerEditProfilePage extends StatefulWidget {
  const CustomerEditProfilePage({super.key});

  @override
  State<CustomerEditProfilePage> createState() => _CustomerEditProfilePageState();
}

class _CustomerEditProfilePageState extends State<CustomerEditProfilePage> with FieldsValidation {
  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController(text: "Eleanor");
  final _lastNameController = TextEditingController(text: "Pena");
  final _emailController = TextEditingController(text: "eleanor@mail.com");
  final _ageController = TextEditingController(text: "25");
  final _genderController = TextEditingController(text: "Female");
  final _addressController = TextEditingController(text: "158 Suffolk Ave #2");
  final _cityController = TextEditingController(text: "Brentwood");
  final _stateController = TextEditingController(text: "New York");
  final _zipController = TextEditingController(text: "11717");

  late final ValueNotifier<String?> _genderNotifier;
  late final ValueNotifier<String?> _stateNotifier;
  late final ValueNotifier<String?> _cityNotifier;
  late final ValueNotifier<String?> _photoNotifier;

  @override
  void initState() {
    super.initState();
    _genderNotifier = ValueNotifier(_genderController.text.isEmpty ? null : _genderController.text);
    _stateNotifier = ValueNotifier(_stateController.text.isEmpty ? null : _stateController.text);
    _cityNotifier = ValueNotifier(_cityController.text.isEmpty ? null : _cityController.text);
    _photoNotifier = ValueNotifier<String?>(null);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _ageController.dispose();
    _genderController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipController.dispose();
    _genderNotifier.dispose();
    _stateNotifier.dispose();
    _cityNotifier.dispose();
    _photoNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final genders = [Strings.maleText, Strings.femaleText, Strings.otherText];

    return CommonScaffoldWidget(
      useSafeArea: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          Expanded(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const VerticalSpacing(20),
                  _buildProfileImage(),
                  const VerticalSpacing(32),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          "First Name", 
                          "Enter First Name", 
                          _firstNameController,
                          validateName,
                        ),
                      ),
                      const HorizontalSpacing(16),
                      Expanded(
                        child: _buildTextField(
                          "Last Name", 
                          "Enter Last Name", 
                          _lastNameController,
                          validateName,
                        ),
                      ),
                    ],
                  ),
                  const VerticalSpacing(20),
                  _buildTextField(
                    "Email", 
                    "Enter Email", 
                    _emailController,
                    validateEmail,
                  ),
                  const VerticalSpacing(20),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          "Age", 
                          "Enter Age", 
                          _ageController,
                          validateOnlyIntNumber,
                        ),
                      ),
                      const HorizontalSpacing(16),
                      Expanded(
                        child: ValueListenableBuilder<String?>(
                          valueListenable: _genderNotifier,
                          builder: (context, gender, _) {
                            return CommonDropdownField<String>(
                              titleLabelText: Strings.genderText,
                              value: gender,
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
                                _genderNotifier.value = value;
                                _genderController.text = value ?? '';
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const VerticalSpacing(20),
                  _buildTextField(
                    "Street Address", 
                    "Enter Street Address", 
                    _addressController,
                    validateTextNotEmpty,
                  ),
                  const VerticalSpacing(20),
                  ValueListenableBuilder<String?>(
                    valueListenable: _stateNotifier,
                    builder: (context, state, _) {
                      return Obx(
                        () => CommonDropdownField(
                          titleLabelText: Strings.stateText,
                          value: (authController.countryDataOfUs?.states ?? []).firstWhereOrNull((s) => s.name == state),
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
                            _stateNotifier.value = value?.name;
                            _stateController.text = value?.name ?? '';
                            authController.setCitiesAccordingToState(
                              _stateController.text,
                              Strings.buildYourProfileDropdownScenario,
                            );
                            // Reset city when state changes
                            _cityNotifier.value = null;
                            _cityController.text = '';
                          },
                        ),
                      );
                    },
                  ),
                  const VerticalSpacing(20),
                  ValueListenableBuilder<String?>(
                    valueListenable: _cityNotifier,
                    builder: (context, city, _) {
                      return Obx(() {
                        final cities = authController.citiesList;
                        final selectedIndex = cities.indexWhere(
                          (c) => c.name == city,
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
                              cityName = cities[value].name;
                              return validateTextOnly(cityName);
                            } else {
                              return validateTextOnly(cityName);
                            }
                          },
                          onChanged: (value) {
                            if (value != null && value >= 0 && value < cities.length) {
                              _cityController.text = cities[value].name;
                              authController.selectedCityForBuildYourProfile.value =
                                  cities[value].name;
                              _cityNotifier.value = cities[value].name;
                            } else {
                              _cityController.text = '';
                              authController.selectedCityForBuildYourProfile.value = '';
                              _cityNotifier.value = null;
                            }
                          },
                          hintText: cities.isEmpty ? 'No cities available' : 'Select City',
                        );
                      });
                    },
                  ),
                  const VerticalSpacing(20),
                  _buildTextField(
                    "Zip Code", 
                    "Enter Zip Code", 
                    _zipController,
                    validateTextWithNumber,
                  ),
                  const VerticalSpacing(32),
                  CommonButton(
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        final loadingService = Get.find<LoadingService>();
                        loadingService.show();
                        
                        // Simulate network delay
                        await Future.delayed(const Duration(seconds: 2));
                        
                        loadingService.hide();
                        
                        // Small delay to ensure dialog is completely closed before popping the page
                        await Future.delayed(const Duration(milliseconds: 100));
                        
                        Get.back();
                        MessageUtils.showSuccessSnackBar(
                          "Profile updated successfully",
                        );
                      }
                    },
                    text: "Save",
                    width: double.infinity,
                    backgroundColor: AppColors.pinkTwo,
                  ),
                  const VerticalSpacing(32),
                ],
              ),
            ),
          ),
        ),
      ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: AppColors.whiteOne,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColors.greyOne
              )
            ),
            child: Center(
              child: Icon(
                CupertinoIcons.chevron_back,
                color: AppColors.blackTwo,
              ),
            ),
          ),
        ),
        HorizontalSpacing(15),
        const CommonText(
          "Profile",
          fontSize: 24,
          fontWeight: 600,
          color: AppColors.blackTwo,
        ),
      ],
    );
  }

  Future<File?> _pickImageFromGallery() async {
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

  Widget _buildProfileImage() {
    return Center(
      child: Stack(
        children: [
          ValueListenableBuilder<String?>(
            valueListenable: _photoNotifier,
            builder: (context, path, _) {
              return Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: path != null
                        ? FileImage(File(path)) as ImageProvider
                        : const NetworkImage(
                            "https://media.istockphoto.com/id/1682296067/photo/happy-studio-portrait-or-professional-man-real-estate-agent-or-asian-businessman-smile-for.jpg?s=612x612&w=0&k=20&c=9zbG2-9fl741fbTWw5fNgcEEe4ll-JegrGlQQ6m54rg=",
                          ),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: () async {
                final file = await _pickImageFromGallery();
                if (file != null) {
                  _photoNotifier.value = file.path;
                }
              },
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: AppColors.whiteOne,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.edit,
                  size: 16,
                  color: AppColors.pinkTwo,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    String label, 
    String hint, 
    TextEditingController controller,
    String? Function(String? value) validator,
  ) {
    return CommonTextField(
      controller: controller,
      titleLabelText: label,
      hintText: hint,
      labelText: hint,
      fillColor: AppColors.whiteOne,
      cursorColor: AppColors.blackTwo,
      textColor: AppColors.blackTwo,
      borderColor: AppColors.greyOne,
      borderRadius: 12,
      validator: validator,
    );
  }
}
