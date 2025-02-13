import 'package:dartz/dartz.dart';
import 'package:test_repo/features/cards/domain/card_entity.dart';

abstract class ICardsRepository {
  Future<Either<String, List<CardEntity>>> getCards();
  Future<Either<String, CardEntity>> addCard({required CardEntity card});
  Future<Either<String, void>> deleteCard({required CardEntity card});
}
