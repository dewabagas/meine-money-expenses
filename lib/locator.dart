import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:meine_money_expenses/presentation/routes/app_router.dart';

GetIt locator = GetIt.instance;

Future<void> initializeDependencies() async {
  locator.registerLazySingleton(() => AppRouter());

  final expenseBox = await Hive.openBox('expensesBox');
  locator.registerSingleton<Box>(expenseBox);
}
