import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/core/constants/route_constants.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/helpers.dart';
import 'package:lisa_beauty_salon/features/customer/presentation/pages/map/components/suggestion_card_component.dart';
import 'package:lisa_beauty_salon/features/customer/presentation/pages/appointment/components/booking_success_bottom_sheet.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_scaffold_widget.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text_field.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_sliding_button.dart';
import 'package:lisa_beauty_salon/core/services/loading_service.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_button.dart';

class AppointmentCheckoutPage extends StatefulWidget {
  const AppointmentCheckoutPage({super.key});

  @override
  State<AppointmentCheckoutPage> createState() => _AppointmentCheckoutPageState();
}

class _AppointmentCheckoutPageState extends State<AppointmentCheckoutPage> {
  final TextEditingController _promoController = TextEditingController();
  final ValueNotifier<bool> _isBackSelected = ValueNotifier(false);
  final ValueNotifier<int> _selectedPaymentIndex = ValueNotifier(0);

  @override
  void dispose() {
    _promoController.dispose();
    _isBackSelected.dispose();
    _selectedPaymentIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffoldWidget(
      useSafeArea: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CommonText(
            "Book Appointment",
            fontSize: 24,
            fontWeight: 600,
            color: AppColors.blackTwo,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const VerticalSpacing(24),
                  const SuggestionCardComponent(
                    name: "Bloom & Blade",
                    category: "Hair",
                    address: "6391 Elgin St. Celina, Delaware...",
                    providerType: "Salon",
                    rating: 5.0,
                    image: "assets/images/salon_one.png",
                  ),
                  const VerticalSpacing(24),
                  _buildSectionHeader(
                    "Date & Time",
                    trailing: "12 November, 09:00 AM",
                    trailingColor: AppColors.pinkTwo,
                  ),
                  const VerticalSpacing(24),
                  const CommonText(
                    "Services",
                    fontSize: 16,
                    fontWeight: 700,
                    color: AppColors.blackTwo,
                  ),
                  const VerticalSpacing(16),
                  _buildServiceRow("Nail", "\$8.00"),
                  const VerticalSpacing(12),
                  _buildServiceRow("Facial", "\$24.99"),
                  const VerticalSpacing(24),
                  const Divider(
                    color: AppColors.greyFour,
                    thickness: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CommonText(
                        "Total",
                        fontSize: 24,
                        fontWeight: 700,
                        color: AppColors.blackTwo,
                      ),
                      const CommonText(
                        "\$32.99",
                        fontSize: 24,
                        fontWeight: 700,
                        color: AppColors.pinkTwo,
                      ),
                    ],
                  ),
                  const Divider(
                    color: AppColors.greyFour,
                    thickness: 1,
                  ),
                  const VerticalSpacing(24),
                  const CommonText(
                    "Promo Code",
                    fontSize: 16,
                    fontWeight: 600,
                    color: AppColors.blackTwo,
                  ),
                  const VerticalSpacing(16),
                  _buildPromoCodeSection(),
                  const VerticalSpacing(24),
                  const CommonText(
                    "Notes",
                    fontSize: 16,
                    fontWeight: 700,
                    color: AppColors.blackTwo,
                  ),
                  const VerticalSpacing(12),
                  const CommonText(
                    "Lorem ipsum dolor sit amet consectetur. Cras tincidunt purus sed scelerisque.",
                    fontSize: 16,
                    fontWeight: 400,
                    color: AppColors.greyTwo,
                  ),
                  const VerticalSpacing(24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CommonText(
                        "Payment Method",
                        fontSize: 16,
                        fontWeight: 700,
                        color: AppColors.blackTwo,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(
                            RouteNames.customerAddAccount
                          );
                        },
                        child: Row(
                          children: [
                            const CommonText(
                              "Add",
                              fontSize: 16,
                              fontWeight: 500,
                              color: AppColors.greyTwo,
                            ),
                            const HorizontalSpacing(4),
                            const Icon(
                              Icons.add_circle_outline,
                              size: 20,
                              color: AppColors.greyTwo,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const VerticalSpacing(16),
                  _buildPaymentMethods(),
                  const VerticalSpacing(24),
                ],
              ),
            ),
          ),
          _buildBottomButtons(),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, {required String trailing, required Color trailingColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CommonText(
          title,
          fontSize: 16,
          fontWeight: 700,
          color: AppColors.blackTwo,
        ),
        CommonText(
          trailing,
          fontSize: 16,
          fontWeight: 700,
          color: trailingColor,
        ),
      ],
    );
  }

