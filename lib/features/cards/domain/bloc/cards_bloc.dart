import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:test_repo/features/cards/domain/bloc/cards_state.dart';

import '../card_entity.dart';
import '../cards_repo.dart';

class CardsBloc extends Cubit<CardsState> {
  final ICardsRepository _cardsRepo = GetIt.instance.get<ICardsRepository>();
  CardsBloc() : super(CardsState());

  getCards() {
    _cardsRepo.getCards().then((value) {
      value.fold((error) {
        emit(CardsState(errorMessage: error));
      }, (data) {
        emit(CardsState(cards: data));
      });
    });
  }

  Future<void> addCard(
      {required String name,
      required String holderName,
      required Color color,
      required int balance}) async {
    String colorAsString =
        "${(color.a * 256).toInt()},${(color.r * 256).toInt()},${(color.g * 256).toInt()},${(color.b * 256).toInt()}";
    await _cardsRepo
        .addCard(
            card: CardEntity(
                cardName: name,
                holderName: holderName,
                color: colorAsString,
                balance: balance))
        .then((value) {
      value.fold((error) {
        emit(CardsState(errorMessage: error));
      }, (data) {
        emit(CardsState(cards: [...state.cards, data]));
      });
    });
  }

  Future<void> deleteCard({required CardEntity card}) async {
    await _cardsRepo.deleteCard(card: card).then((value) {
      value.fold((error) {
        emit(CardsState(errorMessage: error));
      }, (data) {
        List<CardEntity> newCards = state.cards.toList();
        newCards.removeWhere((element) => element.id == card.id);
        emit(CardsState(cards: newCards));
      });
    });
  }

  clear() {
    emit(CardsState(cards: []));
  }
}
