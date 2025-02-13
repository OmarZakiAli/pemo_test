import 'package:dartz/dartz.dart';
import 'package:test_repo/features/transactions/data/repo/local_transactions_repo.dart';
import 'package:test_repo/features/transactions/data/repo/remote_transactions_repo.dart';

import 'package:test_repo/features/transactions/domain/transaction_entity.dart';

import '../../domain/transactions_repo.dart';

class TransactionsRepo extends ITransactionsRepo {
  final RemoteTransactionsRepo _remoteTransactionsRepo =
      RemoteTransactionsRepo();
  final LocalTransactionsRepo _localTransactionsRepo = LocalTransactionsRepo();

  @override
  Future<Either<String, List<TransactionEntity>>> getTransactions() async {
    List<TransactionEntity> transactions = [];
    String? errorMessage;

    //here we get data from remote source and save it to local source , if remote source is not available we get data from local source
    var remoteResponse = await _remoteTransactionsRepo.getTransactions();

    await remoteResponse.fold((error) async {
      await _localTransactionsRepo.getTransactions().then((localResponse) {
        localResponse.fold((error1) {
          errorMessage = error1;
        }, (data) {
          if (data.isEmpty) {
            errorMessage = error;
          } else {
            transactions = data;
          }
        });
      });
    }, (data) async {
      transactions = data;
      _localTransactionsRepo.saveTransactions(transactions);
    });

    if (errorMessage != null) {
      return Left(errorMessage!);
    } else {
      return Right(transactions);
    }
  }
}
