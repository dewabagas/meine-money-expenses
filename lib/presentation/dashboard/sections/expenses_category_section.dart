import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meine_money_expenses/presentation/core/constants/assets.dart';
import 'package:meine_money_expenses/presentation/core/constants/styles.dart';
import 'package:meine_money_expenses/presentation/core/styles/app_colors.dart';
import 'package:meine_money_expenses/presentation/core/utils/common_utils.dart';
import 'package:meine_money_expenses/presentation/core/utils/extension/double_extension.dart';
import 'package:meine_money_expenses/presentation/shared/cards/card_general.dart';

class ExpensesCategorySection extends StatefulWidget {
  const ExpensesCategorySection({super.key});

  @override
  State<ExpensesCategorySection> createState() =>
      _ExpensesCategorySectionState();
}

class _ExpensesCategorySectionState extends State<ExpensesCategorySection> {
  final List<Map<String, dynamic>> expensesCategory = [
    {'icon': AppIcons.icFoodsRounded, 'title': 'Makanan', 'total': 70000},
    {'icon': AppIcons.icInternetRounded, 'title': 'Internet', 'total': 50000},
    {
      'icon': AppIcons.icTransportRounded,
      'title': 'Transportasi',
      'total': 20000
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Text('Pengeluaran berdasarkan kategori',
              style: TextStyles.bold14),
        ),
        20.0.height,
        // _buildFeaturedCards(expensesCategory),
        SizedBox(
          height: 120.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: expensesCategory.length,
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              final item = expensesCategory[index];
              return CardGeneral(
                width: 120.w,
                margin: EdgeInsets.only(left: 20.w, top: 0.h, bottom: 0.h),
                // padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      item['icon'],
                    ),
                    12.0.height,
                    Text(item['title'],
                        style: TextStyles.regular12
                            .copyWith(color: AppColors.grey)),
                    8.0.height,
                    Text('Rp. ${formatRupiah(item['total'])}',
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

  Widget _buildFeaturedCards(List<Map<String, dynamic>> expense) {
    final List<Widget> cards = [];

    // Tambahkan setiap item expense ke dalam list widget cards
    for (int i = 0; i < expense.length; i++) {
      cards.add(
        Padding(
          padding: EdgeInsets.only(right: 16.w), // Tambahkan padding antar card
          child: CardGeneral(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(expense[i]['icon']),
                12.0.height,
                Text(
                  expense[i]['title'],
                  style: TextStyles.regular12.copyWith(color: AppColors.grey),
                ),
                8.0.height,
                Text(
                  'Rp. ${formatRupiah(expense[i]['total'])}',
                  style: TextStyles.bold12,
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Pengeluaran berdasarkan kategori', style: TextStyles.bold14),
        20.0.height,
        IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(children: cards),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
