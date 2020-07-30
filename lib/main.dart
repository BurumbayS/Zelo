// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:google_fonts/google_fonts.dart';
import './place-profile.dart';

void main() => runApp(MyApp());

class RandomWordsState extends State<RandomWords> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Zelo',
            style: GoogleFonts.yellowtail(
              fontSize: 40,
              color: Colors.white,
            )
        ),
      ),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    return ListView.builder(
        itemCount: 10,
        padding: const EdgeInsets.all(10.0),
        itemBuilder: (context, i) {
          return _buildRow();
        }
    );
  }

  Widget _buildRow() {
    return InkWell(
      onTap: (){
        Navigator.push(
            context, CupertinoPageRoute(builder: (context) => PlaceProfile()));
      },

      child: Container(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: <Widget>[

            ClipRRect (
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),

              child: SizedBox (
                height: 130,
                width: double.infinity,
                child: Image.network(
                  'https://realkz.com/images/icons/rest/1.jpg',
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),

            Container(
              width: double.infinity,

              child: Row(

                children: <Widget>[

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container (
                          margin: EdgeInsets.only(left: 10, top: 10),
                          child: Text(
                              "Кафе \"Уют\"",
                              style: GoogleFonts.capriola(
                                fontSize: 16,
                                color: Colors.grey[800],
                              )
                          ),
                        ),

                        Container (
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: Text(
                              "Лучшая европейская и азиатская кухня!",
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.capriola(
                                fontSize: 14,
                                color: Colors.grey[800],
                                fontWeight: FontWeight.w100,
                              )
                          ),
                        )
                      ],
                    ),
                  ),

                  Container(
                      margin: EdgeInsets.only(right: 10, top: 7),
//                  height: 40,
                      padding: EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 5),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),

                      child: Column(
                        children: <Widget>[

                          Text(
                              'Доставка',
                              style: GoogleFonts.montserratAlternates(
                                fontSize: 16,
                                color: Colors.blue,
                              )
                          ),

                          Text(
                              '400 ₸',
                              style: GoogleFonts.montserratAlternates(
                                fontSize: 16,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              )
                          ),
                        ],
                      )

                  ),

                ],
              ),

            )

          ],
        ),

        alignment: Alignment.topLeft,
        margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
        height: 190,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 10,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
      ),
    );
  }

}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wordPair = WordPair.random();
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: RandomWords(),
    );
  }
}