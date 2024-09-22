import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meine_money_expenses/presentation/core/constants/styles.dart';
import 'package:meine_money_expenses/presentation/core/styles/app_colors.dart';
import 'package:meine_money_expenses/presentation/core/utils/extension/double_extension.dart';
import 'package:meine_money_expenses/presentation/dashboard/sections/expenses_category_section.dart';
import 'package:meine_money_expenses/presentation/dashboard/sections/expenses_history_section.dart';
import 'package:meine_money_expenses/presentation/dashboard/sections/header_section.dart';
import 'package:meine_money_expenses/presentation/dashboard/widgets/card_expense.dart';

class PageDashboard extends StatefulWidget {
  const PageDashboard({super.key});

  @override
  State<PageDashboard> createState() => _PageDashboardState();
}

class _PageDashboardState extends State<PageDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.0.height,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: const HeaderSection(),
              ),
              20.0.height,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    const Expanded(
                      child: CardExpense(
                        title: 'Pengeluaranmu hari ini',
                        subtitle: 'Rp. 30.000',
                        backgroundColor: AppColors.primary,
                      ),
                    ),
                    19.0.width,
                    const Expanded(
                      child: CardExpense(
                        title: 'Pengeluaranmu hari ini',
                        subtitle: 'Rp. 30.000',
                        backgroundColor: AppColors.secondary,
                      ),
                    )
                  ],
                ),
              ),
              20.0.height,
              ExpensesCategorySection(),
              20.0.height,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: ExpensesHistorySection(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
