import 'package:collection/collection.dart';
import 'package:test_repo/features/cards/domain/card_entity.dart';

class CardsState {
  final List<CardEntity> cards;
  final String? errorMessage;
  CardsState({
    this.cards = const [],
    this.errorMessage,
  });

  CardsState copyWith({
    List<CardEntity>? cards,
    String? errorMessage,
  }) {
    return CardsState(
      cards: cards ?? this.cards,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  bool operator ==(covariant CardsState other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return listEquals(other.cards, cards) && other.errorMessage == errorMessage;
  }

  @override
  int get hashCode => cards.hashCode ^ errorMessage.hashCode;
}
