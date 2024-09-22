import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meine_money_expenses/presentation/core/constants/styles.dart';
import 'package:meine_money_expenses/presentation/core/styles/app_colors.dart';
import 'package:meine_money_expenses/presentation/core/utils/extension/double_extension.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Halo, User!', style: TextStyles.bold20.copyWith(fontSize: 18.sp)),
        4.0.height,
        Text('Jangan lupa catat keuanganmu setiap hari!',
            style: TextStyles.regular14.copyWith(color: AppColors.grey)),
      ],
    );
  }
}
