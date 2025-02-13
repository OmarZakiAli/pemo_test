import 'package:dartz/dartz.dart';
import 'package:test_repo/features/transactions/data/get_transactions_action.dart';
import 'package:test_repo/features/transactions/domain/transaction_entity.dart';
import 'package:test_repo/features/transactions/domain/transactions_repo.dart';

class RemoteTransactionsRepo extends ITransactionsRepo {
  @override
  Future<Either<String, List<TransactionEntity>>> getTransactions() async {
    List<TransactionEntity> transactionEntities = [];
    String? errorMessage;
    try {
      var response = await GetTransactionsAction().execute();
      response!.fold((error) {
        errorMessage = error?.message;
      }, (date) {
        date?.forEach((item) {
          transactionEntities.add(TransactionEntity(
            id: item.id,
            name: item.name,
            image: item.image,
            merchant: item.merchant,
            billingAmount: item.billingAmount,
            date: item.date,
            billingCurrency: item.billingCurrency,
          ));
        });
      });
    } catch (e) {
      return Left(e.toString());
    }

    if (errorMessage != null) {
      return Left(errorMessage!);
    } else {
      return Right(transactionEntities);
    }
  }
}
