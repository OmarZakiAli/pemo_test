import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:get_it/get_it.dart";
import "package:mocktail/mocktail.dart";
import "package:test_repo/features/cards/domain/card_entity.dart";
import "package:test_repo/features/cards/domain/cards_repo.dart";

class MockCardsRepository extends Mock implements ICardsRepository {}

main() {
  final MockCardsRepository _cardsRepo = MockCardsRepository();
  //here we make our dependency injection to inject mock repositories instead of real ones
  setUp(() {
    GetIt.instance.registerLazySingleton<ICardsRepository>(() => _cardsRepo);
    when(() => _cardsRepo.addCard(
        card: CardEntity(
            cardName: "valid card",
            balance: 0,
            holderName: "",
            color: ""))).thenAnswer((_) async => Right([]));
  });

  group("test cards bloc", () {
    test("test add card works with data", () {
      when(() => _cardsRepo.addCard(card: CardEntity()))
          .thenAnswer((_) async => Right(CardEntity()));
      GetIt.instance
          .get<CardsBloc>()
          .add(CardsEvent.addCard(card: CardEntity()));
    });
  });
}
