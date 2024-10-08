import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:meine_money_expenses/domain/expenses/entities/expense.dart';
import 'package:meine_money_expenses/presentation/core/constants/assets.dart';
import 'package:meine_money_expenses/presentation/core/constants/styles.dart';
import 'package:meine_money_expenses/presentation/core/utils/common_utils.dart';
import 'package:meine_money_expenses/presentation/core/utils/extension/double_extension.dart';
import 'package:meine_money_expenses/presentation/shared/cards/card_general.dart';

class ExpensesHistorySection extends StatefulWidget {
  final List<Expense> expenses;
  const ExpensesHistorySection({super.key, required this.expenses});

  @override
  State<ExpensesHistorySection> createState() => _ExpensesHistorySectionState();
}

class _ExpensesHistorySectionState extends State<ExpensesHistorySection> {
  @override
  Widget build(BuildContext context) {
    Map<String, List<Expense>> groupedExpenses = {};
    for (var expense in widget.expenses) {
      final date = formatDate(expense.dateAsDateTime);
      if (!groupedExpenses.containsKey(date)) {
        groupedExpenses[date] = [];
      }
      groupedExpenses[date]!.add(expense);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var date in groupedExpenses.keys)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(date, style: TextStyles.bold14),
              20.0.height,
              ListView.builder(
                itemCount: groupedExpenses[date]!.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  final item = groupedExpenses[date]![index];
                  return CardGeneral(
                    margin: EdgeInsets.only(bottom: 20.h),
                    borderRadius: BorderRadius.circular(12.r),
                    padding:
                        EdgeInsets.symmetric(horizontal: 14.w, vertical: 22.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                                _getIconPathForCategory(item.category)),
                            14.0.width,
                            Text(item.name, style: TextStyles.regular14),
                          ],
                        ),
                        Text('Rp. ${formatRupiah(item.amount)}',
                            style: TextStyles.semibold14),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
      ],
    );
  }

  String formatDate(DateTime date) {
    final now = DateTime.now();
    final formatter = DateFormat('d MMM yyyy');

    if (isSameDay(date, now)) {
      return 'Hari Ini';
    } else if (isSameDay(date, now.subtract(Duration(days: 1)))) {
      return 'Kemarin';
    } else {
      return formatter.format(date);
    }
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  String _getIconPathForCategory(String category) {
    switch (category.toLowerCase()) {
      case 'makanan':
        return AppIcons.icFoodsColored;
      case 'hiburan':
        return AppIcons.icEntertainment;
      case 'edukasi':
        return AppIcons.icEducationRounded;
      case 'belanja':
        return AppIcons.icShoppingRounded;
      case 'internet':
        return AppIcons.icInternetColored;
      case 'transport':
        return AppIcons.icTransportColored;
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
