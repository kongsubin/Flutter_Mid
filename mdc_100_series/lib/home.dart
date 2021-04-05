// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import 'detail.dart';
import 'favorite.dart';
import 'model/products_repository.dart';
import 'model/product.dart';

class HomePage extends StatefulWidget {
  final Set<Product> savedHotels;
  HomePage({Key key, this.savedHotels}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState(savedHotels);
}

class _HomePageState extends State<HomePage> {
  Set<Product> savedHotels;
  _HomePageState(this.savedHotels);

  _launchURL() async {
    const url = 'https://www.handong.edu/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  ListTile _listTitle(
      BuildContext context, IconData icon, String route, String title) {
    return
      ListTile(
      contentPadding: EdgeInsets.fromLTRB(30.0, 5.0, 10.0, 0.0),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon, color: Color(0xFF97BBFF), size: 40.0),
          SizedBox(width: 40.0),
          Text(title),
        ],
      ),
      onTap: () {
        title == 'Home'
            ? Navigator.pop(context)
            : Navigator.pushNamed(context, route,
          arguments: {'savedHotels': savedHotels}
        );
      },
    );
  }

  final isSelected = <bool>[false, true];
  ToggleButtons _toggleButtons() {
    return ToggleButtons(
      color: Colors.black.withOpacity(0.60),
      selectedColor: Color(0xFF97BBFF),
      selectedBorderColor: Color(0xFF97BBFF),
      fillColor: Color(0xFF97BBFF).withOpacity(0.08),
      splashColor: Color(0xFF97BBFF).withOpacity(0.12),
      hoverColor: Color(0xFF97BBFF).withOpacity(0.04),
      borderRadius: BorderRadius.circular(4.0),
      onPressed: (int index) {
        setState(() {
          for (int buttonIndex = 0;
              buttonIndex < isSelected.length;
              buttonIndex++) {
            if (buttonIndex == index) {
              isSelected[buttonIndex] = true;
            } else {
              isSelected[buttonIndex] = false;
            }
          }
        });
      },
      isSelected: isSelected,
      children: [
        Icon(Icons.list),
        Icon(Icons.grid_view),
      ],
    );
  }

  List<Product> products = ProductsRepository.loadProducts(Category.all);

  List<Card> _buildGridCards(BuildContext context) {
    List<Product> products = ProductsRepository.loadProducts(Category.all);

    if (products == null || products.isEmpty) {
      return const <Card>[];
    }

    final ThemeData theme = Theme.of(context);
    final NumberFormat formatter = NumberFormat.simpleCurrency(
        locale: Localizations.localeOf(context).toString());

    return products.map((product) {
      return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(
            color: Colors.grey.withOpacity(0.4),
            width: 1,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        // TODO: Adjust card heights (103)
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 3 / 2,
              child: ClipRRect(
                borderRadius: new BorderRadius.circular(10.0),
                child:
                Hero(
                  tag: product.name,
                  child: Image.asset(
                    product.assetName,
                    package: product.assetPackage,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(30.0, 3.0, 3.0, 0.0),
                    child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(product.stars, (index) {
                        return Icon(Icons.star,
                            color: Colors.yellow, size: 13.0);
                      }),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(30.0, 3.0, 3.0, 0.0),
                    child: Text(
                      product.name,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      maxLines: 1,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      Icon(Icons.location_pin,
                          color: Color(0xFF97BBFF), size: 20.0),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        formatter.format(product.price),
                        style: theme.textTheme.subtitle2,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        child:
                        Text('more',
                            textAlign: TextAlign.right,
                            style: TextStyle(color: Color(0xFF97BBFF))),
                        onTap: () =>
                            Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailPage(product: product, savedHotels: savedHotels),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  Widget _buildRow(BuildContext context, Product product) {
    final ThemeData theme = Theme.of(context);
    final NumberFormat formatter = NumberFormat.simpleCurrency(
        locale: Localizations.localeOf(context).toString());
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(
          color: Colors.grey.withOpacity(0.4),
          width: 1,
        ),
      ),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: new BorderRadius.circular(5.0),
          child: Hero(
            tag: product.name,
            child: Image.asset(
              product.assetName,
              package: product.assetPackage,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        onTap: () {
          // NEW lines from here...
          setState(() {});
        },
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(30.0, 3.0, 3.0, 3.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(product.stars, (index) {
                  return Icon(Icons.star, color: Colors.yellow, size: 15.0);
                }),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(30.0, 3.0, 3.0, 3.0),
              child: Text(
                product.name,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                maxLines: 1,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 30,
                ),
                Text(
                  formatter.format(product.price),
                  style: theme.textTheme.subtitle2,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  child:
                  Text('more',
                      textAlign: TextAlign.right,
                      style: TextStyle(color: Color(0xFF97BBFF))),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailPage(product: product, savedHotels: savedHotels),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ],
        ), // ... to here.
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const String toLaunch = 'https://www.handong.edu/';
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              padding: EdgeInsets.fromLTRB(30.0, 0.0, 0.0, 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    'Pages',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            _listTitle(context, Icons.home, '/home', 'Home'),
            _listTitle(context, Icons.search, '/search', 'Search'),
            ListTile(
          contentPadding: EdgeInsets.fromLTRB(30.0, 5.0, 10.0, 0.0),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.location_city, color: Color(0xFF97BBFF), size: 40.0),
              SizedBox(width: 40.0),
              Text('Favorite Hotel'),
            ],
          ),
          onTap: () {
            // Navigator.of(context).pushNamed('/favorite', arguments: savedHotels);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => FavoritePage(savedHotels: savedHotels),
              ),
            );
          },
        ),
            _listTitle(context, Icons.location_city, '/favorite', 'Favorite Hotel'),
            _listTitle(context, Icons.person, '/person', 'My Page'),
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Main'),
        // TODO: Add trailing buttons (102)
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              semanticLabel: 'search',
            ),
            onPressed: () {
              print('Search button');
            },
          ),
          IconButton(
            icon: Icon(
              Icons.language,
              semanticLabel: 'filter',
            ),
            onPressed: _launchURL,
          ),
        ],
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return new Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 20.0, 10.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: _toggleButtons(),
                ),
              ),
              new Expanded(
                child: isSelected[0]
                    ? ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: products.length,
                        itemBuilder: (BuildContext context, int index) {
                          return _buildRow(context, products[index]);
                        })
                    : GridView.count(
                        crossAxisCount:
                            orientation == Orientation.portrait ? 2 : 3,
                        padding: EdgeInsets.all(16.0),
                        childAspectRatio: 8.0 / 9.0,
                        children: _buildGridCards(context), // Replace
                      ),
              ),
            ],
          );
        },
      ),
      // TODO: Set resizeToAvoidBottomInset (101)
      resizeToAvoidBottomInset: false,
    );
  }
}
