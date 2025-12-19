import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';

class CommonBottomBar extends StatelessWidget {
  final int currentIndex;
  final List<Widget> items;
  final ValueChanged<int> onTap;

  const CommonBottomBar({
    super.key,
    required this.currentIndex,
    required this.items,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      margin: const EdgeInsets.fromLTRB(
        16, 0, 16, 24
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 10
      ),
      decoration: BoxDecoration(
        color: AppColors.blackThree,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          items.length,
          (index) => _BottomBarButton(
            item: items[index],
            isSelected: currentIndex == index,
            onTap: () => onTap(index),
          ),
        ),
      ),
    );
  }
}

class _BottomBarButton extends StatelessWidget {
  final Widget item;
  final bool isSelected;
  final VoidCallback onTap;

  const _BottomBarButton({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isAssetTypeIcon = item is SvgPicture;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(
          milliseconds: 250
        ),
        curve: Curves.easeOut,
        padding: EdgeInsets.symmetric(
          horizontal: isAssetTypeIcon ? 14 : 0,
          vertical: isAssetTypeIcon ? 10 : 0
        ),
        decoration: BoxDecoration(
          color: isSelected ?
            isAssetTypeIcon ? AppColors.pinkTwo : AppColors.transparent : AppColors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: item,
        ),
      ),
    );
  }
}