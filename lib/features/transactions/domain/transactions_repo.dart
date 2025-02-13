import 'package:dartz/dartz.dart';

import 'transaction_entity.dart';

abstract class ITransactionsRepo {
  Future<Either<String, List<TransactionEntity>>> getTransactions();
}
