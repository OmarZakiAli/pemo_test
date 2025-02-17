import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:test_repo/features/cards/domain/bloc/cards_bloc.dart';
import 'package:test_repo/features/cards/domain/card_entity.dart';

class CardWidget extends StatefulWidget {
  const CardWidget({super.key, required this.card});
  final CardEntity card;

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  bool showBalance = false;
  @override
  Widget build(BuildContext context) {
    Color textColor =
        useWhiteForeground(widget.card.uiColor) ? Colors.white : Colors.black;

    return Container(
      height: 200,
      margin: EdgeInsets.only(bottom: 20),
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(color: widget.card.uiColor, blurRadius: 3, spreadRadius: 4)
      ], borderRadius: BorderRadius.circular(16), color: widget.card.uiColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildCardHeader(textColor),
          _buildBlur(),
          _buildCardFooter(textColor),
        ],
      ),
    );
  }

  Widget _buildCardHeader(Color textColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.card.cardName,
          style: TextStyle(
              fontSize: 28, color: textColor, fontWeight: FontWeight.bold),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.transparent.withValues(alpha: .5)),
          child: Row(
            children: [
              Icon(
                Icons.wifi,
                color: Colors.white,
                size: 18,
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                "Virtual",
                style: TextStyle(fontSize: 14, color: Colors.white),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _buildCardFooter(Color textColor) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(widget.card.holderName,
            style: TextStyle(
                fontSize: 18, color: textColor, fontWeight: FontWeight.w600)),
        Spacer(),
        InkWell(
          onTap: () {
            GetIt.instance.get<CardsBloc>().deleteCard(card: widget.card);
          },
          child: CircleAvatar(
              backgroundColor: Colors.transparent.withValues(alpha: .5),
              child: Icon(
                Icons.delete,
                color: Colors.white,
              )),
        )
      ],
    );
  }

  _buildBlur() {
    return Container(
      height: 45,
      width: 250,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
          color: Colors.transparent.withValues(alpha: .2),
          boxShadow: [
            BoxShadow(
                color: widget.card.uiColor.withValues(alpha: .1),
                blurRadius: 3,
                spreadRadius: 4)
          ]),
      child: InkWell(
        onTap: () {
          setState(() {
            showBalance = !showBalance;
          });
          if (showBalance = true) {
            Future.delayed(Duration(seconds: 2), () {
              setState(() {
                showBalance = false;
              });
            });
          }
        },
        child: Center(
          child: showBalance
              ? Text(
                  "${widget.card.balance} USD",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w600),
                )
              : Text(
                  "Show Balance",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
        ),
      ),
    );
  }

  bool useWhiteForeground(Color backgroundColor, {double bias = 0.0}) {
    int v = sqrt(pow(backgroundColor.r * 256, 2) * 0.299 +
            pow(backgroundColor.g * 256, 2) * 0.587 +
            pow(backgroundColor.b * 256, 2) * 0.114)
        .round();
    return v < 130 + bias ? true : false;
  }
}
