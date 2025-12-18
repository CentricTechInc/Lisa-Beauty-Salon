import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/assets.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/features/auth/data/dto/build_profile_dto.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';

class BankAccountTileComponent extends StatelessWidget {
  final BankAccountInfoDto bankAccount;
  final bool isSelected;
  final VoidCallback onSelect;

  const BankAccountTileComponent({
    required this.bankAccount,
    required this.isSelected,
    required this.onSelect,
    super.key,
  });

  String maskAccountNumber(String accountNumber) {
    if (accountNumber.length <= 4) return accountNumber;
    return '*' * (accountNumber.length - 4) +
        accountNumber.substring(accountNumber.length - 4);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 90,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.whiteOne,
          border: Border.all(
            color: isSelected ? AppColors.pinkTwo : AppColors.greyOne,
            width: 1.2,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.pinkTwo,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: SvgPicture.asset(
                    Assets.bankAccountSvgIcon,
                    width: 10,
                    height: 10,
                  ),
                ),
                HorizontalSpacing(10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      Strings.bankAccountText,
                      fontSize: 16,
                      fontWeight: 700,
                      color: AppColors.blackTwo,
                    ),
                    CommonText(
                      maskAccountNumber(bankAccount.accountNumber),
                      fontSize: 14,
                      fontWeight: 500,
                      color: AppColors.blackTwo,
                    ),
                  ],
                ),
              ],
            ),
            _RadioIndicator(isSelected: isSelected),
          ],
        ),
      ),
    );
  }
}

class _RadioIndicator extends StatelessWidget {
  final bool isSelected;

  const _RadioIndicator({required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? AppColors.pinkTwo : AppColors.whiteOne,
        border: Border.all(
          color: isSelected ? AppColors.pinkTwo : AppColors.greyOne,
          width: 2,
        ),
      ),
      child: isSelected
          ? Center(
              child: Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.whiteOne,
                ),
              ),
            )
          : null,
    );
  }
}
