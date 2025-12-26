import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/features/auth/presentation/controllers/auth_controller.dart';
import 'package:lisa_beauty_salon/features/auth/data/dto/build_profile_dto.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_button.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/core/services/loading_service.dart';
import 'package:lisa_beauty_salon/core/utils/message.dart';
import 'service_detail_card.dart';
import 'delete_services_dialog.dart';

class ServiceCategoryDetailSection extends StatefulWidget {
  final String category;

  const ServiceCategoryDetailSection({
    required this.category,
    super.key,
  });

  @override
  State<ServiceCategoryDetailSection> createState() =>
      _ServiceCategoryDetailSectionState();
}

class _ServiceCategoryDetailSectionState
    extends State<ServiceCategoryDetailSection> {
  late final ValueNotifier<Set<ServiceDto>> _selectedServices;
  late final ValueNotifier<bool> _isSelectionMode;

  @override
  void initState() {
    super.initState();
    _selectedServices = ValueNotifier<Set<ServiceDto>>({});
    _isSelectionMode = ValueNotifier<bool>(false);
  }

  @override
  void dispose() {
    _selectedServices.dispose();
    _isSelectionMode.dispose();
    super.dispose();
  }

  void _toggleSelection(ServiceDto service) {
    final currentSet = Set<ServiceDto>.from(_selectedServices.value);
    if (currentSet.contains(service)) {
      currentSet.remove(service);
    } else {
      currentSet.add(service);
    }
    _selectedServices.value = currentSet;
  }

  void _clearSelection() {
    _selectedServices.value = {};
    _isSelectionMode.value = false;
  }

  Future<void> _deleteSelected() async {
    if (_selectedServices.value.isEmpty) return;

    final confirmed = await Get.dialog<bool>(
      DeleteServicesDialog(count: _selectedServices.value.length),
    );

    if (confirmed == true) {
      final loadingService = Get.find<LoadingService>();
      loadingService.show();

      await Future.delayed(const Duration(seconds: 2));

      final authController = Get.find<AuthController>();
      for (final service in _selectedServices.value) {
        authController.removeService(service);
      }

      _clearSelection();
      loadingService.hide();

      MessageUtils.showSuccessSnackBar(
        "Services deleted successfully",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(top: 20),
              child: Obx(() {
                final allServices =
                    authController.buildProfileData?.services ?? [];
                final categoryServices = allServices
                    .where((s) => s.serviceCategory == widget.category)
                    .toList();

                if (categoryServices.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: CommonText(
                        "No services found in this category",
                        color: AppColors.greyTwo,
                        fontWeight: 400,
                      ),
                    ),
                  );
                }

                return ValueListenableBuilder<bool>(
                  valueListenable: _isSelectionMode,
                  builder: (context, isSelectionMode, child) {
                    return ValueListenableBuilder<Set<ServiceDto>>(
                      valueListenable: _selectedServices,
                      builder: (context, selectedServices, child) {
                        return Column(
                          children: [
                            if (isSelectionMode && categoryServices.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        if (selectedServices.length ==
                                            categoryServices.length) {
                                          _selectedServices.value = {};
                                        } else {
                                          _selectedServices.value =
                                              Set<ServiceDto>.from(
                                                  categoryServices);
                                        }
                                      },
                                      child: CommonText(
                                        selectedServices.length ==
                                                categoryServices.length
                                            ? Strings.unselectAllText
                                            : Strings.selectAllText,
                                        fontSize: 14,
                                        fontWeight: 600,
                                        color: AppColors.pinkTwo,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ...categoryServices
                                .map((service) => Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 12),
                                      child: ServiceDetailCard(
                                        service: service,
                                        isSelectionMode: isSelectionMode,
                                        isSelected:
                                            selectedServices.contains(service),
                                        onSelected: () =>
                                            _toggleSelection(service),
                                      ),
                                    ))
                                .toList(),
                          ],
                        );
                      },
                    );
                  },
                );
              }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20, top: 10),
            child: ValueListenableBuilder<bool>(
              valueListenable: _isSelectionMode,
              builder: (context, isSelectionMode, child) {
                return ValueListenableBuilder<Set<ServiceDto>>(
                  valueListenable: _selectedServices,
                  builder: (context, selectedServices, child) {
                    if (isSelectionMode) {
                      return Row(
                        children: [
                          Expanded(
                            child: CommonButton(
                              onPressed: _clearSelection,
                              text: Strings.cancelText,
                              backgroundColor: AppColors.transparent,
                              borderColor: AppColors.greyOne,
                              textColor: AppColors.greyTwo,
                              radius: 12,
                              textFontWeight: 600,
                            ),
                          ),
                          const HorizontalSpacing(15),
                          Expanded(
                            child: CommonButton(
                              onPressed: () {
                                if (selectedServices.isEmpty) {
                                  MessageUtils.showErrorSnackBar(
                                      "no service selected");
                                } else {
                                  _deleteSelected();
                                }
                              },
                              text: selectedServices.isEmpty
                                  ? Strings.deleteAnyServiceText
                                  : "${Strings.deleteAnyServiceText} (${selectedServices.length})",
                              backgroundColor: AppColors.pinkTwo,
                              textColor: AppColors.whiteOne,
                              radius: 12,
                              textFontWeight: 600,
                            ),
                          ),
                        ],
                      );
                    }
                    return CommonButton(
                      onPressed: () {
                        _isSelectionMode.value = true;
                      },
                      text: Strings.deleteAnyServiceText,
                      backgroundColor: AppColors.transparent,
                      borderColor: AppColors.pinkTwo,
                      textColor: AppColors.pinkTwo,
                      radius: 12,
                      textFontWeight: 600,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
