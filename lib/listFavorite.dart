import 'package:flutter/material.dart';

import 'model/person.dart';

const Color defaultStartColor = Color(0xff2E95EE);
const Color defaultEndColor = Color(0xff6666ff);

class ListFavorite extends StatelessWidget {
  final List<Person> listFavorite;
  const ListFavorite(this.listFavorite);

  _buildPersonFavorite(Person person) {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 15, right: 15),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.grey,
        ),
        gradient: LinearGradient(
          colors: [defaultStartColor, defaultEndColor],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(
            10,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.8),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      height: 100,
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(5),
            width: 80,
            height: 80,
            child: ClipOval(
              child: Image.network(person.imageUrl, fit: BoxFit.cover,)
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                RichText(
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: person.name.first + '' + person.name.last,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: '\n${person.old} tuổi',
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(person.numberPhone),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Danh sách đã thích'),
        ),
        body: Container(
          child: ListView.builder(
            itemCount: listFavorite.length,
            itemBuilder: (BuildContext context, int index) {
              return _buildPersonFavorite(listFavorite[index]);
            },
          ),
        ),
      ),
    );
  }
}
