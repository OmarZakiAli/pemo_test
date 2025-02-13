import 'package:flutter/material.dart';
import 'package:test_repo/features/cards/presentation/add_card_widget.dart';
import 'package:test_repo/features/cards/presentation/cards_page.dart';

import 'features/transactions/presentation/transactions_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "Pemo demo",
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
          ),
          onPressed: () {
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                useSafeArea: true,
                isDismissible: true,
                builder: (c) {
                  return AddCardWidget();
                });
          }),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(indicatorSize: TabBarIndicatorSize.tab, tabs: [
              Tab(
                child: Text(
                  "Cards",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "Transactions",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ]),
            Expanded(
              child: TabBarView(children: [
                CardsPage(),
                TransactionsPage(),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
