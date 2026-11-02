import 'package:flutter/material.dart';
import 'package:lu_student_resource_hub/dashboard_page.dart';
//import 'login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LU Student Resource Hub',
      theme: ThemeData.dark(),
      //home: const LoginPage(),
      home: DashboardPage(),
    );
  }
}
