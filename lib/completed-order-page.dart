import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';

// ignore: must_be_immutable
class CompletedOrderPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return new CompletedOrderPageState();
  }
}

class CompletedOrderPageState extends State<CompletedOrderPage>  {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
        appBar: AppBar(
          title: Text(
            'Статус заказа',
            style: GoogleFonts.openSans(

            ),
          ),
        ),
        body: Container(
          alignment: Alignment.center,
          child: Text(
            'Ваш заказ принят и уже готовиться'
          ),
        )
    );
  }

}
