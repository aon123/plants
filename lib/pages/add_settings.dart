import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:plants/pages/home.dart';

class AddSettings extends StatefulWidget {
  const AddSettings({super.key});

  @override
  State<AddSettings> createState() => _AddSettingsState();
}

class _AddSettingsState extends State<AddSettings> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController temp = TextEditingController();
  final TextEditingController humidity = TextEditingController();
  final TextEditingController moisture = TextEditingController();
  String? selected_daylight = "";
  bool selected = false;

  List daylight = ['Low', 'Medium', 'High'];
  var dayl;

  addSetting() async {
    var url = 'http://43.201.136.217/add/settings';
    var body = {
      "humidity": humidity.text.toString(),
      "light": selected_daylight,
      "moisture": moisture.text.toString(),
      "name": _name.text.toString(),
      "selected": selected,
      "temp": temp.text.toString()
    };

    var data = await http.post(Uri.parse(url),
        body: json.encode(body),
        headers: {"Content-Type": "application/json"},
        encoding: Encoding.getByName("utf-8"));

    if (data.statusCode == 200) {
      Navigator.of(context).pop();
    } else {
      throw Exception('Failed to load data');
    }
  }

  checkSettingValues() {
    if (humidity.text.toString() != "" &&
        temp.text.toString() != "" &&
        moisture.text.toString() != "" &&
        _name.text.toString() != "" &&
        selected_daylight != "") {
      addSetting();
    } else {
      Fluttertoast.showToast(
          msg: "Please fill out all text fields",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.indigo[900],
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.black,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    _name.clear();
                    temp.clear();
                    humidity.clear();
                    moisture.clear();
                    selected_daylight = "";
                  });
                },
                icon: Icon(
                  Icons.refresh,
                  color: Colors.black,
                ))
          ],
          title: Text(
            "Add Setting",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Setting Name",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextField(
                    controller: _name,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[800]),
                        hintText: "Setting name",
                        fillColor: Colors.white),
                  ),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Temperature",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextField(
                        controller: temp,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            filled: true,
                            hintStyle: TextStyle(color: Colors.grey[800]),
                            hintText: "Temperature that will be keeped",
                            fillColor: Colors.white),
                      ),
                    ])),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Humidity",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextField(
                        controller: humidity,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            filled: true,
                            hintStyle: TextStyle(color: Colors.grey[800]),
                            hintText: "Humidity that will be keeped",
                            fillColor: Colors.white),
                      ),
                    ])),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Moisture",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextField(
                        controller: moisture,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            filled: true,
                            hintStyle: TextStyle(color: Colors.grey[800]),
                            hintText: "Moisture that will be keeped",
                            fillColor: Colors.white),
                      ),
                    ])),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Daylight",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.06,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              value: dayl,
                              items: daylight!.map((value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              hint: Container(
                                child: Text(
                                  "Daylight that will be keeped",
                                  style: TextStyle(color: Colors.grey),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  dayl = value;
                                  selected_daylight = dayl;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Use this setting',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          CupertinoSwitch(
                            value: selected,
                            activeColor: Colors.orangeAccent[400],
                            onChanged: (value) {
                              setState(() {
                                selected = value;
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.06,
                          child: ElevatedButton(
                            child: Text("Apply"),
                            onPressed: () {
                              checkSettingValues();
                            },
                          ),
                        ),
                      ),
                    ])),
          ],
        ));
  }
}
