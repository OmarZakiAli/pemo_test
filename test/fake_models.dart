import 'package:test_repo/features/cards/domain/card_entity.dart';

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
}
