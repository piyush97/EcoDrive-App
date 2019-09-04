import 'package:flutter/material.dart';


import 'package:ecodrive/services/authentication.dart';
import 'package:ecodrive/pages/root_page.dart';
import 'package:firebase_auth/firebase_auth.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title,this.userId, this.auth,this.onSignedOut}) : super(key: key);



  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final String  userId;
  final void onSignedOut;
  final BaseAuth auth;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _anchorToBottom = false;


  // ignore: non_constant_identifier_names


  @override
  void initState() {
    // TODO: implement initState
    FirebaseAuth.instance.onAuthStateChanged.listen((firebaseUser) {
      // do whatever you want based on the firebaseUser state
      print(firebaseUser.uid);
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  bool _cartopen = false;
  bool _loading = false;
  bool _cartswitch = false;
  Icon _searchIcon = new Icon(Icons.search);
  Icon _carticon = new Icon(Icons.shopping_cart);
  final TextEditingController _filter = new TextEditingController();
  String _searchText = "";
  Widget _appBarTitle = new Text('Eco Drives');

  Widget _appbody;


  _MyHomePageState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          //filteredNames = names;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //  _appbody = normaldata();

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        title: this._appBarTitle,
        bottom: PreferredSize(
            child: new Text("hello"), preferredSize: Size(25.0, 25.0)),
        actions: <Widget>[
         /*
          IconButton(
            icon: this._searchIcon,
            tooltip: 'Search',
            onPressed: () {
              this._searchPressed();
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => SecondRoute()));


            },


          ),

          IconButton(
            icon: _carticon,
            tooltip: 'Cart',
            onPressed: () {
              this._cartPressed();
            },

          ),*/

        ],

      ),
      drawer: Drawer(child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Eco Drives'),
            decoration: BoxDecoration(
              color: Colors.pinkAccent,
            ),
          ),
          ListTile(
            title: Text('Bikes'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: Text('My rides'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: Text("Logout"),
            onTap: (){
              widget.auth.signOut();
              Navigator.pop(context);
              Navigator.push(context,MaterialPageRoute(builder: (context)=> RootPage(auth:widget.auth)));
            },
          ),
        ],
      ),
      ),


      body: new Container(

      ),


    );
  }


  void _searchPressed() {
    setState(() {
      if (this._carticon.icon == Icons.close) {
        this._carticon = new Icon(Icons.shopping_cart);
        this._appBarTitle = new Text('Habibi Mart');
        _cartopen = false;
        _cartswitch = false;
      }
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);

        this._appBarTitle = new TextField(

          onChanged: (text) {
            _loading = false;
          },
          controller: _filter,
          onSubmitted: (text) {
            _loading = true;
          },
          cursorColor: Colors.white,


          style: new TextStyle(
            color: Colors.white, decorationColor: Colors.white,
            decorationStyle: TextDecorationStyle.wavy,),
          decoration: new InputDecoration(
              prefixIcon: new Icon(Icons.search, color: Colors.white,),
              hintText: 'Search...',
              hintStyle: new TextStyle(color: Colors.white),
              suffixStyle: new TextStyle(color: Colors.white),
              enabledBorder: new UnderlineInputBorder(
                  borderSide: new BorderSide(color: Colors.white))


          ),
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text('Habibi Mart');
        //filteredNames = names;
        _filter.clear();
        _loading = false;
      }
    });
  }

  void _cartPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.close) {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text('Habibi Mart');
        //filteredNames = names;
        _filter.clear();
        _loading = false;
      }
      if (this._carticon.icon == Icons.shopping_cart) {
        this._carticon = new Icon(Icons.close);
        this._appBarTitle = new Text('Cart');
        _cartopen = true;
        _cartswitch = true;
        print(_cartopen);
      }
      else {
        this._carticon = new Icon(Icons.shopping_cart);
        this._appBarTitle = new Text('Habibi Mart');
        _cartopen = false;
        _cartswitch = false;
      }
    });
  }

  Future<String> _refresh() async {
    await new Future.delayed(new Duration(seconds: 3), () {
      print("refreshing");
    }).then(print).catchError(print).whenComplete(() {
      print('done!');
      return "s";
    });
  }
/*
  normaldata(){
    return new RefreshIndicator(child: new FirebaseAnimatedList(query: databaseUtil.getUser(),
        itemBuilder: (BuildContext context, DataSnapshot snapshot,
            Animation<double> animation, int index) {
          return new SizeTransition(
            sizeFactor: animation,
            child: showUser(snapshot),
          );
        }

    )
      , onRefresh: _refresh,
      displacement: 20.0,
      backgroundColor: Colors.black,
    );
  }

  cartdata(){
    return new Container();
  }




  _buildList() {
    //print(_loading);
    print(_cartopen);
    if(_loading==true){
      String temptxt = _searchText;
      // print(temptxt);
      while(_searchText.isNotEmpty){
        //print(_searchText);
        Query searchquery = database.reference().child('blog').orderByChild('title').startAt(_searchText).endAt(_searchText+ "\uf8ff");
        return new FirebaseAnimatedList(query: searchquery,
            itemBuilder: (BuildContext context, DataSnapshot snapshot,
                Animation<double> animation, int index) {
              // print(snapshot.value);
              return new SizeTransition(
                sizeFactor: animation,
                child: showUser(snapshot),
              );
            }

        );

      }

    }

    if(_loading == false && _cartswitch == false && _searchText.isEmpty){

      return normaldata();



    }

    if(_cartopen == true && _cartswitch == true){
      print("opencart");
      return cartdata();
    }







  }




  Widget showUser(DataSnapshot res) {
    productsdata pdata = productsdata.fromSnapshot(res);

    var item = new Card(


      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Image.network(pdata.image,height: 100.0,width: 100.0,),
            title: Text(pdata.title),
            subtitle: Text("Rs "+pdata.price),

            onTap: (){
              Firebase_product_key fkey = new Firebase_product_key(pdata.id,pdata.title,pdata.image,pdata.price,pdata.description,pdata.shortdesc);
              Navigator.push(context, MaterialPageRoute(builder: (context) => Singleproduct(fkey: fkey,)));
            },


          ),
          ButtonTheme.bar(
            // make buttons use the appropriate styles for cards
            child: ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: const Text('BUY NOW'),
                  onPressed: () {
                    /* ... */
                  },
                ),
                FlatButton(
                  child: const Text('ADD'),
                  onPressed: () {
                    /* ... */
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
    return item;
  }

}*/


}
