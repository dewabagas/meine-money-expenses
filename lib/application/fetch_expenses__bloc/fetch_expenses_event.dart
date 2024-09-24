part of 'fetch_expenses_bloc.dart';

@freezed
class FetchExpensesEvent with _$FetchExpensesEvent {
  const factory FetchExpensesEvent.fetchAllExpenses() = _FetchAllExpenses;
}
