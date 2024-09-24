import 'package:meine_money_expenses/domain/expenses/entities/expense.dart';

abstract class IExpenseRepository {
  Future<void> addExpense(Expense expense);
  Future<List<Expense>> getAllExpenses();
  Future<List<Expense>> getExpensesByMonth(int year, int month);
}
