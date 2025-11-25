import 'package:flutter/material.dart';
import 'package:lisa_beauty_saloon/shared/widgets/common_text.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CommonText(
            'Sign In Page',
            fontSize: 24,
            fontWeight: 400,
          ),
        ],
      ),
    );
  }
}
