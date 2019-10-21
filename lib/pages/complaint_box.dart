import 'package:flutter/material.dart';

class ComplaintPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Complaint Box"),
        actions: <Widget>[
          new IconButton(icon: const Icon(Icons.send), onPressed: () {})
        ],
      ),
      body: new Column(
        children: <Widget>[
          new ListTile(
            leading: const Icon(Icons.directions_bike),
            title: new TextField(
              decoration: new InputDecoration(
                hintText: "Bike No",
              ),
            ),
          ),
          new ListTile(
            leading: const Icon(Icons.add_box),
            title: new TextFormField(
              decoration: new InputDecoration(
                hintText: "Complaint",
              ),
            ),
          ),
          new ListTile(
            leading: const Icon(Icons.email),
            title: new TextField(
              decoration: new InputDecoration(
                hintText: "Suggestions",
              ),
            ),
          ),
          const Divider(
            height: 1.0,
          ),
        ],
      ),
    );
  }
}
