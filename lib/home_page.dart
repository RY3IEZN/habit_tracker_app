import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'widget/habit_tile.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List habitList = [
    ["Exercise", false, 0, 1],
    ["read", false, 0, 15],
    ["code", false, 0, 45],
    ["Eat", false, 0, 21],
    ["Chillout", false, 0, 25]
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text("Consistency is key"),
        centerTitle: true,
        backgroundColor: Colors.grey[900],
      ),
      body: ListView.builder(
        itemCount: habitList.length,
        itemBuilder: (BuildContext context, int index) {
          return HabitTile(
              habitName: habitList[index][0],
              onTap: () {
                startStopHabit(index);
              },
              settingsBtnTapped: () {
                settingsBtnTapped();
              },
              timeSpent: habitList[index][2],
              timeGoal: habitList[index][3],
              isHabitStarted: habitList[index][1]);
        },
      ),
    );
  }

  void startStopHabit(int index) {
    // start and stop
    setState(() {
      habitList[index][1] = !habitList[index][1];
    });

    // start and stop the timer
    // 1.note what the start time is
    // start the timer only when the isStarted == true
    var startTime = DateTime.now();
    print(startTime);

// add the already spent time
    var elaspsedTime = habitList[index][2];

    if (habitList[index][1]) {
      // inbuilt timer
      Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          if (!habitList[index][1]) {
            timer.cancel();
          }
// 2. calculate the timespent by (currentTime - startTime)
          var currentTime = DateTime.now();
          habitList[index][2] = elaspsedTime +
              currentTime.second -
              startTime.second +
              60 * (currentTime.minute - startTime.minute) +
              60 * (currentTime.hour - startTime.hour);
        });
      });
    }
  }

  void settingsBtnTapped() {
    showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            title: Text("Settings"),
          );
        }));
  }
}
