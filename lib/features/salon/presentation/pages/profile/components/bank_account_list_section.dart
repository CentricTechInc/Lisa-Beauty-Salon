import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/features/auth/presentation/controllers/auth_controller.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';
import 'bank_account_tile_component.dart';

class BankAccountListSection extends StatelessWidget {
  const BankAccountListSection({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VerticalSpacing(20),
        Center(
          child: CommonText(
            Strings.addYourBankInfoText,
            fontSize: 20,
            fontWeight: 700,
            color: AppColors.blackTwo,
          ),
        ),
        VerticalSpacing(20),
        Center(
          child: CommonText(
            Strings.platformServiceFeeText,
            fontSize: 16,
            fontWeight: 400,
            color: AppColors.greyTwo,
            textOverflow: TextOverflow.visible,
            maxLines: 4,
            textAlign: TextAlign.center,
          ),
        ),
        VerticalSpacing(40),
        Obx(() {
          final bankAccounts =
              authController.buildProfileData?.bankAccounts ?? [];
          // Explicitly access the observable value here so Obx tracks it
          final _ = authController.selectedBankAccountIndex.value;

          if (bankAccounts.isEmpty) {
            return const SizedBox.shrink();
          }

          return ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: bankAccounts.length,
            separatorBuilder: (context, index) => VerticalSpacing(12),
            itemBuilder: (context, index) {
              return BankAccountTileComponent(
                bankAccount: bankAccounts[index],
                isSelected:
                    authController.selectedBankAccountIndex.value == index,
                onSelect: () => authController.selectBankAccount(index),
              );
            },
          );
        }),
      ],
    );
  }
}
