// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class Clock extends StatefulWidget {
  const Clock({super.key});

  @override
  State<Clock> createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  DateTime now = DateTime.now();
  Map<String, dynamic> data = {};

  Future<void> getTime() async {
    try {
      var response = await http.get(
          Uri.parse("http://worldtimeapi.org/api/timezone/Asia/Kathmandu"));
      var decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // print(decodedResponse);
        data = decodedResponse;
      } else {
        print(decodedResponse["message"]);
      }
    } catch (e) {
      print(e);
    }
  }

  rebuild() async {
    await Future.delayed(Duration(seconds: 1), () {
      setState(() {
        getTime();
      });
    });
  }

  @override
  void initState() {
    rebuild();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var datetimenow = data['datetime'] ?? now.toString();
    var formatedDatefromapi = DateTime.parse(datetimenow);
    DateTime formatedTimefromapi = DateTime.parse(data["datetime"]);

    var date = DateFormat('EEE, MMM d').format(formatedDatefromapi);
    // var timef = DateFormat('HH:mm:ss').format(formatedTimefromapi);
    // DateTime time = DateTime.parse(timef);

    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text(
          "Time",
          style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 194, 194, 221)),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await getTime();
              var formatedDate = DateTime.parse(data["datetime"]);
              print(formatedDate);

              var teest = DateFormat('EEE, MMM d').format(formatedDate);
              print(teest);
            },
            icon: Icon(Icons.replay_outlined),
          )
        ],
      ),
      body: Column(children: [
        Divider(
          thickness: 4,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(
                    width: 4, color: Color.fromARGB(255, 194, 194, 221)),
                borderRadius: BorderRadius.circular(10),
                color: Color.fromARGB(255, 32, 37, 43)),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(formatedTimefromapi.hour.toString(),
                          style: TextStyle(
                            fontSize: 90,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(253, 3, 19, 244),
                          )),
                      Column(
                        children: [
                          SizedBox(
                            height: 9,
                          ),
                          Icon(
                            Icons.circle,
                            size: 12,
                            color: const Color.fromARGB(255, 75, 71, 71),
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          Icon(
                            Icons.circle,
                            size: 12,
                            color: const Color.fromARGB(255, 75, 71, 71),
                          ),
                        ],
                      ),
                      Text(
                        formatedTimefromapi.minute.toString(),
                        style: TextStyle(
                            fontSize: 90,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange),
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Pm",
                            style: TextStyle(
                                color: Color(0xffDFC445),
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 15),
                          Text(formatedTimefromapi.second.toString(),
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                        ],
                      )
                    ],
                  ),
                  Text(
                    date.toString(),
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink),
                  )
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
