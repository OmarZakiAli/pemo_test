import 'package:dartz/dartz.dart';
import 'package:test_repo/features/cards/data/repo/local_cards_repo.dart';

import 'package:test_repo/features/cards/domain/card_entity.dart';

import '../../domain/cards_repo.dart';

//here we have only local source of cards but if we lated added a remote source we can add it here
class CardsRepo extends ICardsRepository {
  final LocalCardsRepo _localCardsRepo = LocalCardsRepo();
  @override
  Future<Either<String, CardEntity>> addCard({required CardEntity card}) async {
    return await _localCardsRepo.addCard(card: card);
  }

  @override
  Future<Either<String, List<CardEntity>>> getCards() async {
    return await _localCardsRepo.getCards();
  }

  @override
  Future<Either<String, void>> deleteCard({required CardEntity card}) async {
    return await _localCardsRepo.deleteCard(card: card);
  }
}
