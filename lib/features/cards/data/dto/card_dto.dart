import 'package:hive_ce/hive.dart';
part 'card_dto.g.dart';

@HiveType(typeId: 0)
class CardDto extends HiveObject {
  @HiveField(0)
  String cardName; //min 3 chars
  @HiveField(1)
  String holderName;
  @HiveField(2)
  int balance; //from 100 to 1000
  @HiveField(3)
  String color;
  CardDto({
    required this.cardName,
    required this.balance,
    required this.holderName,
    required this.color,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cardName': cardName,
      'balance': balance,
      'holderName': holderName,
      'color': color,
    };
  }

  factory CardDto.fromMap(Map<String, dynamic> map) {
    return CardDto(
      cardName: map['cardName'],
      balance: map['balance'],
      holderName: map['holderName'],
      color: map['color'],
    );
  }
}
