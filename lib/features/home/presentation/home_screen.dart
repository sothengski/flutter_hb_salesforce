import 'package:flutter/material.dart';
import 'package:flutter_hb_salesforce/router/app_router.dart';
import 'package:flutter_hb_salesforce/widgets/widgets.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          ActionTextButton(
            text: 'Logout',
            onPressed: () async {
              final goRouter = GoRouter.of(context);
              final logout = await showAlertDialog(
                context: context,
                title: 'Are you sure?',
                cancelActionText: 'Cancel',
                defaultActionText: 'Logout',
              );
              if (logout == true) {
                goRouter.pushReplacementNamed(AppRoute.login.name);
              }
            },
          ),
        ],
      ),

      body: const Center(child: Text('Flutter HB SalesForce!')),
    );
  }
}
