import 'package:flutter/material.dart';
import 'package:test_repo/features/transactions/domain/transaction_entity.dart';
import 'package:test_repo/features/transactions/presentation/transaction_details_page.dart';

class DayTransactionsWidget extends StatelessWidget {
  const DayTransactionsWidget({super.key, required this.transactions});
  final MapEntry<String, List<TransactionEntity>> transactions;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            transactions.key,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(8)),
            child: Column(
              children: [
                ...List.generate(transactions.value.length, (index) {
                  bool isLast = index == transactions.value.length - 1;
                  TransactionEntity transaction = transactions.value[index];
                  return Column(
                    children: [
                      _buildTransactionData(context, transaction),
                      if (!isLast)
                        Divider(
                          color: Colors.grey.shade400,
                          height: 1,
                        )
                    ],
                  );
                })
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionData(
      BuildContext context, TransactionEntity transaction) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (c) {
            return TransactionDetailsPage(transaction: transaction);
          }));
        },
        child: Row(
          children: [
            Hero(
              tag: transaction.id,
              child: CircleAvatar(
                radius: 24,
                backgroundImage: NetworkImage(transaction.image),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.merchant,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(transaction.name)
              ],
            ),
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "${transaction.billingCurrency} ${transaction.billingAmount}",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Text(
                  transaction.formattedTime,
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
