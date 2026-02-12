import 'package:flutter/material.dart';
import 'package:stupass_frontend/features/auth/presentation/welcome_page.dart';
import 'package:stupass_frontend/features/home/presentation/marketplace_page.dart';

void main() {
  runApp(const StuPassApp());
}
class StuPassApp extends StatelessWidget {
  const StuPassApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StuPass',
      debugShowCheckedModeBanner: false, 
      home: const MarketplacePage(),
    );
  }
}
