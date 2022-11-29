import 'package:flutter/material.dart';
import 'package:plants/pages/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlantName extends StatefulWidget {
  const PlantName({super.key});

  @override
  State<PlantName> createState() => _PlantNameState();
}

class _PlantNameState extends State<PlantName> {
  final TextEditingController _name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2db83d),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/plant2.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 200,
              ),
              Text(
                "Enter your plant name",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _name,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      filled: true,
                      hintStyle: TextStyle(color: Colors.grey[800]),
                      hintText: "name",
                      fillColor: Colors.white),
                ),
              ),
              const SizedBox(
                height: 200,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.05,
                child: ElevatedButton(
                  onPressed: () async {
                    var prefs = await SharedPreferences.getInstance();
                    prefs.setString('name', _name.text.toString());
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => Home()),
                        (route) => false);
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.greenAccent[400],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: const Text(
                    "Continue",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ]),
      ),
    );
  }
}
