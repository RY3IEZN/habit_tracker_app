import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HabitTile extends StatelessWidget {
  const HabitTile({
    Key? key,
    required this.habitName,
    required this.onTap,
    required this.settingsBtnTapped,
    required this.timeSpent,
    required this.timeGoal,
    required this.isHabitStarted,
  }) : super(key: key);

  final String habitName;
  final VoidCallback onTap;
  final VoidCallback settingsBtnTapped;
  final int timeSpent;
  final int timeGoal;
  final bool isHabitStarted;

// convt secs to min
  String formatSecToMin(int totalSecs) {
    String secs = (totalSecs % 60).toString();
    String mins = (totalSecs / 60).toStringAsFixed(1);

// if sec is 1 digit number place a 0
    if (secs.length == 1) {
      secs = "0" + secs;
    }

    // if mins is a 1 digit number
    if (mins[1] == ".") {
      mins = mins.substring(0, 1);
    }

    return mins + ":" + secs;
  }

// calculate the %
  double percentComplete() {
    return timeSpent / (timeGoal * 60);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: onTap,
                  child: Container(
                    height: 60,
                    width: 60,
                    child: Stack(
                      children: [
                        CircularPercentIndicator(
                            radius: 30,
                            percent:
                                percentComplete() < 1 ? percentComplete() : 1,
                            progressColor: percentComplete() > 0.5
                                ? (percentComplete() > 0.75)
                                    ? Colors.green
                                    : Colors.orange
                                : Colors.red),
                        Center(
                          child: isHabitStarted
                              ? Icon(Icons.pause)
                              : Icon(Icons.play_arrow),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      habitName,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      formatSecToMin(timeSpent) +
                          "/" +
                          timeGoal.toString() +
                          " = " +
                          (percentComplete() * 100).toStringAsFixed(0) +
                          "%",
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
              ],
            ),
            GestureDetector(
                onTap: settingsBtnTapped, child: Icon(Icons.settings))
          ],
        ),
      ),
    );
  }
}
