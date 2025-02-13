import 'package:intl/intl.dart';

class TransactionEntity {
  final String id;
  final String name;
  final String image;
  final String merchant;
  final int billingAmount;
  final int date;
  final String billingCurrency;
  TransactionEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.merchant,
    required this.billingAmount,
    required this.date,
    required this.billingCurrency,
  });

  String get formattedTime {
    //the date timestamp is in seconds from servers
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(date * 1000);
    DateFormat dateFormat = DateFormat('HH:mm a');
    return dateFormat.format(dateTime);
  }

  String get formattedDate {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(date * 1000);
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    return dateFormat.format(dateTime);
  }
}
