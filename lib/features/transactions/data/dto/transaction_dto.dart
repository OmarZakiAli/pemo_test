import 'package:hive_ce/hive.dart';

part 'transaction_dto.g.dart';

@HiveType(typeId: 1)
class TransactionDto {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String image;
  @HiveField(3)
  String merchant;
  @HiveField(4)
  int billingAmount;
  @HiveField(5)
  int date;
  @HiveField(6)
  String billingCurrency;
  TransactionDto({
    required this.id,
    required this.name,
    required this.image,
    required this.merchant,
    required this.billingAmount,
    required this.date,
    required this.billingCurrency,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'image': image,
      'merchant': merchant,
      'billingAmount': billingAmount,
      'date': date,
      'billingCurrency': billingCurrency,
    };
  }

  factory TransactionDto.fromMap(Map<String, dynamic> map) {
    return TransactionDto(
      id: map['id'],
      name: map['name'],
      image: map['image'],
      merchant: map['merchant'],
      billingAmount: map['billingAmount'],
      date: map['date'],
      billingCurrency: map['billingCurrency'],
    );
  }
}