  Widget _buildServiceRow(String name, String price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CommonText(
          name,
          fontSize: 16,
          fontWeight: 400,
          color: AppColors.blackTwo,
        ),
        CommonText(
          price,
          fontSize: 16,
          fontWeight: 500,
          color: AppColors.pinkTwo,
        ),
      ],
    );
  }

  Widget _buildPromoCodeSection() {
    return Row(
      children: [
        Expanded(
          child: CommonTextField(
            controller: _promoController,
            hintText: "Enter Coupon Code",
            labelText: "Enter Coupon Code",
            fillColor: AppColors.whiteOne,
            borderColor: AppColors.greyOne,
            borderRadius: 12,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
        ),
        const HorizontalSpacing(12),
        CommonButton(
          onPressed: () {},
          text: "Apply",
          width: 100,
          height: 50,
          radius: 12,
          textFontSize: 16,
          textFontWeight: 600,
        ),
      ],
    );
  }

  Widget _buildPaymentMethods() {
    final List<Map<String, dynamic>> methods = [
      {"icon": Icons.credit_card, "name": "Eleanor", "type": "Mastercard", "color": Colors.red},
      {"icon": Icons.paypal, "name": "**** **** **** 5445", "type": "PayPal", "color": Colors.blue},
      {"icon": Icons.credit_card, "name": "**** **** **** 8295", "type": "Visa", "color": Colors.indigo},
    ];

    return ValueListenableBuilder<int>(
      valueListenable: _selectedPaymentIndex,
      builder: (context, selectedIndex, child) {
        return Column(
          children: List.generate(methods.length, (index) {
            final isSelected = index == selectedIndex;
            return GestureDetector(
              onTap: () => _selectedPaymentIndex.value = index,
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.whiteOne,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: isSelected ? AppColors.pinkTwo.withOpacity(0.5) : AppColors.greyOne),
                ),
                child: Row(
                  children: [
                    Icon(
                      methods[index]["icon"],
                      color: methods[index]["color"],
                      size: 32
                    ),
                    const HorizontalSpacing(16),
                    Expanded(
                      child: CommonText(
                        methods[index]["name"],
                        fontSize: 16,
                        fontWeight: 500,
                        color: isSelected ? AppColors.blackTwo
                            : AppColors.greyTwo,
                      ),
                    ),
                    Icon(
                      isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
                      color: isSelected ? AppColors.pinkTwo : AppColors.greyOne,
                    ),
                  ],
                ),
              ),
            );
          }),
        );
      },
    );
  }

  Widget _buildBottomButtons() {
    return CommonSlidingButton(
      valueListenable: _isBackSelected,
      leftLabel: "Back",
      rightLabel: "Checkout",
      onLeftTap: () => Get.back(),
      onRightTap: _handleCheckout,
      leftActiveColor: AppColors.whiteOne,
      rightActiveColor: AppColors.pinkTwo,
      leftActiveTextColor: AppColors.greyTwo,
      rightActiveTextColor: AppColors.whiteOne,
      inactiveTextColor: AppColors.greyTwo,
    );
  }

  void _handleCheckout() async {
    final loadingService = Get.find<LoadingService>();
    // Show loader
    loadingService.show();

    // Simulate payment processing delay
    await Future.delayed(const Duration(seconds: 2));

    // Close loader
    loadingService.hide();

    // Show Success Bottom Sheet
    Get.bottomSheet(
      const BookingSuccessBottomSheet(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: false,
      enableDrag: false,
    );
  }
}
