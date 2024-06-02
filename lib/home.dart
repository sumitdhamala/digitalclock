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
        time = DateTime.parse(decodedResponse['datetime']);
      } else {
        print(decodedResponse["message"]);
      }
    } catch (e) {
      print(e);
    }
  }

  DateTime time = DateTime.now();
  Future<void> rebuild() async {
    await Future.delayed(Duration(seconds: 1), () async {
      time = time.add(Duration(seconds: 1));
      setState(() {});
      await rebuild();
    });
  }

  @override
  void initState() {
    getTime();
    rebuild();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateFormat date = DateFormat(' EEEE , MMMM, d');
    String formatedDate = date.format(time);
    var amPm = time.hour >= 12 ? 'PM' : 'AM';
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 207, 201, 201),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 206, 204, 204),
        title: Text(
          "Time",
          style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                getTime();
              });
            },
            icon: Icon(Icons.replay_outlined),
          )
        ],
      ),
      body: Column(children: [
        Divider(
          thickness: 4,
          color: Colors.blueGrey,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(width: 4, color: Colors.blueGrey),
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
                      Text(time.hour.toString(),
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
                        time.minute.toString(),
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
                            amPm,
                            style: TextStyle(
                                color: Color(0xffDFC445),
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 15),
                          Text(time.second.toString(),
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                        ],
                      )
                    ],
                  ),
                  Text(
                    formatedDate,
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
        SizedBox(
          height: 300,
        ),
        Text(
          "Made By:",
          style: TextStyle(
            fontSize: 17,
            color: Colors.grey,
          ),
        ),
        Text(
          "Name: Sumit Dhamala",
          style: TextStyle(
            fontSize: 17,
            color: Colors.grey,
          ),
        ),
        Text(
          "Email: sumit11dhamala@gmail.com",
          style: TextStyle(
            fontSize: 17,
            color: Colors.grey,
          ),
        ),
      ]),
    );
  }
}
