import 'package:flutter/material.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';

class CommonLoader extends StatelessWidget {
  const CommonLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.pinkTwo,
      ),
    );
  }
}
