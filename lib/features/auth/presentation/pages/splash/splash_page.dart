import 'package:flutter/material.dart';
import 'package:lisa_beauty_saloon/shared/widgets/common_text.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CommonText(
            'Splash Page',
            fontSize: 24,
            fontWeight: 400,
          ),
        ],
      ),
    );
  }
}
