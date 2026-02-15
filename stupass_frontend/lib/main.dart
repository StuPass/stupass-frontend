import 'package:flutter/material.dart';
import 'package:stupass_frontend/core/router/router.dart';

void main() {
  runApp(const StuPassApp());
}

class StuPassApp extends StatelessWidget {
  const StuPassApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: "StuPass",
    );
  }
}