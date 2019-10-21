import 'package:flutter/material.dart';
import 'package:link/link.dart';

class RepairPage extends StatefulWidget {
  RepairPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _RepairPageState createState() => _RepairPageState();
}

class _RepairPageState extends State<RepairPage> {
  void _showErrorSnackBar() {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text('Oops... the URL couldn\'t be opened!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Repair your Bike"),
      ),
      body: Center(
          child: Link(
        child: Text('Bike breakdown? Click me to repair!',
            style: TextStyle(fontSize: 20)),
        url:
            'https://www.google.com/search?client=safari&sa=X&rls=en&biw=1440&bih=814&sxsrf=ACYBGNSqNMdQNMcngMToPRGCchU-zDhljg:1571682059834&q=bike+repair+shop+near+me&npsic=0&rflfq=1&rlha=0&rllag=13027452,77563193,554&tbm=lcl&ved=2ahUKEwi69YD3-63lAhVFLo8KHfDAAlAQjGp6BAgKEEA&tbs=lrf:!2m1!1e2!2m1!1e3!2m1!1e16!3sIAE,lf:1,lf_ui:2&rldoc=1#rlfi=hd:;si:;mv:%5B%5B13.053843899999999,77.61952939999999%5D,%5B12.984869999999999,77.5413836%5D%5D;tbs:lrf:!2m1!1e2!2m1!1e3!2m1!1e16!3sIAE,lf:1,lf_ui:2 ',
        onError: _showErrorSnackBar,
      )),
    );
  }
}
