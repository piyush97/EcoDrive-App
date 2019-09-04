import 'package:flutter/material.dart';
import "energy_clipper.dart";

class GeneralCard extends StatefulWidget {
  final String title;
  final String date;
  final double kw;

  GeneralCard({this.title, this.date, this.kw});
  @override
  _GeneralCardState createState() => new _GeneralCardState();
}

class _GeneralCardState extends State<GeneralCard> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 7,
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              "https://lightspeed.bike/wp-content/uploads/2017/07/8-3.png"),
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0, top: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  "Ecodrive FlagShip",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "${widget.title}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "${widget.date}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white54,
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 0.0,
                right: 0.0,
                bottom: 75.0,
                child: ClipPath(
                  clipper: EnergyRateClipper(),
                  child: Container(
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: Colors.pink,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0.0,
                right: 0.0,
                bottom: 50.0,
                child: ClipPath(
                  clipper: EnergyRateClipper(),
                  child: Container(
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: Colors.white70,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
