import 'package:get_it/get_it.dart';
import 'package:test_repo/features/cards/data/repo/cards_repo.dart';
import 'package:test_repo/features/cards/domain/bloc/cards_bloc.dart';
import 'package:test_repo/features/transactions/data/repo/transactions_repo.dart';
import 'package:test_repo/features/transactions/domain/bloc/transactions_bloc.dart';
import 'package:test_repo/features/transactions/domain/transactions_repo.dart';

import '../features/cards/domain/cards_repo.dart';

class Injection {
  static void injectDependencies() {
    // here dependency is added as abstraction to dependency inversion princible in solid and its going to make mocks easier later in testing
    GetIt.instance.registerLazySingleton<ICardsRepository>(() => CardsRepo());
    GetIt.instance.registerLazySingleton(() => CardsBloc());

    GetIt.instance
        .registerLazySingleton<ITransactionsRepo>(() => TransactionsRepo());
    GetIt.instance.registerLazySingleton(() => TransactionsBloc());
  }
}
