// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:Shrine/model/product.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'home.dart';

class DetailPage extends StatefulWidget {
  final Product product;

  DetailPage({Key key, this.product}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState(product);
}

class _DetailPageState extends State<DetailPage> {
  Product product;

  _DetailPageState(this.product);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final NumberFormat formatter = NumberFormat.simpleCurrency(
        locale: Localizations.localeOf(context).toString());
    Widget titleSection = Container(
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(product.stars, (index) {
              return Icon(Icons.star, color: Colors.yellow, size: 30.0);
            }),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: 200,
            child:
            Text(
              product.name,
              style: TextStyle(
                color: Color(0xFF0E244E),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              maxLines: 1,
            ),
          ),

          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.location_pin, color: Color(0xFF97BBFF), size: 20.0),
              SizedBox(
                width: 5,
              ),
              Container(
                width: 300,
                child:
                Text(
                  product.place,
                  style: TextStyle(
                    color: Color(0xFF798093),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.call, color: Color(0xFF97BBFF), size: 20.0),
              SizedBox(
                width: 5,
              ),
              Container(
                width: 300,
                child:
                Text(
                  product.number,
                  style: TextStyle(
                    color: Color(0xFF798093),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          const Divider(
            height: 1,
            color: Color(0xFF798093),
          ),
        ],
      ),
    );

    Widget textSection =
    Container(
      padding: const EdgeInsets.fromLTRB(30.0, 3.0, 30.0, 3.0),
      child: Text(
        product.detail,
        softWrap: true,
        style: TextStyle(
          color: Color(0xFF798093),
        ),
      ),
    );

    return MaterialApp(
      title: 'Flutter layout demo',
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back, // add custom icons also
            ),
          ),
          title: Text('Detail'),
        ),
        body: ListView(
          children: [
            Stack(
              children: <Widget>[
                GestureDetector(
                  child: Center(
                    child: Hero(
                      tag: product.name,
                      child: GestureDetector(
                        onDoubleTap: (){
                          setState(() {
                            if (HomePage.savedHotels.contains(product)) {
                              HomePage.savedHotels.remove(product);
                            } else {
                              HomePage.savedHotels.add(product);
                            }
                          });
                        },
                        child:
                        Image.asset(
                          product.assetName,
                          width: 600,
                          height: 240,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    padding: EdgeInsets.all(0),
                    alignment: Alignment.centerRight,
                    icon: (HomePage.savedHotels.contains(product)
                        ? Icon(Icons.favorite)
                        : Icon(Icons.favorite_border)),
                    color: Colors.red,
                    onPressed: _toggleFavorite,
                  ),
                )
              ],
            ),
            titleSection,
            textSection,
          ],
        ),
      ),
    );
  }

  void _toggleFavorite() {
    setState(() {
      if (HomePage.savedHotels.contains(product)) {
        HomePage.savedHotels.remove(product);
      } else {
        HomePage.savedHotels.add(product);
      }
    });
  }
}

