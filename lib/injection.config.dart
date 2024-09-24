// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:hive/hive.dart' as _i979;
import 'package:injectable/injectable.dart' as _i526;
import 'package:meine_money_expenses/application/add_expense_cubit/add_expense_cubit.dart'
    as _i186;
import 'package:meine_money_expenses/application/fetch_expenses_cubit/fetch_expenses_cubit.dart'
    as _i392;
import 'package:meine_money_expenses/domain/expenses/interfaces/i_expense_repository.dart'
    as _i722;
import 'package:meine_money_expenses/infrastructure/expenses/repositories/expense_repository.dart'
    as _i357;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i722.IExpenseRepository>(
        () => _i357.ExpenseRepository(gh<_i979.Box<dynamic>>()));
    gh.factory<_i186.AddExpenseCubit>(
        () => _i186.AddExpenseCubit(gh<_i722.IExpenseRepository>()));
    gh.factory<_i392.FetchExpensesCubit>(
        () => _i392.FetchExpensesCubit(gh<_i722.IExpenseRepository>()));
    return this;
  }
}
