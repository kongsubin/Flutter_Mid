import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'model/product.dart';

class FavoritePage extends StatefulWidget {
  static const routeName = '/favorite';
  // final Set<Product> args = ModalRoute.of(context).settings.arguments as Set<Product>;

  final Set<Product> savedHotels;
  FavoritePage({Key key, this.savedHotels}) : super(key: key);

  @override
  _FavoritePage createState() => _FavoritePage(savedHotels);
}

class _FavoritePage extends State<FavoritePage> {
  Set<Product> savedHotels;
  _FavoritePage(this.savedHotels);


  @override
  Widget build(BuildContext context) {
    final title = 'Dismissing Items';
    final List<Product> saveHotelList = savedHotels.toList();
    final items = List<Product>.generate(saveHotelList.length, (i) => saveHotelList[i]);

    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index].name;
            final itemItself = items[index];

            return Dismissible(
              // Each Dismissible must contain a Key. Keys allow Flutter to
              // uniquely identify widgets.
              key: Key(item),
              // Provide a function that tells the app
              // what to do after an item has been swiped away.
              onDismissed: (direction) {
                // Remove the item from the data source.
                setState(() {
                  items.removeAt(index);
                  savedHotels.remove(itemItself);
                  saveHotelList.remove(itemItself);
                });

                // Then show a snackbar.
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("$item dismissed")));
              },
              // Show a red background as the item is swiped away.
              background: Container(color: Colors.red),
              child: ListTile(title: Text('$item')),
            );
          },
        ),
      ),
    );
  }
}