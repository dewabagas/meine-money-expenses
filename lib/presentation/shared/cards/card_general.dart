import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meine_money_expenses/presentation/core/styles/app_colors.dart';

class CardGeneral extends StatelessWidget {
  final Widget child;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Color? color;
  final BorderRadiusGeometry? borderRadius;
  final double? height;
  final double? width;
  final Function()? onTap;
  final bool? hasShadow;
  final double shadowOpacity;
  final double? borderWidth;
  final Color? borderColor;
  final double? shadowBlurRadius;
  final Offset? shadowOffset;
  final double? shadowSpreadRadius;
  final Color? shadowColor;

  const CardGeneral(
      {super.key,
      required this.child,
      this.margin,
      this.padding,
      this.color,
      this.borderRadius,
      this.height,
      this.width,
      this.onTap,
      this.hasShadow = true,
      this.shadowOpacity = 0.08,
      this.borderWidth,
      this.borderColor,
      this.shadowBlurRadius,
      this.shadowOffset,
      this.shadowSpreadRadius,
      this.shadowColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: margin ?? EdgeInsets.zero,
        padding:
            padding ?? EdgeInsets.symmetric(vertical: 12.h, horizontal: 14.h),
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color ?? Colors.white,
          borderRadius: borderRadius ?? BorderRadius.circular(8.r),
          boxShadow: hasShadow == true
              ? [
                  BoxShadow(
                    offset: shadowOffset ?? const Offset(0, 4),
                    blurRadius: shadowBlurRadius ?? 8,
                    spreadRadius: shadowSpreadRadius ?? 4,
                    color: shadowColor ??
                        AppColors.black.withOpacity(shadowOpacity),
                  )
                ]
              : null,
          border: borderWidth != null && borderColor != null
              ? Border.all(
                  width: borderWidth!,
                  color: borderColor!,
                )
              : null,
        ),
        child: child,
      ),
    );
  }
}
