import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meine_money_expenses/presentation/core/constants/styles.dart';
import 'package:meine_money_expenses/presentation/core/styles/app_colors.dart';
import 'package:meine_money_expenses/presentation/core/utils/extension/double_extension.dart';

class CardExpense extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final Color? backgroundColor;
  const CardExpense(
      {super.key, this.title, this.subtitle, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
      decoration: BoxDecoration(
          color: backgroundColor, borderRadius: BorderRadius.circular(12.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$title',
              style: TextStyles.semibold14.copyWith(color: AppColors.white)),
          14.0.height,
          Text('$subtitle',
              style: TextStyles.bold20
                  .copyWith(fontSize: 18.sp, color: AppColors.white))
        ],
      ),
    );
  }
}
