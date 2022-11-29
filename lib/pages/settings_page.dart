import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:plants/pages/add_settings.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  List? settings;
  int? selected;

  getSettings() async {
    final response =
        await http.get(Uri.parse('http://43.201.136.217/settings'));
    if (response.statusCode == 200) {
      setState(() {
        settings = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  deleteSetting(String id) async {
    var url = 'http://43.201.136.217/delete/settings';
    var body = {
      "_id": id,
    };

    var data = await http.post(Uri.parse(url),
        body: json.encode(body),
        headers: {"Content-Type": "application/json"},
        encoding: Encoding.getByName("utf-8"));

    if (data.statusCode == 200) {
      getSettings();
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        title: Text(
          "Settings",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => AddSettings()))
                    .then((value) => getSettings());
              },
              icon: Icon(
                CupertinoIcons.plus_app,
                color: Colors.green,
              ))
        ],
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                    itemCount: settings == null ? 0 : settings!.length,
                    itemBuilder: (context, i) {
                      if (settings![i]['_id'] != "Y3DYTVQJST") {
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, bottom: 8.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.15,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: const Color(0xFF2db83d),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(30.0)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "${settings![i]['name']}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22),
                                ),
                                VerticalDivider(
                                  thickness: 2,
                                  color: Colors.orangeAccent[400],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Temperature: ",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              "${settings![i]['temp']}",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Humidity: ",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              "${settings![i]['humidity']}",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Light: ",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              "${settings![i]['light']}",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Moisture: ",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              "${settings![i]['moisture']}",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          deleteSetting(settings![i]['_id']);
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          size: 30,
                                          color: Colors.red,
                                        )),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      }
                      return Container();
                    }),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.07,
              )
            ],
          ),
          if (settings == null ? true : settings!.length == 1)
            Align(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(
                                  builder: (_) => const AddSettings()))
                              .then((value) => getSettings());
                        },
                        icon: Icon(
                          CupertinoIcons.plus_app,
                          size: 40,
                          color: Colors.green,
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Create Setting",
                      style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )),
        ],
      ),
    );
  }
}
