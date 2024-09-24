import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:meine_money_expenses/domain/expenses/entities/expense.dart';
import 'package:meine_money_expenses/domain/expenses/interfaces/i_expense_repository.dart';

@LazySingleton(as: IExpenseRepository)
class ExpenseRepository implements IExpenseRepository {
  final Box expenseBox;

  ExpenseRepository(this.expenseBox);

  @override
  Future<void> addExpense(Expense expense) async {
    await expenseBox.add({
      'name': expense.name,
      'category': expense.category,
      'date': expense.date,
      'amount': expense.amount,
    });
  }

  @override
  Future<List<Expense>> getAllExpenses() async {
    final expenses = expenseBox.values
        .map((e) => Expense(
              name: e['name'],
              category: e['category'],
              date: e['date'],
              amount: e['amount'],
            ))
        .toList();
    return expenses;
  }

  @override
  Future<List<Expense>> getExpensesByMonth(int year, int month) async {
    final expenses = expenseBox.values
        .map((e) => Expense.fromMap(Map<String, dynamic>.from(e)))
        .where((expense) {
      final expenseDate =
          expense.dateAsDateTime; // Konversi date String ke DateTime
      return expenseDate.year == year && expenseDate.month == month;
    }).toList();
    return expenses;
  }
}
