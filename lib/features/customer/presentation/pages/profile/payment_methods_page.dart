import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/core/constants/route_constants.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/features/customer/presentation/pages/profile/components/close_account_dialog.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_scaffold_widget.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_button.dart';

class CustomerPaymentMethodsPage extends StatefulWidget {
  const CustomerPaymentMethodsPage({super.key});

  @override
  State<CustomerPaymentMethodsPage> createState() => _CustomerPaymentMethodsPageState();
}

class _CustomerPaymentMethodsPageState extends State<CustomerPaymentMethodsPage> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _methods = [
    {
      "icon": Icons.credit_card,
      "name": "Eleanor",
      "type": "Mastercard",
      "color": Colors.red,
    },
    {
      "icon": Icons.paypal,
      "name": "**** **** **** 5445",
      "type": "PayPal",
      "color": Colors.blue,
    },
    {
      "icon": Icons.credit_card,
      "name": "**** **** **** 8295",
      "type": "Visa",
      "color": Colors.indigo,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return CommonScaffoldWidget(
      bgColor: AppColors.whiteTwo,
      systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: AppColors.whiteTwo,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const VerticalSpacing(30),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const VerticalSpacing(20),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20
                  ),
                  child: const CommonText(
                    "Select to set as your default account for payments.",
                    fontSize: 14,
                    fontWeight: 400,
                    color: AppColors.greyTwo,
                    textOverflow: TextOverflow.visible,
                    maxLines: 3,
                    textAlign: TextAlign.center,
                  ),
                ),
                const VerticalSpacing(32),
                ...List.generate(_methods.length, (index) {
                  final isSelected = _selectedIndex == index;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedIndex = index),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.whiteOne,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected ? AppColors.pinkTwo : AppColors.greyOne,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            _methods[index]["icon"],
                            color: _methods[index]["color"],
                            size: 32,
                          ),
                          const HorizontalSpacing(16),
                          Expanded(
                            child: CommonText(
                              _methods[index]["name"],
                              fontSize: 16,
                              fontWeight: 500,
                              color: isSelected ? AppColors.blackTwo : AppColors.greyTwo,
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
                const Spacer(),
                CommonButton(
                  onPressed: () {
                    Get.dialog(
                      const CustomerCloseAccountDialog()
                    );
                  },
                  text: "Delete Account",
                  width: double.infinity,
                  backgroundColor: AppColors.whiteOne,
                  textColor: AppColors.blackTwo,
                  borderColor: AppColors.greyOne,
                ),
                const VerticalSpacing(16),
                CommonButton(
                  onPressed: () => Get.toNamed(RouteNames.customerAddAccount),
                  text: "Add Account",
                  width: double.infinity,
                  backgroundColor: AppColors.pinkTwo,
                ),
                const VerticalSpacing(50),
              ],
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
          "Payment Methods",
          fontSize: 24,
          fontWeight: 600,
          color: AppColors.blackTwo,
        ),
      ],
    );
  }
}
