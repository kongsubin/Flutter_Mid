import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool _isExpanded = true;
  bool _isNo_Kids_Zone = false;
  bool _isPet_Friendly = false;
  bool _isFree_breakfast = false;

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
                          SizedBox(width: 90,),
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
                          contentPadding: EdgeInsets.fromLTRB(100.0, 0.0, 0.0, 0.0),
                          activeColor: Colors.indigo,
                          title: Text('No Kids Zone'),
                          value: _isNo_Kids_Zone,
                          onChanged: (value) {
                            setState(() {
                              _isNo_Kids_Zone = value;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                        CheckboxListTile(
                          contentPadding: EdgeInsets.fromLTRB(100.0, 0.0, 0.0, 0.0),
                          activeColor: Colors.indigo,
                          title: Text('Pet Friendly'),
                          value: _isPet_Friendly,
                          onChanged: (value) {
                            setState(() {
                              _isPet_Friendly = value;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                        CheckboxListTile(
                          contentPadding: EdgeInsets.fromLTRB(100.0, 0.0, 0.0, 0.0),
                          activeColor: Colors.indigo,
                          title: Text('Free breakfast'),
                          value: _isFree_breakfast,
                          onChanged: (value) {
                            setState(() {
                              _isFree_breakfast = value;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                        SizedBox(height: 20,),
                      ],
                    ),
                  ),
                  isExpanded: _isExpanded,
                ),
              ],
            ),
            Row(
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        Icon(Icons.calendar_today,
                            color: Color(0xFF97BBFF), size: 20.0),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Check-in',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          maxLines: 1,
                        ),
                      ],
                    ),
                    Text(
                      currentDate.toString(),
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      maxLines: 2,
                    ),

                  ],
                ),
                RaisedButton(
                  onPressed: () => _selectDate(context),
                  child: Text('Select date'),
                ),
              ],
            ),
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: <Widget>[
            //     Row(
            //       mainAxisAlignment: MainAxisAlignment.start,
            //       children: [
            //         SizedBox(
            //           width: 5,
            //         ),
            //         Icon(Icons.calendar_today,
            //             color: Color(0xFF97BBFF), size: 20.0),
            //         SizedBox(
            //           width: 5,
            //         ),
            //         Text(
            //           'Check-in',
            //           style: TextStyle(
            //             color: Colors.black,
            //             fontWeight: FontWeight.bold,
            //             fontSize: 16,
            //           ),
            //           maxLines: 1,
            //         ),
            //       ],
            //     ),
            //     Container(
            //       padding: EdgeInsets.fromLTRB(30.0, 3.0, 3.0, 0.0),
            //       child: Text(
            //         'Check-in',
            //         style: TextStyle(
            //           color: Colors.black,
            //           fontWeight: FontWeight.bold,
            //           fontSize: 16,
            //         ),
            //         maxLines: 1,
            //       ),
            //     ),
            //     Row(
            //       mainAxisAlignment: MainAxisAlignment.end,
            //       children: [
            //         SizedBox(
            //           width: 10,
            //         ),
            //       ],
            //     ),
            //   ],
            // ),
            const Divider(
              height: 1,
              color: Colors.black,
            ),
            const Divider(
              height: 1,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
