import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:test_repo/features/transactions/domain/bloc/transactions_state.dart';
import 'package:test_repo/features/transactions/domain/transactions_repo.dart';

class TransactionsBloc extends Cubit<TransactionsState> {
  final ITransactionsRepo _transactionsRepo =
      GetIt.instance.get<ITransactionsRepo>();

  TransactionsBloc() : super(TransactionsState());

  Future<void> getTransactions() async {
    emit(state.copyWith(isLoading: true));
    final response = await _transactionsRepo.getTransactions();
    response.fold((error) {
      emit(state.copyWith(isLoading: false, errorMessage: error));
    }, (data) {
      emit(state.copyWith(isLoading: false, transactions: data));
    });
  }
}
