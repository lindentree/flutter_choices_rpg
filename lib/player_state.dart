import 'package:flutter/material.dart';
import 'stats.dart';

class PlayerState extends StatelessWidget {
 
  const PlayerState();

  Widget build(BuildContext context) {
    final Stats stats = Stats.of(context);

    return Row(
      children: <Widget>[
        Expanded(
            child: Container(
          height: 20,
          child: Text('Health: ' + stats?.health.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.green,
                fontFamily: "Raleway-Medium",
                fontSize: 16.0,
              )),
        )),
     
        Expanded(
            child: Container(
          height: 20,
          child: Text('Cash: ${stats?.cash ?? "0"}',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.green,
                fontFamily: "Raleway-Medium",
                fontSize: 16.0,
              )),
        )),
      ],
    );
  }
}