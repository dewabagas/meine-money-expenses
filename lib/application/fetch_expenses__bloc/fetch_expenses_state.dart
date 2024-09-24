part of 'fetch_expenses_bloc.dart';

@freezed
class FetchExpensesState with _$FetchExpensesState {
  const factory FetchExpensesState.initial() = _Initial;
  const factory FetchExpensesState.loading() = _Loading;

  // Add a list of categorized expenses
  const factory FetchExpensesState.success({
    required double todayExpenses,
    required double monthExpenses,
    required double totalExpenses, // For all expenses
    required List<Expense> categorizedExpenses, // Grouped by category
  }) = _Success;

  const factory FetchExpensesState.failure(String error) = _Failure;
}
