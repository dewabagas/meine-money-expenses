part of 'fetch_expenses_cubit.dart';

@freezed
class FetchExpensesState with _$FetchExpensesState {
  const factory FetchExpensesState.initial() = _Initial;
  const factory FetchExpensesState.loading() = _Loading;
  const factory FetchExpensesState.success({
    required double todayExpenses,
    required double monthExpenses,
  }) = _Success;
  const factory FetchExpensesState.failure(String error) = _Failure;
}
