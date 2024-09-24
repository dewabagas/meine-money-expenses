import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:meine_money_expenses/domain/expenses/entities/expense.dart';
import 'package:meine_money_expenses/domain/expenses/interfaces/i_expense_repository.dart';

part 'fetch_expenses_event.dart';
part 'fetch_expenses_state.dart';
part 'fetch_expenses_bloc.freezed.dart';

@injectable
class FetchExpensesBloc extends Bloc<FetchExpensesEvent, FetchExpensesState> {
  final IExpenseRepository expenseRepository;

  FetchExpensesBloc(this.expenseRepository)
      : super(const FetchExpensesState.initial()) {
    on<_FetchAllExpenses>(_onFetchAllExpenses);
  }

  Future<void> _onFetchAllExpenses(
    _FetchAllExpenses event,
    Emitter<FetchExpensesState> emit,
  ) async {
    emit(const FetchExpensesState.loading());
    try {
      final now = DateTime.now();
      final expenses = await expenseRepository.getAllExpenses();
      final categorizedExpenses = _categorizeExpenses(expenses);
      final todayExpenses = expenses
          .where((expense) => isSameDay(expense.dateAsDateTime, now))
          .fold(0.0, (sum, expense) => sum + expense.amount);
      final monthExpenses =
          expenses.fold(0.0, (sum, expense) => sum + expense.amount);
      final totalExpenses =
          expenses.fold(0.0, (sum, expense) => sum + expense.amount);

      emit(FetchExpensesState.success(
        todayExpenses: todayExpenses,
        monthExpenses: monthExpenses,
        totalExpenses: totalExpenses,
        categorizedExpenses: categorizedExpenses,
      ));
    } catch (e) {
      emit(FetchExpensesState.failure(e.toString()));
    }
  }

  List<Expense> _categorizeExpenses(List<Expense> expenses) {
    return expenses;
  }

  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
