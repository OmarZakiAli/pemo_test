import 'package:test_repo/features/cards/domain/card_entity.dart';
import 'package:test_repo/features/transactions/domain/transaction_entity.dart';

class FakeModels {
  static CardEntity validCard = CardEntity(
    cardName: "valid card",
    balance: 100,
    holderName: "omar",
    color: "256,244,67,54",
  );

  static CardEntity invalidCard = CardEntity(
    cardName: "invalid card",
    balance: 10,
    holderName: "omar",
    color: "256,244,67,54",
  );

  static List<CardEntity> fakeCards = [
    CardEntity(
      cardName: "valid card1",
      balance: 100,
      holderName: "omar",
      color: "256,244,67,54",
    ),
    CardEntity(
      cardName: "vlaid card2",
      balance: 200,
      holderName: "ali",
      color: "256,244,67,54",
    )
  ];

  static List<TransactionEntity> fakeTransactions = [
    TransactionEntity(
        id: "id1",
        name: "name1",
        image: "image1",
        merchant: "merchant1",
        billingAmount: 100,
        date: 1231231,
        billingCurrency: "USD"),
    TransactionEntity(
        id: "id2",
        name: "name2",
        image: "image2",
        merchant: "merchant2",
        billingAmount: 100,
        date: 1231251,
        billingCurrency: "USD"),
  ];
}
