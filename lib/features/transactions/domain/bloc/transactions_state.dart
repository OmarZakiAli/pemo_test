import 'package:collection/collection.dart';

import '../transaction_entity.dart';

class TransactionsState {
  final List<TransactionEntity> transactions;
  final bool isLoading;
  final String? errorMessage;
  TransactionsState({
    this.transactions = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  Map<String, List<TransactionEntity>> groupedTransactions() {
    Map<String, List<TransactionEntity>> groupedTransactions = {};
    for (var transaction in transactions) {
      if (groupedTransactions[transaction.formattedDate] == null) {
        groupedTransactions[transaction.formattedDate] = [transaction];
      } else {
        groupedTransactions[transaction.formattedDate]?.add(transaction);
      }
    }
    return groupedTransactions;
  }

  TransactionsState copyWith({
    List<TransactionEntity>? transactions,
    bool? isLoading,
    String? errorMessage,
  }) {
    return TransactionsState(
      transactions: transactions ?? this.transactions,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  @override
  bool operator ==(covariant TransactionsState other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return listEquals(other.transactions, transactions) &&
        other.isLoading == isLoading &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode =>
      transactions.hashCode ^ isLoading.hashCode ^ errorMessage.hashCode;
}
