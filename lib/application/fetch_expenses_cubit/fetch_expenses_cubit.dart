import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:meine_money_expenses/domain/expenses/interfaces/i_expense_repository.dart';

part 'fetch_expenses_state.dart';
part 'fetch_expenses_cubit.freezed.dart';

@injectable
class FetchExpensesCubit extends Cubit<FetchExpensesState> {
  final IExpenseRepository expenseRepository;

  FetchExpensesCubit(this.expenseRepository)
      : super(const FetchExpensesState.initial());

  Future<void> fetchThisMonthExpenses() async {
    emit(const FetchExpensesState.loading());

    try {
      final now = DateTime.now();
      final expenses =
          await expenseRepository.getExpensesByMonth(now.year, now.month);

      // Hitung total pengeluaran hari ini
      final todayExpenses = expenses
          .where((expense) => isSameDay(
              expense.dateAsDateTime, now)) // Konversi String ke DateTime
          .fold(0.0, (sum, expense) => sum + expense.amount);

      // Hitung total pengeluaran bulan ini
      final monthExpenses =
          expenses.fold(0.0, (sum, expense) => sum + expense.amount);

      emit(FetchExpensesState.success(
          todayExpenses: todayExpenses, monthExpenses: monthExpenses));
    } catch (e) {
      emit(FetchExpensesState.failure(e.toString()));
    }
  }

  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
