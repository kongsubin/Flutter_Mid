import 'package:flutter/material.dart';

import 'home.dart';
import 'model/product.dart';

class FavoritePage extends StatefulWidget {
  // final Set<Product> args = ModalRoute.of(context).settings.arguments as Set<Product>

  @override
  _FavoritePage createState() => _FavoritePage();
}

class _FavoritePage extends State<FavoritePage> {

  @override
  Widget build(BuildContext context) {
    final title = 'Dismissing Items';
    final List<Product> saveHotelList = HomePage.savedHotels.toList();
    final items = List<Product>.generate(saveHotelList.length, (i) => saveHotelList[i]);

    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
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
          title: Text('Favorite Hotels'),
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
                  HomePage.savedHotels.remove(itemItself);
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