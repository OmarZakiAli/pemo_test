import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:test_repo/features/transactions/domain/transaction_entity.dart';

class TransactionDetailsPage extends StatelessWidget {
  const TransactionDetailsPage({super.key, required this.transaction});
  final TransactionEntity transaction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Transaction Info",
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: [
            Center(
              child: Hero(
                  tag: transaction.id,
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage:
                        CachedNetworkImageProvider(transaction.image),
                  )),
            ),
            SizedBox(
              height: 16,
            ),
            _buildDataRow(context, "Employer name", transaction.name),
            _buildDataRow(context, "Merchant", transaction.merchant),
            _buildDataRow(context, "Billing ammount",
                transaction.billingAmount.toString()),
            _buildDataRow(context, "Currency", transaction.billingCurrency),
            _buildDataRow(context, "Date", transaction.formattedDate),
            _buildDataRow(context, "Time", transaction.formattedTime),
          ],
        ),
      ),
    );
  }

  Widget _buildDataRow(BuildContext context, String title, String value) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18),
            ),
            Text(
              value,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).primaryColor),
            )
          ],
        ),
        Divider(),
        SizedBox(height: 8)
      ],
    );
  }
}
