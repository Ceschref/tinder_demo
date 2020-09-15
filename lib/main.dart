import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tinder_demo/listFavorite.dart';
import 'package:tinder_demo/service/getListPerson.dart';

import 'model/person.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Person> persons = [];
  List<Person> listFavorite = [];
  StreamController<List<Offset>> posisonedController = StreamController<List<Offset>>.broadcast();
  StreamController<bool> isLikeStreamController = StreamController<bool>.broadcast();
  StreamController<bool> isShowLikeStreamController = StreamController<bool>.broadcast();
  Offset posision = Offset(0.0, 0.0);
  List<Offset> listOffset = [];
  var dx = 25.0;
  var dy = 20.0;
  String type = 'info';

  @override
  void initState() {
    super.initState();
    _getDataFromJson();
  }

  @override
  void dispose() {
    super.dispose();
    posisonedController.close();
    isLikeStreamController.close();
    isShowLikeStreamController.close();
  }

  _getDataFromJson() async {
    String jsonString = await rootBundle.loadString("data/dataJson.json");
    var data = jsonDecode(jsonString);
    setState(() {
      persons = GetListPerson().getListPerson(data);
    });
    listOffset = persons.map((i) => Offset(dx, dy)).toList();
  }

  _buildDecription(Person person) {
    if (type == 'location') return _buildLocation(person.location);
    if (type == 'info') return _buildInfoMation(person.name.first + '' + person.name.last, person.old, person.sex);
    if (type == 'call') return _buildPhoneNumber(person.numberPhone);
  }

  _cardItem(Person person, bool isItem) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Card(
          elevation: 12,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              10,
            ),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width - 60,
            height: MediaQuery.of(context).size.height - 200,
            child: Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      height: 149,
                      color: Color(0xFFF9F9F9),
                    ),
                    Divider(
                      height: 1,
                      color: Colors.black,
                    ),
                    Container(
                      height: 300,
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: 50,
                            margin: EdgeInsets.only(top: 30),
                            child: _buildDecription(person),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  IconButton(
                                      icon: Icon(
                                        Icons.location_on,
                                        size: 30,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          type = 'location';
                                        });
                                      }),
                                ],
                              ),
                              IconButton(
                                  icon: Icon(
                                    Icons.event_note,
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      type = 'info';
                                    });
                                  }),
                              IconButton(
                                  icon: Icon(
                                    Icons.call,
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      type = 'call';
                                    });
                                  }),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 40),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey[300]),
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  width: 150,
                  height: 150,
                  child: ClipOval(
                    child: Image.network(person.imageUrl, fit: BoxFit.cover,)
                  ),
                )
              ],
            ),
          ),
        ),
        StreamBuilder(
          stream: isShowLikeStreamController.stream,
          initialData: false,
          builder: (context, snapshot) => snapshot.data && isItem
              ? Padding(
                  padding: EdgeInsets.only(bottom: 120),
                  child: _buildLike(),
                )
              : Container(),
        ),
      ],
    );
  }

  _buildLocation(Location location) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        'Sống tại: ${location.street}, ${location.city}, ${location.state}',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold,
        
        ),
      ),
    );
  }

  _buildInfoMation(String name, int old, String sex) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(
            name,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '$old tuổi, $sex',
          )
        ],
      ),
    );
  }

  _buildPhoneNumber(String numberPhone) {
    return Container(
      child: Text(
        numberPhone,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  _buildLike() {
    return StreamBuilder(
      stream: isLikeStreamController.stream,
      initialData: false,
      builder: (context, snapshot) => Container(
        width: 200,
        height: 80,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            width: 3,
            color: Color(
              snapshot.data ? 0xff2E95EE : 0xffDC143C,
            ),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(
              5,
            ),
          ),
        ),
        child: Text(
          snapshot.data ? 'LIKE' : 'NOPE',
          style: TextStyle(
            color: Color(snapshot.data ? 0xff2E95EE : 0xffDC143C),
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    print(size.width);
    int i = 0;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        color: Colors.grey[200],
        child: Stack(
          alignment: Alignment.center,
          children: persons.map(
            (item) {
              print(i++);

              print(listOffset.length);
              var index = persons.indexOf(item);
              return StreamBuilder(
                initialData: listOffset,
                stream: posisonedController.stream,
                builder: (context, snapshot) => Positioned(
                  left: snapshot.data[index].dx == dx
                      ? dx
                      : snapshot.data[index].dx - (MediaQuery.of(context).size.width - 60) / 2,
                  top: snapshot.data[index].dy == dy
                      ? dy
                      : snapshot.data[index].dy - (MediaQuery.of(context).size.height - 200) / 2,
                  child: GestureDetector(
                    onPanStart: (details) {
                      isShowLikeStreamController.add(true);
                    },
                    onPanEnd: (details) {
                      isShowLikeStreamController.add(false);
                      if (snapshot.data[index].dx < (size.width / 3)) {
                        setState(() {
                          persons.removeLast();
                        });
                      } else {
                        setState(() {
                          persons.removeLast();
                          listFavorite.add(item);
                        });
                      }
                    },
                    onPanUpdate: (details) {
                      listOffset[index] =
                          Offset(details.localPosition.dx, details.localPosition.dy);
                      print(listOffset[index]);
                      posisonedController.add(listOffset);
                      if (snapshot.data[index].dx < (size.width / 3)) {
                        isLikeStreamController.add(false);
                      } else {
                        isLikeStreamController.add(true);
                      }
                    },
                    child: _cardItem(item, item == persons.last),
                  ),
                ),
              );
            },
          ).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ListFavorite(
                listFavorite,
              ),
            ),
          );
        },
        tooltip: 'Increment',
        child: Icon(Icons.favorite),
      ),
    );
  }
}
