import 'dart:async';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? title;
  Map? temp;
  Map? humidity;
  Map? moisture;
  Map? light;
  List? settings;
  var selected_setting;
  String? selectName;
  Map? select_setting;

  getTitle() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      title = prefs.getString('name');
    });
  }

  getSelectedSetting() async {
    final response =
        await http.get(Uri.parse('http://43.201.136.217/get/setting'));
    if (response.statusCode == 200) {
      setState(() {
        select_setting = json.decode(response.body);
        print(select_setting);
        if (select_setting != null) {
          selectName = select_setting!['name'];
        } else {
          selectName = "None";
        }
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  getTemp() async {
    final response =
        await http.get(Uri.parse('http://43.201.136.217/sensor/temp'));
    if (response.statusCode == 200) {
      setState(() {
        temp = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

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

  setSelectSetting(String id) async {
    var url = 'http://43.201.136.217/select/setting';
    var body = {"_id": id};

    var data = await http.post(Uri.parse(url),
        body: json.encode(body),
        headers: {"Content-Type": "application/json"},
        encoding: Encoding.getByName("utf-8"));

    if (data.statusCode == 200) {
      setState(() {
        select_setting = json.decode(data.body);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  getHumidity() async {
    final response =
        await http.get(Uri.parse('http://43.201.136.217/sensor/humidity'));
    if (response.statusCode == 200) {
      setState(() {
        humidity = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  getLight() async {
    final response =
        await http.get(Uri.parse('http://43.201.136.217/sensor/light'));
    if (response.statusCode == 200) {
      setState(() {
        light = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  getMoisture() async {
    final response =
        await http.get(Uri.parse('http://43.201.136.217/sensor/moisture'));
    if (response.statusCode == 200) {
      setState(() {
        moisture = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  activateWater() async {
    final response =
        await http.get(Uri.parse('http://43.201.136.217/activate/pump'));
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Water pump activated for 20 seconds",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.indigo[900],
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      throw Exception('Failed to load data');
    }
  }

  activateFan() async {
    final response =
        await http.get(Uri.parse('http://43.201.136.217/activate/fan'));
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Fan activated for 20 seconds",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.indigo[900],
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      throw Exception('Failed to load data');
    }
  }

  activateLight() async {
    final response =
        await http.get(Uri.parse('http://43.201.136.217/activate/led'));
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "LED light activated for 20 seconds",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.indigo[900],
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTitle();
    getSelectedSetting();
    getSettings();
    getHumidity();
    getLight();
    getMoisture();
    getTemp();
  }

  @override
  Widget build(BuildContext context) {
    if (temp != null &&
        humidity != null &&
        moisture != null &&
        light != null &&
        select_setting != null &&
        settings != null) {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Stack(
          children: [
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      color: const Color(0xFF2db83d),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height * 0.055,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20.0),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                value: selected_setting,
                                items: settings!.map((value) {
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(value['name']),
                                  );
                                }).toList(),
                                hint: Container(
                                  child: Text(
                                    "Select Auto-care Settings",
                                    style: TextStyle(color: Colors.grey),
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    selected_setting = value;
                                  });
                                  print(selected_setting['_id']);
                                  setSelectSetting(selected_setting['_id']);
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  height: MediaQuery.of(context).size.height *
                                      0.125,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(30.0)),
                                  child: ElevatedButton(
                                      onPressed: () {
                                        activateWater();
                                      },
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.0)),
                                          primary: Colors.orangeAccent[400]),
                                      child: Center(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.water),
                                          Text("Water"),
                                        ],
                                      )))),
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  height: MediaQuery.of(context).size.height *
                                      0.125,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(30.0)),
                                  child: ElevatedButton(
                                      onPressed: () {
                                        activateFan();
                                      },
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.0)),
                                          primary: Colors.orangeAccent[400]),
                                      child: Center(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.wind_power),
                                          Text("Wind"),
                                        ],
                                      )))),
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  height: MediaQuery.of(context).size.height *
                                      0.125,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(30.0)),
                                  child: ElevatedButton(
                                      onPressed: () {
                                        activateLight();
                                      },
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.0)),
                                          primary: Colors.orangeAccent[400]),
                                      child: Center(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.light),
                                          Text("Light"),
                                        ],
                                      )))),
                            ]),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: 80,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Text(
                            "|",
                            style: TextStyle(
                                color: Colors.orangeAccent[400],
                                fontWeight: FontWeight.bold,
                                fontSize: 22),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "$title",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                color: Colors.green),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          getHumidity();
                          getLight();
                          getMoisture();
                          getTemp();
                        },
                        child: Icon(
                          Icons.refresh,
                          color: Colors.green,
                        ))
                  ],
                ),
                SizedBox(
                  height: 60,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Image(
                        image: AssetImage('assets/plant3.png'),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "|",
                                style: TextStyle(
                                    color: Colors.orangeAccent[400],
                                    fontSize: 42),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${temp!['value']} \u00B0C",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                        color: Colors.green),
                                  ),
                                  Text(
                                    "Temperature",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.grey[600]),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                "|",
                                style: TextStyle(
                                    color: Colors.orangeAccent[400],
                                    fontSize: 42),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${humidity!['value']} %",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                        color: Colors.green),
                                  ),
                                  Text(
                                    "Humidity",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.grey[600]),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                "|",
                                style: TextStyle(
                                    color: Colors.orangeAccent[400],
                                    fontSize: 42),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${moisture!['value']} %",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                        color: Colors.green),
                                  ),
                                  Text(
                                    "Soil moisture",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.grey[600]),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                "|",
                                style: TextStyle(
                                    color: Colors.orangeAccent[400],
                                    fontSize: 42),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (light!['value'] > 700)
                                    const Text(
                                      'High',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22,
                                          color: Colors.green),
                                    ),
                                  if (light!['value'] < 700 &&
                                      light!['value'] > 400)
                                    const Text(
                                      'Medium',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22,
                                          color: Colors.green),
                                    ),
                                  if (light!['value'] < 300)
                                    const Text(
                                      'Low',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22,
                                          color: Colors.green),
                                    ),
                                  Text(
                                    "Day light",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.grey[600]),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                "|",
                                style: TextStyle(
                                    color: Colors.orangeAccent[400],
                                    fontSize: 42),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${select_setting!['name']}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                        color: Colors.green),
                                  ),
                                  Text(
                                    "Auto-care Status",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.grey[600]),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    }
    return Container();
  }
}
