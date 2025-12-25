import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/assets.dart';
import 'package:lisa_beauty_salon/core/utils/helpers.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_button.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_dropdown_field.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_switch_widget.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';

class UpcomingAppointmentDetailBottomSheet extends StatefulWidget {
  const UpcomingAppointmentDetailBottomSheet({super.key});

  @override
  State<UpcomingAppointmentDetailBottomSheet> createState() => _UpcomingAppointmentDetailBottomSheetState();
}

class _UpcomingAppointmentDetailBottomSheetState extends State<UpcomingAppointmentDetailBottomSheet> {
  final ValueNotifier<String> _reminderTime = ValueNotifier("30 min before");

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        color: AppColors.whiteOne,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(32)
        ),
      ),
      child: Column(
        children: [
          const VerticalSpacing(12),
          Container(
            width: 48,
            height: 5,
            decoration: BoxDecoration(
              color: AppColors.greyOne,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const VerticalSpacing(32),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      Assets.salonOne,
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const VerticalSpacing(16),
                  const CommonText(
                    "Bloom & Blade",
                    fontSize: 22,
                    fontWeight: 600,
                    color: AppColors.blackTwo,
                  ),
                  const VerticalSpacing(4),
                  const CommonText(
                    "6391 Elgin St. Celina, Delaware 10299",
                    fontSize: 14,
                    color: AppColors.greyTwo,
                  ),
                  const VerticalSpacing(24),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.blackThree,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: _buildActionBtn(
                              icon: Icons.chat_bubble_outline,
                              label: "Chat",
                              isFirstItem: true,
                              onTap: () {
                                showFeatureUnderDevelopment();
                              }
                            )
                          ),
                          Expanded(
                            child: _buildActionBtn(
                              icon: Icons.directions_outlined,
                              label: "Direction",
                              isFirstItem: false,
                              onTap: () {
                                showFeatureUnderDevelopment();
                              }
                            )
                          ),
                        ],
                      ),
                    ),
                  ),
                  const VerticalSpacing(32),
                  _buildDetailRow(Strings.dateAndTimeText, "12 November, 09:00 AM", isValueHighlighted: true),
                  const VerticalSpacing(20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: const CommonText(
                      Strings.servicesText,
                      fontSize: 16,
                      fontWeight: 600,
                      color: AppColors.blackTwo,
                    ),
                  ),
                  const VerticalSpacing(12),
                  _buildServiceItem("Nail", "\$8.00"),
                  const VerticalSpacing(8),
                  _buildServiceItem("Facial", "\$24.99"),
                  const VerticalSpacing(20),
                  const Divider(height: 1, color: AppColors.greyOne),
                  const VerticalSpacing(20),
                  _buildDetailRow(Strings.totalText, "\$32.99", isLarge: true, isValueHighlighted: true),
                  const VerticalSpacing(24),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: const CommonText(
                      Strings.notesText,
                      fontSize: 16,
                      fontWeight: 600,
                      color: AppColors.blackTwo,
                    ),
                  ),
                  const VerticalSpacing(8),
                  const CommonText(
                    "Lorem ipsum dolor sit amet consectetur. Cras tincidunt purus sed scelerisque.",
                    fontSize: 14,
                    color: AppColors.greyTwo,
                    lineHeight: 1.6,
                    textOverflow: TextOverflow.visible,
                    maxLines: 3,
                  ),
                  const VerticalSpacing(40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Transform.scale(
                            scale: 0.7,
                            child: CommonSwitchComponentNonReactive(
                              value: true,
                              onChanged: (val) {},
                              activeTrackColor: AppColors.pinkTwo,
                            ),
                          ),
                          SizedBox(
                            width: 130,
                            child: ValueListenableBuilder<String>(
                              valueListenable: _reminderTime,
                              builder: (context, value, child) {
                                return CommonDropdownField<String>(
                                  value: value,
                                  items: [
                                    "15 min before",
                                    "30 min before",
                                    "45 min before"
                                  ].map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    if (newValue != null) {
                                      _reminderTime.value = newValue;
                                    }
                                  },
                                  selectedItemBuilder: (context) {
                                    return [
                                      "15 min before",
                                      "30 min before",
                                      "45 min before"
                                    ].map((e) => CommonText(
                                      e,
                                      fontSize: 12,
                                      color: AppColors.greyTwo,
                                    )).toList();
                                  },
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 0, 
                                    vertical: 8
                                  ),
                                  borderRadius: 8,
                                  borderColor: Colors.transparent,
                                  fillColor: Colors.transparent,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      CommonButton(
                        onPressed: () {
                          Get.back();
                          _showCancelConfirmation(context);
                        },
                        text: Strings.cancelText,
                        width: 100,
                        height: 48,
                        radius: 12,
                        backgroundColor: AppColors.whiteOne,
                        borderColor: AppColors.greyOne,
                        textColor: AppColors.greyTwo,
                        textFontSize: 14,
                        textFontWeight: 600,
                      ),
                    ],
                  ),
                  const VerticalSpacing(30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionBtn({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required bool isFirstItem,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: AppColors.blackThree,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(isFirstItem ? 16 : 0),
            bottomLeft: Radius.circular(isFirstItem ? 16 : 0),
            topRight: Radius.circular(isFirstItem ? 0 : 16),
            bottomRight: Radius.circular(isFirstItem ? 0 : 16),
          )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.whiteOne, size: 20),
            const HorizontalSpacing(10),
            CommonText(label, fontSize: 16, color: AppColors.whiteOne, fontWeight: 500),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isLarge = false, bool isValueHighlighted = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CommonText(
          label,
          fontSize: isLarge ? 20 : 16,
          fontWeight: isLarge ? 700 : 600,
          color: AppColors.blackTwo,
        ),
        CommonText(
          value,
          fontSize: isLarge ? 20 : 16,
          fontWeight: isLarge ? 700 : 500,
          color: isValueHighlighted ? AppColors.pinkTwo : AppColors.blackTwo,
        ),
      ],
    );
  }

  Widget _buildServiceItem(String name, String price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CommonText(name, fontSize: 14, color: AppColors.greyTwo),
        CommonText(price, fontSize: 14, color: AppColors.pinkTwo, fontWeight: 500),
      ],
    );
  }

  void _showCancelConfirmation(BuildContext context) {
    // Implement Cancel Dialog later
  }
}
