import "package:dartz/dartz.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:get_it/get_it.dart";
import "package:mocktail/mocktail.dart";
import "package:test_repo/features/cards/domain/bloc/cards_bloc.dart";
import "package:test_repo/features/cards/domain/cards_repo.dart";

import "fake_models.dart";

class MockCardsRepository extends Mock implements ICardsRepository {}

main() {
  final MockCardsRepository cardsRepo = MockCardsRepository();
  late CardsBloc bloc;
  //here we make our dependency injection to inject mock repositories instead of real ones
  setUp(() {
    GetIt.instance.reset();
    GetIt.instance.registerLazySingleton<ICardsRepository>(() => cardsRepo);
    GetIt.instance.registerLazySingleton<CardsBloc>(() => CardsBloc());
    bloc = GetIt.instance.get<CardsBloc>();
    // here we reset the mock interactions
    reset(GetIt.instance.get<ICardsRepository>());

    when(() => cardsRepo.addCard(card: FakeModels.validCard))
        .thenAnswer((_) async => Right(FakeModels.validCard));

    when(() => cardsRepo.addCard(card: FakeModels.invalidCard))
        .thenAnswer((_) async => left("error adding card"));
  });

  group("test get cards", () {
    test("test get cards works when error", () async {
      expect(bloc.state.cards.isEmpty, true);
      expect(bloc.state.errorMessage, isNull);
      when(() => cardsRepo.getCards())
          .thenAnswer((_) async => Left("error retrieving cards"));

      await bloc.getCards();
      expect(bloc.state.cards.length, 0);
      expect(bloc.state.errorMessage, isNotNull);
    });
    test("test get cards works when data is available", () async {
      expect(bloc.state.cards.isEmpty, true);
      expect(bloc.state.errorMessage, isNull);
      when(() => cardsRepo.getCards())
          .thenAnswer((_) async => Right(FakeModels.fakeCards));

      await bloc.getCards();
      expect(bloc.state.cards.length, FakeModels.fakeCards.length);
      expect(bloc.state.errorMessage, isNull);
    });
  });

  group("test add card", () {
    test("test add card works with data", () async {
      int length = bloc.state.cards.length;
      await bloc.addCard(
          name: FakeModels.validCard.cardName,
          holderName: FakeModels.validCard.holderName,
          color: Colors.red,
          balance: FakeModels.validCard.balance);
      expect(bloc.state.cards.length, length + 1);
      expect(bloc.state.cards.contains(FakeModels.validCard), true);
      bloc.clear();
    });

    test("test add card works when error", () async {
      int length = bloc.state.cards.length;
      await bloc.addCard(
          name: FakeModels.invalidCard.cardName,
          holderName: FakeModels.invalidCard.holderName,
          color: Colors.red,
          balance: FakeModels.invalidCard.balance);
      expect(bloc.state.cards.length, length);
      expect(bloc.state.cards.contains(FakeModels.invalidCard), false);
      expect(bloc.state.errorMessage, isNotNull);
      bloc.clear();
    });
  });
}
