import 'package:dartz/dartz.dart';
import 'package:hive_ce/hive.dart';
import 'package:test_repo/core/app_consts.dart';
import 'package:test_repo/features/cards/data/dto/card_dto.dart';
import 'package:test_repo/features/cards/domain/card_entity.dart';
import 'package:test_repo/features/cards/domain/cards_repo.dart';

class LocalCardsRepo extends ICardsRepository {
  @override
  Future<Either<String, CardEntity>> addCard({required CardEntity card}) async {
    try {
      int id = await Hive.box<CardDto>(AppConsts.cardBox).add(CardDto(
        cardName: card.cardName,
        balance: card.balance,
        holderName: card.holderName,
        color: card.color,
      ));
      card.id = id;
      return Right(card);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<CardEntity>>> getCards() async {
    try {
      List<CardDto> cards =
          Hive.box<CardDto>(AppConsts.cardBox).values.toList();
      List<CardEntity> cardEntities = cards.map((card) {
        return CardEntity(
          cardName: card.cardName,
          holderName: card.holderName,
          balance: card.balance,
          color: card.color,
          id: card.key,
        );
      }).toList();
      return Right(cardEntities);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> deleteCard({required CardEntity card}) async {
    try {
      await Hive.box<CardDto>(AppConsts.cardBox).delete(card.id);
      return Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
