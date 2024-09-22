import 'package:flutter/material.dart';
import 'package:meine_money_expenses/presentation/core/styles/app_colors.dart';

class PageSplash extends StatelessWidget {
  const PageSplash({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Center(child: Icon(Icons.money_sharp)),
      ),
    );
  }
}
