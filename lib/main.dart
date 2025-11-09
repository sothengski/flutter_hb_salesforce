import 'package:flutter/material.dart';
import 'package:flutter_hb_salesforce/router/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Modular Todo App',
      theme: ThemeData(primarySwatch: Colors.blue),
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
