import 'package:ecodrive/pages/plans.dart';
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

  TextEditingController couponController = TextEditingController();
  bool isCouponCodeApplied = false;

  int diff = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Book your ride',
        ),
        backgroundColor: Colors.green,
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
                            color: Colors.green,
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
                            color: Colors.green,
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
                    color: Colors.green,
                    textColor: Colors.black,
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
                            debugPrint('${startDate.day.toString()}');
                            debugPrint('${endDate.day.toString()}');
                            diff = (endDate.day - startDate.day) + 1;
                            debugPrint('${diff * 5}');
                          },
                        );
                      }
                    },
                    child: Text(
                      'Pick Dates',
                      style: TextStyle(
                        color: Colors.black,
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
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 70.0, left: 16.0, right: 16.0),
                    child: Card(
                      color: Colors.grey[100],
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                onChanged: (val) {
                                  // initiateSearch(val);
                                },
                                controller: couponController,
                                // keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    labelText: "Enter coupon code",
                                    hintText: "",
                                    errorStyle: TextStyle(
                                        color: Colors.white, fontSize: 10.0),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.0))),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Container(
                                width: double.infinity,
                                child: RaisedButton(
                                  color: Colors.blue[100],
                                  child: Text('Apply Coupon'),
                                  onPressed: () {
                                    setState(() {
                                      if (isCouponCodeApplied) {
                                        final snackBar = SnackBar(
                                            content: Text(
                                                "You greedy! Coupon code already applied."));

// Find the Scaffold in the widget tree and use it to show a SnackBar.
                                        _scaffoldKey.currentState
                                            .showSnackBar(snackBar);
//Scaffold.of(context).showSnackBar(snackBar);
                                      } else {
                                        if (couponController.text.isEmpty) {
                                          final snackBar = SnackBar(
                                              content: Text(
                                                  "Coupon code can't be empty"));

// Find the Scaffold in the widget tree and use it to show a SnackBar.
                                          _scaffoldKey.currentState
                                              .showSnackBar(snackBar);
//Scaffold.of(context).showSnackBar(snackBar);
                                        } else {
                                          this.isCouponCodeApplied = true;
                                          couponController.text = '';
                                        }
                                      }
                                    });
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 24.0, left: 8.0, right: 8.0),
                              child: Text('Ride Rate:  Rs 5/day',
                                  style: TextStyle(fontSize: 15.0)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 2.0, left: 8.0, right: 8.0),
                              child: Text('Booked for : $diff days',
                                  style: TextStyle(fontSize: 14.0)),
                            ),
                            isCouponCodeApplied
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Coupon applied successfully!!',
                                      style: TextStyle(
                                          fontSize: 14.0, color: Colors.green),
                                    ),
                                  )
                                : Container(height: 8.0),
                            // SizedBox(
                            //   height: 10.0,
                            // ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Text('Total bill:',
                                      style: TextStyle(fontSize: 16.0)),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  isCouponCodeApplied
                                      ? Text('Rs ${diff * 5}',
                                          style: TextStyle(
                                              decoration:
                                                  TextDecoration.lineThrough))
                                      : Text('Rs ${diff * 5}',
                                          style: TextStyle()),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  isCouponCodeApplied
                                      ? Text(' ${diff * 5 - (diff * 5 * 0.1)}')
                                      : Container(),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
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
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PlansPage()),
    );
  }
}
