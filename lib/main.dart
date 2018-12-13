import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
//import 'package:intl/intl_browser.dart' as dateformat;

void main() async {
  Map _data = await getJSON();
  List _feature = _data['features'];
  runApp(new MaterialApp(
    title: "Earthquake App",
    home: new Scaffold(
      appBar: new AppBar(
        title: new Text("Earthquake Info"),
        backgroundColor: Colors.red,
      ),
      body: new Center(
          child: new ListView.builder(
        itemCount: _feature.length,
        itemBuilder: (BuildContext context, int position) {
          return new Container(
            child: new ListTile(
              onTap: () => _onTapAction(context,
                  "Magnitude-${_feature[position]['properties']['mag']} \n${_feature[position]['properties']['place']}"),
              leading: new CircleAvatar(
                backgroundColor: Colors.green,
                child: new Text(
                  '${_feature[position]['properties']['mag']}',
                  style: new TextStyle(fontSize: 14.0, color: Colors.redAccent),
                ),
              ),
              title: new Text(
                getDate(_feature[position]['properties']['time']),
                style: new TextStyle(fontSize: 20.0),
              ),
              subtitle: new Text(
                '${_feature[position]['properties']['place']}',
                style: new TextStyle(fontSize: 15.0),
              ),
            ),
            decoration: new BoxDecoration(
                border: BorderDirectional(bottom: new BorderSide())),
          );
        },
      )),
    ),
  ));
}

Future<Map> getJSON() async {
  final apiurl =
      "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson";
  http.Response response = await http.get(apiurl);
  return json.decode(response.body);
}

void _onTapAction(BuildContext context, String message) {
  var alert = new AlertDialog(
    content: new Text(message),
    title: new Text("Earthquake"),
    actions: <Widget>[
      new FlatButton(
        child: new Text("OK"),
        textColor: Colors.blue,
        onPressed: () => Navigator.pop(context),
      )
    ],
  );
  showDialog(context: context, builder: (context) => alert);
}

String getDate(int date) {
  DateTime date1 = new DateTime.fromMillisecondsSinceEpoch(date);
  return date1.toString();
}
