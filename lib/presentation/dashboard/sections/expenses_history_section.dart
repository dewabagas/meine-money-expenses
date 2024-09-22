import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meine_money_expenses/presentation/core/constants/assets.dart';
import 'package:meine_money_expenses/presentation/core/constants/styles.dart';
import 'package:meine_money_expenses/presentation/core/utils/common_utils.dart';
import 'package:meine_money_expenses/presentation/core/utils/extension/double_extension.dart';
import 'package:meine_money_expenses/presentation/shared/cards/card_general.dart';

class ExpensesHistorySection extends StatefulWidget {
  const ExpensesHistorySection({super.key});

  @override
  State<ExpensesHistorySection> createState() => _ExpensesHistorySectionState();
}

class _ExpensesHistorySectionState extends State<ExpensesHistorySection> {
  final List<Map<String, dynamic>> expensesHistory = [
    {
      'icon': AppIcons.icFoodsColored,
      'title': 'Ayam Geprek',
      'total': 15000,
      'date': '2024-09-22'
    },
    {
      'icon': AppIcons.icTransportColored,
      'title': 'Gojek',
      'total': 15000,
      'date': '2024-09-21'
    },
    {
      'icon': AppIcons.icFoodsColored,
      'title': 'Nasi Goreng',
      'total': 20000,
      'date': '2024-09-21'
    },
  ];

  @override
  Widget build(BuildContext context) {
    Map<String, List<Map<String, dynamic>>> groupedExpenses = {};
    for (var expense in expensesHistory) {
      final date = expense['date'];
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
              // Date Header
              Text(formatDate(date), style: TextStyles.bold14), // Format date
              20.0.height,
              // List of expenses for the particular date
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
                            SvgPicture.asset(item['icon']),
                            14.0.width,
                            Text(item['title'], style: TextStyles.regular14),
                          ],
                        ),
                        Text('Rp. ${formatRupiah(item['total'])}',
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
}
