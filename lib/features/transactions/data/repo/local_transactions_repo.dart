import 'package:dartz/dartz.dart';
import 'package:hive_ce/hive.dart';
import 'package:test_repo/core/app_consts.dart';
import 'package:test_repo/features/transactions/data/dto/transaction_dto.dart';

import 'package:test_repo/features/transactions/domain/transaction_entity.dart';

import '../../domain/transactions_repo.dart';

class LocalTransactionsRepo extends ITransactionsRepo {
  @override
  Future<Either<String, List<TransactionEntity>>> getTransactions() async {
    try {
      List<TransactionDto> transactions =
          Hive.box<TransactionDto>(AppConsts.transactionBox).values.toList();
      List<TransactionEntity> transactionEntities =
          transactions.map((transaction) {
        return TransactionEntity(
          id: transaction.id,
          name: transaction.name,
          image: transaction.image,
          merchant: transaction.merchant,
          billingAmount: transaction.billingAmount,
          date: transaction.date,
          billingCurrency: transaction.billingCurrency,
        );
      }).toList();

      return Right(transactionEntities);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, void>> saveTransactions(
      List<TransactionEntity> transactions) async {
    try {
      List<TransactionDto> transactionDtos = transactions.map((transaction) {
        return TransactionDto(
            id: transaction.id,
            name: transaction.name,
            image: transaction.image,
            merchant: transaction.merchant,
            billingAmount: transaction.billingAmount,
            date: transaction.date,
            billingCurrency: transaction.billingCurrency);
      }).toList();

      for (var trans in transactionDtos) {
        // here we use put with key to make data not duplicate and update if exist
        await Hive.box<TransactionDto>(AppConsts.transactionBox)
            .put(trans.id, trans);
      }
      return Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
