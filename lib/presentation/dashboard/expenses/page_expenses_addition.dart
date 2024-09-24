import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:meine_money_expenses/application/add_expense_cubit/add_expense_cubit.dart';
import 'package:meine_money_expenses/domain/expenses/entities/expense.dart';
import 'package:meine_money_expenses/infrastructure/expenses/repositories/expense_repository.dart';
import 'package:meine_money_expenses/injection.dart';
import 'package:meine_money_expenses/presentation/core/constants/assets.dart';
import 'package:meine_money_expenses/presentation/core/constants/strings.dart';
import 'package:meine_money_expenses/presentation/core/constants/styles.dart';
import 'package:meine_money_expenses/presentation/core/styles/app_colors.dart';
import 'package:meine_money_expenses/presentation/core/utils/common_utils.dart';
import 'package:meine_money_expenses/presentation/core/utils/extension/double_extension.dart';
import 'package:meine_money_expenses/presentation/routes/app_route_paths.dart';
import 'package:meine_money_expenses/presentation/shared/buttons/button_primary.dart';
import 'package:meine_money_expenses/presentation/shared/inputs/input_primary.dart';
import 'package:meine_money_expenses/presentation/shared/others/app_snack_bar.dart';
import 'package:meine_money_expenses/presentation/shared/others/custom_bottom_sheet.dart';
import 'package:meine_money_expenses/presentation/shared/pages/page_wrapper.dart';

class PageExpensesAddition extends StatefulWidget {
  const PageExpensesAddition({super.key});

  @override
  State<PageExpensesAddition> createState() => _PageExpensesAdditionState();
}

class _PageExpensesAdditionState extends State<PageExpensesAddition> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  bool isButtonDisabled = true;
  String? formattedDate;

  final List<Map<String, dynamic>> category = [
    {'icon': AppIcons.icFoodsRounded, 'name': 'Makanan'},
    {'icon': AppIcons.icInternetRounded, 'name': 'Internet'},
    {'icon': AppIcons.icEducationRounded, 'name': 'Edukasi'},
    {'icon': AppIcons.icGiftRounded, 'name': 'Hadiah'},
    {'icon': AppIcons.icTransportRounded, 'name': 'Transport'},
    {'icon': AppIcons.icShoppingRounded, 'name': 'Belanja'},
    {'icon': AppIcons.icHouseApplianceRounded, 'name': 'Alat Rumah'},
    {'icon': AppIcons.icSportRounded, 'name': 'Olahraga'},
    {'icon': AppIcons.icEntertainmentRounded, 'name': 'Hiburan'},
  ];

  String? selectedCategory;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void showCategoryBottomSheet() {
    CustomBottomSheet.showAutoHeightBottomSheet(
      context: context,
      child: Column(
        children: [
          24.0.height,
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Piih Kategori',
                style:
                    TextStyles.semibold14.copyWith(color: AppColors.darkGrey)),
            Icon(Icons.close, size: 18.w, color: AppColors.black)
          ]),
          27.0.height,
          GridView.builder(
            shrinkWrap: true,
            itemCount: category.length,
            padding: EdgeInsets.zero,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 0.0.h,
              crossAxisSpacing: 0.0.w,
              childAspectRatio: 1.2,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedCategory = category[index]['name'];
                    typeController.text = selectedCategory!;
                  });
                  Navigator.pop(context);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(category[index]['icon']),
                    4.0.height,
                    Text(category[index]['name'],
                        textAlign: TextAlign.center,
                        style: TextStyles.regular12
                            .copyWith(color: AppColors.grey)),
                  ],
                ),
              );
            },
          ),
          64.0.height,
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        dateController.text = formatFullDate(pickedDate.toString());
        formattedDate = formatDateDash(pickedDate.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddExpenseCubit>(
      create: (context) => getIt<AddExpenseCubit>(),
      child: BlocConsumer<AddExpenseCubit, AddExpenseState>(
        listener: (context, state) {
          state.maybeMap(
              loading: (value) => EasyLoading.show(),
              success: (value) {
                EasyLoading.dismiss();
                AppSnackBar.showSuccess(context, AppStrings.storeSuccess);
                GoRouter.of(context).pushReplacement(RoutePaths.dashboard);
              },
              failure: (value) {
                EasyLoading.dismiss();
                AppSnackBar.showError(context, value.error);
              },
              orElse: () {});
        },
        builder: (context, state) {
          return PageWrapper(
            appBarTitle: 'Tambah Pengeluaran Baru',
            child: Column(
              children: [
                20.0.height,
                InputPrimary(
                  hintText: 'Nama Pengeluaran',
                  controller: nameController,
                ),
                20.0.height,
                GestureDetector(
                  onTap: showCategoryBottomSheet,
                  child: AbsorbPointer(
                    child: InputPrimary(
                      hintText: 'Jenis Pengeluaran',
                      controller: typeController,
                      icon: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 13.h, horizontal: 14.w),
                        child: SvgPicture.asset(AppIcons.icChevronRightRounded),
                      ), // Icon for dropdown
                    ),
                  ),
                ),
                20.0.height,
                GestureDetector(
                    onTap: () => _selectDate(context),
                    child: AbsorbPointer(
                        child: InputPrimary(
                            controller: dateController,
                            hintText: 'Tanggal Transaksi',
                            icon: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 13.h, horizontal: 14.w),
                              child: SvgPicture.asset(
                                AppIcons.icCalendar,
                              ),
                            )))),
                20.0.height,
                InputPrimary(
                  hintText: 'Nominal',
                  controller: amountController,
                  inputFormatters: [
                    CurrencyTextInputFormatter.currency(
                        locale: 'id', decimalDigits: 0, symbol: '')
                  ],
                  keyboardType: TextInputType.number,
                ),
                32.0.height,
                ButtonPrimary(
                  title: 'Simpan',
                  // disable: isButtonDisabled,
                  onPressed: () {
                    final expense = Expense(
                      name: nameController.text,
                      category: typeController.text,
                      date: formattedDate ?? '',
                      amount:
                          int.parse(amountController.text.replaceAll('.', '')),
                    );

                    context.read<AddExpenseCubit>().addExpense(expense);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
