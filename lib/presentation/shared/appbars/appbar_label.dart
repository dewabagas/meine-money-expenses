import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meine_money_expenses/presentation/core/constants/styles.dart';
import 'package:meine_money_expenses/presentation/core/styles/app_colors.dart';

AppBar appbarLabel(
    {Function? onBackPressed,
    String? title,
    List<Widget>? actions,
    bool hasBack = true}) {
  return AppBar(
    leading: hasBack
        ? IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: onBackPressed as void Function()?)
        : const SizedBox.shrink(),
    title: Text(
      title ?? '',
      style: TextStyles.semibold14.copyWith(color: AppColors.white),
    ),
    centerTitle: true,
    backgroundColor: AppColors.secondary,
    actions: actions,
    elevation: 0,
  );
}

AppBar appbarLabelAlternative(
    {Function? onBackPressed,
    String? title,
    List<Widget>? actions,
    Color? backgroundColor,
    Color? titleColor,
    Color? borderColor,
    Color? iconColor,
    bool hasBack = true}) {
  return AppBar(
    leading: hasBack
        ? IconButton(
            onPressed: onBackPressed as void Function()?,
            icon: Icon(
              Icons.chevron_left,
              color: iconColor ?? AppColors.neutralDark,
              size: 36.w,
            ),
          )
        : const SizedBox.shrink(),
    title: Text(
      title ?? '',
      style: TextStyles.bold20.copyWith(
          color: titleColor ?? AppColors.neutralDark, fontSize: 18.sp),
    ),
    centerTitle: true,
    backgroundColor: backgroundColor ?? AppColors.bgLight,
    actions: actions,
    elevation: 0,
  );
}
