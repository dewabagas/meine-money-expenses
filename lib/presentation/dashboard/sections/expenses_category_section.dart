import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meine_money_expenses/domain/expenses/entities/expense.dart';
import 'package:meine_money_expenses/presentation/core/constants/assets.dart';
import 'package:meine_money_expenses/presentation/core/constants/styles.dart';
import 'package:meine_money_expenses/presentation/core/styles/app_colors.dart';
import 'package:meine_money_expenses/presentation/core/utils/common_utils.dart';
import 'package:meine_money_expenses/presentation/core/utils/extension/double_extension.dart';
import 'package:meine_money_expenses/presentation/shared/cards/card_general.dart';

class ExpensesCategorySection extends StatefulWidget {
  final List<Expense> expenses;

  const ExpensesCategorySection({super.key, required this.expenses});

  @override
  State<ExpensesCategorySection> createState() =>
      _ExpensesCategorySectionState();
}

class _ExpensesCategorySectionState extends State<ExpensesCategorySection> {
  @override
  Widget build(BuildContext context) {
    final groupedExpenses = _groupExpensesByCategory(widget.expenses);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Text('Pengeluaran berdasarkan kategori',
              style: TextStyles.bold14),
        ),
        20.0.height,
        SizedBox(
          height: 160.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: groupedExpenses.length,
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              final category = groupedExpenses.keys.toList()[index];
              final totalAmount = groupedExpenses[category]!
                  .fold(0.0, (sum, expense) => sum + expense.amount);
              final iconPath = _getIconPathForCategory(category);

              return CardGeneral(
                width: 120.w,
                margin: EdgeInsets.only(left: 20.w, top: 10.h, bottom: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(iconPath),
                    12.0.height,
                    Text(category,
                        style: TextStyles.regular12
                            .copyWith(color: AppColors.grey)),
                    8.0.height,
                    Text('Rp. ${formatRupiah(totalAmount.toInt())}',
                        style: TextStyles.bold12),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Map<String, List<Expense>> _groupExpensesByCategory(List<Expense> expenses) {
    final Map<String, List<Expense>> grouped = {};

    for (var expense in expenses) {
      if (grouped.containsKey(expense.category)) {
        grouped[expense.category]!.add(expense);
      } else {
        grouped[expense.category] = [expense];
      }
    }

    return grouped;
  }

  String _getIconPathForCategory(String category) {
    switch (category.toLowerCase()) {
      case 'makanan':
        return AppIcons.icFoodsRounded;
      case 'hiburan':
        return AppIcons.icEntertainmentRounded;
      case 'pendidikan':
        return AppIcons.icEducationRounded;
      case 'belanja':
        return AppIcons.icShoppingRounded;
      case 'internet':
        return AppIcons.icInternetRounded;
      case 'transport':
        return AppIcons.icTransportRounded;
      case 'hadiah':
        return AppIcons.icGiftRounded;
      case 'peralatan rumah':
        return AppIcons.icHouseApplianceRounded;
      case 'olahraga':
        return AppIcons.icSportRounded;
      default:
        return AppIcons.icCalendar;
    }
  }
}
