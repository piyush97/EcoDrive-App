import 'package:flutter/material.dart';
import 'dart:async';

class BookNow extends StatefulWidget {
  @override
  BookNowState createState() => BookNowState();
}

class BookNowState extends State<BookNow> {
  Widget ecobikeImage() {
    return Image(image: AssetImage('assets/ecobike.png'), fit: BoxFit.contain);
  }

  Stopwatch watch = Stopwatch();
  Timer timer;
  bool startStop = true;

  String elapsedTime = '';

  updateTime(Timer timer) {
    if (watch.isRunning) {
      setState(() {
        print("startstop Inside=$startStop");
        elapsedTime = transformMilliSeconds(watch.elapsedMilliseconds);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          SizedBox(height: 20.0),
          ecobikeImage(),
          SizedBox(height: 60.0),
          Text(elapsedTime, style: TextStyle(fontSize: 25.0)),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                color: Colors.green,
                onPressed: () => startOrStop(),
                child: Text("Start Ride"),
              ),
              SizedBox(width: 20.0),
            ],
          )
        ],
      ),
    );
  }

  startOrStop() {
    if (startStop) {
      startWatch();
    } else {
      stopWatch();
    }
  }

  startWatch() {
    setState(() {
      startStop = false;
      watch.start();
      timer = Timer.periodic(Duration(milliseconds: 100), updateTime);
    });
  }

  stopWatch() {
    setState(() {
      startStop = true;
      watch.stop();
      setTime();
    });
  }

  setTime() {
    var timeSoFar = watch.elapsedMilliseconds;
    setState(() {
      elapsedTime = transformMilliSeconds(timeSoFar);
    });
  }

  transformMilliSeconds(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();
    int hours = (minutes / 60).truncate();

    String hoursStr = (hours % 60).toString().padLeft(2, '0');
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    return "$hoursStr:$minutesStr:$secondsStr";
  }
}

// class BookNow extends StatelessWidget {
//   Widget ecobikeImage() {
//     return Image(image: AssetImage('assets/ecobike.png'), fit: BoxFit.contain);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 5),
//       padding: EdgeInsets.all(20),
//       decoration: new BoxDecoration(
//         borderRadius: new BorderRadius.circular(10),
//         color: Colors.black87,
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//           ecobikeImage(),
//           Text(
//             'Ride Starts Now',
//             style: TextStyle(
//               color: Colors.white70,
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
