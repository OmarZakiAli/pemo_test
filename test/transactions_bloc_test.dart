import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_repo/features/transactions/domain/bloc/transactions_bloc.dart';
import 'package:test_repo/features/transactions/domain/transactions_repo.dart';

import 'fake_models.dart';

class MockTransactionsRepository extends Mock implements ITransactionsRepo {}

void main() {
  final MockTransactionsRepository transactionsRepo =
      MockTransactionsRepository();
  late TransactionsBloc bloc;
  //here we make our dependency injection to inject mock repositories instead of real ones
  setUp(() {
    GetIt.instance.reset();
    GetIt.instance
        .registerLazySingleton<ITransactionsRepo>(() => transactionsRepo);
    GetIt.instance
        .registerLazySingleton<TransactionsBloc>(() => TransactionsBloc());
    bloc = GetIt.instance.get<TransactionsBloc>();
    // here we reset the mock interactions
    reset(GetIt.instance.get<ITransactionsRepo>());
  });

  group("test get transactions", () {
    test("test get transactions works when error", () async {
      when(() => transactionsRepo.getTransactions())
          .thenAnswer((_) async => Left("error retrieving transactions"));
      expect(bloc.state.transactions.isEmpty, true);
      expect(bloc.state.errorMessage, isNull);
      await bloc.getTransactions();
      expect(bloc.state.transactions.isEmpty, true);
      expect(bloc.state.errorMessage, isNotNull);
    });

    test("test get transactions works when has data", () async {
      when(() => transactionsRepo.getTransactions())
          .thenAnswer((_) async => Right(FakeModels.fakeTransactions));
      expect(bloc.state.transactions.isEmpty, true);
      expect(bloc.state.errorMessage, isNull);
      await bloc.getTransactions();
      expect(bloc.state.transactions.isNotEmpty, true);
      expect(bloc.state.errorMessage, isNull);
    });
  });
}
