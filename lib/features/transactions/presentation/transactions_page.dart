import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:test_repo/features/transactions/domain/bloc/transactions_bloc.dart';
import 'package:test_repo/features/transactions/domain/bloc/transactions_state.dart';
import 'package:test_repo/features/transactions/presentation/day_transactions_widget.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  final TransactionsBloc _transactionsBloc = GetIt.instance.get();

  @override
  void initState() {
    super.initState();
    _transactionsBloc.getTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionsBloc, TransactionsState>(
      bloc: _transactionsBloc,
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.errorMessage != null) {
          return Center(
              child: Text(
            state.errorMessage!,
            textAlign: TextAlign.center,
          ));
        }

        if (state.transactions.isEmpty) {
          return Center(child: Text("No transactions added yet"));
        }

        return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            itemCount: state.groupedTransactions().keys.length,
            itemBuilder: (c, i) {
              return DayTransactionsWidget(
                transactions: state.groupedTransactions().entries.toList()[i],
              );
            });
      },
    );
  }
}
