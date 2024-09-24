import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:meine_money_expenses/application/fetch_expenses_cubit/fetch_expenses_cubit.dart';
import 'package:meine_money_expenses/domain/expenses/interfaces/i_expense_repository.dart';
import 'package:meine_money_expenses/infrastructure/expenses/repositories/expense_repository.dart';
import 'package:meine_money_expenses/injection.dart';
import 'package:meine_money_expenses/presentation/core/styles/app_colors.dart';
import 'package:meine_money_expenses/presentation/core/utils/extension/double_extension.dart';
import 'package:meine_money_expenses/presentation/dashboard/sections/expenses_category_section.dart';
import 'package:meine_money_expenses/presentation/dashboard/sections/expenses_history_section.dart';
import 'package:meine_money_expenses/presentation/dashboard/sections/header_section.dart';
import 'package:meine_money_expenses/presentation/dashboard/widgets/card_expense.dart';
import 'package:meine_money_expenses/presentation/routes/app_route_paths.dart';

class PageDashboard extends StatefulWidget {
  const PageDashboard({super.key});

  @override
  State<PageDashboard> createState() => _PageDashboardState();
}

class _PageDashboardState extends State<PageDashboard> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<FetchExpensesCubit>(
      create: (context) =>
          getIt<FetchExpensesCubit>()..fetchThisMonthExpenses(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add, color: AppColors.white),
          onPressed: () {
            GoRouter.of(context).push(RoutePaths.expensesAddition);
          },
        ),
        body: BlocBuilder<FetchExpensesCubit, FetchExpensesState>(
          builder: (context, state) {
            return state.map(
                initial: (value) => const SizedBox.shrink(),
                loading: (value) => const SizedBox.shrink(),
                success: (value) {
                  log('valueee ${value.monthExpenses}');
                  log('valueee ${value.todayExpenses}');
                  return SafeArea(
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
                  );
                },
                failure: (value) => Center(child: Text(value.error)));
          },
        ),
      ),
    );
  }
}
