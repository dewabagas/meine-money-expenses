import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:meine_money_expenses/domain/expenses/entities/expense.dart';
import 'package:meine_money_expenses/domain/expenses/interfaces/i_expense_repository.dart';

part 'add_expense_state.dart';
part 'add_expense_cubit.freezed.dart';

@injectable
class AddExpenseCubit extends Cubit<AddExpenseState> {
  final IExpenseRepository expenseRepository;

  AddExpenseCubit(this.expenseRepository)
      : super(const AddExpenseState.initial());

  Future<void> addExpense(Expense expense) async {
    emit(const AddExpenseState.loading());

    try {
      await expenseRepository.addExpense(expense);
      emit(const AddExpenseState.success());
    } catch (e) {
      emit(AddExpenseState.failure(e.toString()));
    }
  }
}
