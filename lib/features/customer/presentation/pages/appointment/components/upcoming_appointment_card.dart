import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_button.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_switch_widget.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_dropdown_field.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_sliding_button.dart';

class UpcomingAppointmentCard extends StatefulWidget {
  final String salonName;
  final String date;
  final String image;
  final VoidCallback onTap;

  const UpcomingAppointmentCard({
    super.key,
    required this.salonName,
    required this.date,
    required this.image,
    required this.onTap,
  });

  @override
  State<UpcomingAppointmentCard> createState() => _UpcomingAppointmentCardState();
}

class _UpcomingAppointmentCardState extends State<UpcomingAppointmentCard> {
  final ValueNotifier<String> _reminderTime = ValueNotifier("30 min before");

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showDetailsBottomSheet(context),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.whiteOne,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.greyOne.withValues(alpha: 0.5),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.blackOne.withValues(alpha: 0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText(
              widget.date,
              fontSize: 14,
              fontWeight: 600,
              color: AppColors.blackTwo,
            ),
            const VerticalSpacing(12),
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    widget.image,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                const HorizontalSpacing(16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(
                        widget.salonName,
                        fontSize: 18,
                        fontWeight: 600,
                        color: AppColors.blackTwo,
                      ),
                      const VerticalSpacing(4),
                      const CommonText(
                        "6391 Elgin St. Celina, Delaware...",
                        fontSize: 12,
                        color: AppColors.greyTwo,
                        textOverflow: TextOverflow.ellipsis,
                      ),
                      const VerticalSpacing(8),
                      RichText(
                        text: TextSpan(
                          text: "Services: ",
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.greyTwo,
                            fontFamily: Strings.fontFamily,
                          ),
                          children: [
                            const TextSpan(
                              text: "Regular Haircut, Classic Shaving",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppColors.pinkTwo,
                                fontFamily: Strings.fontFamily,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const VerticalSpacing(16),
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
                  onPressed: () => _showCancelDialog(context),
                  text: Strings.cancelText,
                  width: 100,
                  height: 40,
                  radius: 12,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 05,
                  ),
                  backgroundColor: AppColors.whiteOne,
                  borderColor: AppColors.greyOne,
                  textColor: AppColors.blackTwo,
                  textFontSize: 12,
                  textFontWeight: 500,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showCancelDialog(BuildContext context) {
    final ValueNotifier<bool> isYesSelected = ValueNotifier(false);

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: AppColors.whiteOne,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: AppColors.pinkTwo.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.close,
                    color: AppColors.pinkTwo,
                    size: 32,
                  ),
                ),
                const VerticalSpacing(24),
                const CommonText(
                  "Cancellation of appointment",
                  fontSize: 22,
                  fontWeight: 600,
                  color: AppColors.blackTwo,
                  textAlign: TextAlign.center,
                  textOverflow: TextOverflow.visible,
                  maxLines: 4,
                ),
                const VerticalSpacing(16),
                const CommonText(
                  "Are you sure, you want to cancel this appointment?",
                  fontSize: 14,
                  color: AppColors.greyTwo,
                  textAlign: TextAlign.center,
                  textOverflow: TextOverflow.visible,
                  maxLines: 4,
                ),
                const VerticalSpacing(32),
                CommonSlidingButton(
                  valueListenable: isYesSelected,
                  leftLabel: Strings.yesText,
                  rightLabel: Strings.noText,
                  onLeftTap: () => Get.back(),
                  onRightTap: () => Get.back(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showDetailsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.9,
          decoration: const BoxDecoration(
            color: AppColors.whiteOne,
            borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
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
              const VerticalSpacing(24),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          widget.image,
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const VerticalSpacing(16),
                      CommonText(
                        widget.salonName,
                        fontSize: 22,
                        fontWeight: 600,
                        color: AppColors.blackTwo,
                      ),
                      const VerticalSpacing(4),
                      const CommonText(
                        "6391 Elgin St. Celina, Delaware...",
                        fontSize: 14,
                        color: AppColors.greyTwo,
                      ),
                      const VerticalSpacing(24),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10
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
                                  label: "Chat"
                                )
                              ),
                              Expanded(
                                child: _buildActionBtn(
                                  icon: Icons.directions_outlined,
                                  label: "Direction"
                                )
                              ),
                            ],
                          ),
                        ),
                      ),
                      const VerticalSpacing(32),
                      _buildDetailRow("Date & Time", widget.date, isHighlight: true),
                      const VerticalSpacing(24),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: CommonText(
                          "Services",
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
                      const Divider(color: AppColors.greyOne),
                      const VerticalSpacing(20),
                      _buildDetailRow("Total", "\$32.99", isBold: true, isHighlight: true),
                      const VerticalSpacing(24),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: CommonText(
                          "Notes",
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
                        lineHeight: 1.5,
                      ),
                      const VerticalSpacing(40),
                      Row(
                        children: [
                          Row(
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
                                          horizontal: 0, vertical: 8),
                                      borderRadius: 8,
                                      borderColor: Colors.transparent,
                                      fillColor: Colors.transparent,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          CommonButton(
                            onPressed: () {
                              Get.back();
                              _showCancelDialog(context);
                            },
                            text: "Cancel",
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
                      const VerticalSpacing(24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildActionBtn({required IconData icon, required String label}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 48,
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.whiteOne
            )
          ),
          child: Icon(
            icon,
            color: AppColors.whiteOne,
            size: 20
          )
        ),
        const HorizontalSpacing(8),
        CommonText(
          label,
          fontSize: 16,
          fontWeight: 400,
          color: AppColors.whiteOne,
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isHighlight = false, bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 4,
          child: CommonText(
            label,
            fontSize: isBold ? 20 : 16,
            fontWeight: isBold ? 700 : 600,
            color: AppColors.blackTwo,
            textOverflow: TextOverflow.visible,
          ),
        ),
        Expanded(
          flex: 2,
          child: CommonText(
            value,
            fontSize: isBold ? 20 : 16,
            fontWeight: isBold ? 700 : 500,
            color: isHighlight ? AppColors.pinkTwo : AppColors.blackTwo,
            textOverflow: TextOverflow.visible,
          ),
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
}
