// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:Shrine/model/product.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailPage extends StatefulWidget {
  final Product product;
  final Set<int> savedHotels;

  DetailPage({Key key, this.product, this.savedHotels}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState(product, savedHotels);
}

class _DetailPageState extends State<DetailPage> {
  Product product;
  Set<int> savedHotels;

  _DetailPageState(this.product, this.savedHotels);

  bool _isFavorited = false;

  // In the constructor, require a Todo.

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
          Text(
            product.name,
            style: TextStyle(
              color: Color(0xFF0E244E),
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            maxLines: 1,
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
              Text(
                formatter.format(product.price),
                style: TextStyle(
                  color: Color(0xFF798093),
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
              Text(
                formatter.format(product.price),
                style: TextStyle(
                  color: Color(0xFF798093),
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

    Widget textSection = Container(
      padding: const EdgeInsets.fromLTRB(30.0, 3.0, 30.0, 3.0),
      child: Text(
        'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
        'Alps. Situated 1,578 meters above sea level, it is one of the '
        'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
        'half-hour walk through pastures and pine forest, leads you to the '
        'lake, which warms to 20 degrees Celsius in the summer. Activities '
        'enjoyed here include rowing, and riding the summer toboggan run.',
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
                            if (savedHotels.contains(product.id)) {
                              _isFavorited = false;
                              savedHotels.remove(product.id);
                            } else {
                              _isFavorited = true;
                              savedHotels.add(product.id);
                            }
                          });
                        },
                        child: Image.asset(
                          product.assetName,
                          package: product.assetPackage,
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
                    icon: (savedHotels.contains(product.id)
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
      if (savedHotels.contains(product.id)) {
        _isFavorited = false;
        savedHotels.remove(product.id);
      } else {
        _isFavorited = true;
        savedHotels.add(product.id);
      }
    });
  }
}

