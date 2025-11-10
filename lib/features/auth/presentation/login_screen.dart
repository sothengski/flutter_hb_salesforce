import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_hb_salesforce/constants/constants.dart';
import 'package:flutter_hb_salesforce/layouts/layouts.dart';
import 'package:flutter_hb_salesforce/router/app_router.dart';
import 'package:flutter_hb_salesforce/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: ResponsiveScrollableCard(
        // maxContentWidth: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: Sizes.p24),
            ResponsiveCenter(
              child: Image.asset(
                AppImages.logoTransparent,
                width: 120,
                height: 120,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: Sizes.p32),
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(height: Sizes.p16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
            const SizedBox(height: Sizes.p24),
            SizedBox(
              width: double.infinity,
              child: PrimaryButton(
                text: 'Login',
                onPressed: () {
                  // Navigate to home screen
                  context.goNamed(AppRoute.home.name);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
