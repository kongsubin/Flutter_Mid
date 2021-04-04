import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool _isExpanded = true;
  bool _isNo_Kids_Zone = false;
  bool _isPet_Friendly = false;
  bool _isFree_breakfast = false;
  List<String> choose = <String>[];

  DateTime currentDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
      });
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Container(
              height: 80,
              color: Color(0xFF337CFF),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Please check\nyour choice:)',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ],
              )),
          titlePadding: const EdgeInsets.all(0),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                SizedBox(height: 30.0),
                Wrap(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(Icons.filter_list,
                        color: Color(0xFF97BBFF), size: 30.0),
                    SizedBox(width: 30.0),
                    SizedBox(
                      width: 200.0,
                      height: 30.0,
                      child: Wrap(
                        children: <Widget>[
                          _isNo_Kids_Zone
                              ? Text(
                                  'No Kids Zone /',
                                  softWrap: true,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                )
                              : Text(' '),
                          _isPet_Friendly
                              ? Text(
                                  'Pet Friendly /',
                                  softWrap: true,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                )
                              : Text(' '),
                          _isFree_breakfast
                              ? Text(
                                  'Free breakfast /',
                                  softWrap: true,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                )
                              : Text(' '),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.calendar_today,
                        color: Color(0xFF97BBFF), size: 30.0),
                    SizedBox(width: 10.0),
                    Text(
                      'IN',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(width: 20.0),
                    Text(
                      DateFormat("yyyy.MM.dd (E)")
                          .format(DateTime.parse(currentDate.toString())),
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 0),
                shadowColor: Colors.grey,
                primary: Color(0xFF337CFF),
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(15.0),
                ), // background
              ),
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Search',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(width: 20,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 0),
                primary: Color(0xFFC9CACD),
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(15.0),
                ), // background
              ),
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Search'),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            ExpansionPanelList(
              expansionCallback: (int index, bool isExpanded) {
                setState(() {
                  _isExpanded = !isExpanded;
                });
              },
              children: [
                ExpansionPanel(
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                        title: Row(children: [
                      Text(
                        'Filter',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 90,
                      ),
                      Text(
                        'select filters',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ]));
                  },
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CheckboxListTile(
                          contentPadding:
                              EdgeInsets.fromLTRB(100.0, 0.0, 0.0, 0.0),
                          activeColor: Colors.indigo,
                          title: Text('No Kids Zone'),
                          value: _isNo_Kids_Zone,
                          onChanged: (value) {
                            setState(() {
                              _isNo_Kids_Zone = value;
                              choose.add('No Kids Zone /');
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                        CheckboxListTile(
                          contentPadding:
                              EdgeInsets.fromLTRB(100.0, 0.0, 0.0, 0.0),
                          activeColor: Colors.indigo,
                          title: Text('Pet Friendly'),
                          value: _isPet_Friendly,
                          onChanged: (value) {
                            setState(() {
                              _isPet_Friendly = value;
                              choose.add('Pet Friendly /');
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                        CheckboxListTile(
                          contentPadding:
                              EdgeInsets.fromLTRB(100.0, 0.0, 0.0, 0.0),
                          activeColor: Colors.indigo,
                          title: Text('Free breakfast'),
                          value: _isFree_breakfast,
                          onChanged: (value) {
                            setState(() {
                              _isFree_breakfast = value;
                              choose.add('Free breakfast /');
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  isExpanded: _isExpanded,
                ),
              ],
            ),
            Container(
                padding: EdgeInsets.fromLTRB(30.0, 40.0, 0.0, 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Date',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                      maxLines: 1,
                    ),
                  ],
                )),
            Row(
              children: [
                SizedBox(
                  width: 40,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.calendar_today,
                            color: Color(0xFF97BBFF), size: 20.0),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Check-in',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                          maxLines: 1,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      DateFormat("yyyy.MM.dd (E)\nHH:mm a")
                          .format(DateTime.parse(currentDate.toString())),
                      // '$currentDate',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                      ),
                      maxLines: 2,
                    ),
                  ],
                ),
                SizedBox(
                  width: 50,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 0),
                    primary: Color(0xFF97BBFF), // background
                  ),
                  onPressed: () => _selectDate(context),
                  child: Text(
                    'Select date',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shadowColor: Colors.grey,
                primary: Color(0xFF337CFF),
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(15.0),
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: 50, vertical: 0), // background
              ),
              onPressed: () => _showMyDialog(),
              child: Text(
                'Search',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
