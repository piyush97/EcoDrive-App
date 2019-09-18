import 'package:flutter/material.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;
import 'package:intl/intl.dart';

class Selectdate extends StatefulWidget {
  @override
  _SelectdateState createState() => _SelectdateState();
}

class _SelectdateState extends State<Selectdate> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime startDate;
  DateTime endDate;

  DateFormat formatDate = DateFormat('dd/MM/yyyy');

  String _dropDownValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Book your ride',
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          height: 60,
                          child: Container(
                            color: Colors.grey[200],
                            child: Center(
                              child: Text(
                                startDate == null
                                    ? 'Start Date'
                                    : formatDate.format(startDate),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          height: 60,
                          child: Container(
                            color: Colors.grey[200],
                            child: Center(
                              child: Text(
                                endDate == null
                                    ? 'End Date'
                                    : formatDate.format(endDate),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  MaterialButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: () async {
                      final List<DateTime> picked =
                      await DateRangePicker.showDatePicker(
                        context: context,
                        initialFirstDate: DateTime.now(),
                        initialLastDate: (DateTime.now()).add(
                          Duration(days: 7),
                        ),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null && picked.length == 2) {
                        setState(
                              () {
                            startDate = picked[0];
                            endDate = picked[1];
                          },
                        );
                      }
                    },
                    child: Text(
                      'Pick Dates',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 32,
                    ),
                    child: DropdownButton<String>(
                      hint: Text('Please select an option'),
                      isExpanded: true,
                      isDense: true,
                      elevation: 3,
                      value: _dropDownValue,
                      items: [
                        DropdownMenuItem(
                          value: 'Daily',
                          child: Row(
                            children: <Widget>[
                              Text(
                                'Daily',
                              ),
                            ],
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'Weekly',
                          child: Row(
                            children: <Widget>[
                              Text('Weekly'),
                            ],
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'Monthly',
                          child: Row(
                            children: <Widget>[
                              Text('Monthly'),
                            ],
                          ),
                        ),
                      ],
                      onChanged: (value) {
                        setState(
                              () {
                            _dropDownValue = value;
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Material(
            color: Theme.of(context).primaryColor,
            child: InkWell(
              onTap: bookDrive,
              child: SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Book',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void bookDrive() {
    if (startDate == null || endDate == null) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Container(
            height: 30.0,
            child: Text(
              'Please Select Date',
            ),
          ),
        ),
      );
      return;
    }
    if (_dropDownValue == null) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Container(
            height: 30.0,
            child: Text(
              'Please Select Type',
            ),
          ),
        ),
      );
      return;
    }
  }
}