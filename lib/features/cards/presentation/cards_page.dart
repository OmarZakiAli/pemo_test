import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:test_repo/features/cards/domain/bloc/cards_state.dart';

import '../domain/bloc/cards_bloc.dart';
import 'card_widget.dart';

class CardsPage extends StatefulWidget {
  const CardsPage({super.key});

  @override
  State<CardsPage> createState() => _CardsPageState();
}

class _CardsPageState extends State<CardsPage> {
  final cardsBloc = GetIt.instance.get<CardsBloc>();

  @override
  void initState() {
    super.initState();
    cardsBloc.getCards();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CardsBloc, CardsState>(
      bloc: cardsBloc,
      builder: (context, state) {
        if (state.errorMessage != null) {
          return Center(child: Text(state.errorMessage!));
        }
        if (state.cards.isEmpty) {
          return const Center(child: Text("No cards added yet"));
        }
        return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            itemCount: state.cards.length,
            itemBuilder: (c, i) {
              return CardWidget(
                  key: ValueKey(state.cards[i].id), card: state.cards[i]);
            });
      },
    );
  }
}
