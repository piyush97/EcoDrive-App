import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecodrive/authentication_bloc/bloc.dart';

class HomeScreen extends StatelessWidget {
  final String name;

  HomeScreen({Key key, @required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              BlocProvider.of<AuthenticationBloc>(context).dispatch(
                LoggedOut(),
              );
            },
          )
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width / 2,
              margin: const EdgeInsets.only(left: 20.0, right: 20.0),
              color: Colors.red,
            ),
            Container(
              width: 160.0,
              color: Colors.blue,
            ),
            Container(
              width: 160.0,
              color: Colors.green,
            ),
            Container(
              width: 160.0,
              color: Colors.yellow,
            ),
            Container(
              width: 160.0,
              color: Colors.orange,
            ),
          ],
        ),
      ),
    );
  }
}
