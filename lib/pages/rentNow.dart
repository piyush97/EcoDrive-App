import 'package:flutter/material.dart';

class BookNow extends StatelessWidget {
  Widget ecobikeImage() {
    return Image(image: AssetImage('assets/ecobike.png'), fit: BoxFit.contain);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.all(20),
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.circular(10),
        color: Colors.black87,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ecobikeImage(),
          Text(
            'Ride Starts Now',
            style: TextStyle(
              color: Colors.white70,
            ),
          )
        ],
      ),
    );
  }
}
