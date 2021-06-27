import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
//import 'package:medicine_reminder/src/ui/homepage/homepage.dart';

class SuccessScreen extends StatefulWidget {
  @override
  _SuccessScreenState createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(milliseconds: 2200),
      () {
        Navigator.popUntil(
          context,
          ModalRoute.withName('/'),
        );
      },
    );
  }

//Animation working
//added check animation
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.deepPurpleAccent,
      child: Center(
        child: Container(
          child: Center(
            child: FlareActor(
              "assets/animations/Filip.flr",
              alignment: Alignment.center,
              fit: BoxFit.contain,
              animation: "Untitled",
            ),
          ),
        ),
      ),
    );
  }
}
