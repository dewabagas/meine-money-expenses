import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:meine_money_expenses/application/fetch_expenses__bloc/fetch_expenses_bloc.dart';
import 'package:meine_money_expenses/injection.dart';
import 'package:meine_money_expenses/presentation/core/styles/app_colors.dart';
import 'package:meine_money_expenses/presentation/core/utils/common_utils.dart';
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
    return BlocProvider<FetchExpensesBloc>(
      create: (context) => getIt<FetchExpensesBloc>()
        ..add(const FetchExpensesEvent.fetchAllExpenses()),
      child: Scaffold(
        backgroundColor: AppColors.white,
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add, color: AppColors.white),
          onPressed: () {
            GoRouter.of(context).push(RoutePaths.expensesAddition);
          },
        ),
        body: SingleChildScrollView(
          child: BlocBuilder<FetchExpensesBloc, FetchExpensesState>(
            builder: (context, state) {
              return state.map(
                  initial: (value) => const SizedBox.shrink(),
                  loading: (value) => const CircularProgressIndicator(),
                  success: (value) {
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
                                Expanded(
                                  child: CardExpense(
                                    title: 'Pengeluaranmu hari ini',
                                    subtitle:
                                        'Rp. ${formatRupiah(value.todayExpenses.toInt())}',
                                    backgroundColor: AppColors.primary,
                                  ),
                                ),
                                19.0.width,
                                Expanded(
                                  child: CardExpense(
                                    title: 'Pengeluaranmu hari ini',
                                    subtitle:
                                        'Rp. ${formatRupiah(value.monthExpenses.toInt())}',
                                    backgroundColor: AppColors.secondary,
                                  ),
                                )
                              ],
                            ),
                          ),
                          20.0.height,
                          ExpensesCategorySection(
                              expenses: value.categorizedExpenses),
                          10.0.height,
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: ExpensesHistorySection(
                                expenses: value.categorizedExpenses),
                          )
                        ],
                      ),
                    );
                  },
                  failure: (value) => Center(child: Text(value.error)));
            },
          ),
        ),
      ),
    );
  }
}
