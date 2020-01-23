import 'package:analog_clock/clock_text.dart';
import 'package:flutter/material.dart';
import 'package:analog_clock/clock_dial_painter.dart';
import 'package:analog_clock/hand.dart';

class ClockFace extends StatelessWidget {
  final DateTime dateTime;
  final ClockText clockText;

  ClockFace({this.clockText, this.dateTime});

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.all(1.0),
      child: new AspectRatio(
        aspectRatio: 1,
        child: new Container(
          //padding: EdgeInsets.all(20.0),
          width: double.infinity,
          decoration: new BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              new BoxShadow(
                offset: new Offset(0.0, 0.0),
                blurRadius: 105.0,
              )
            ],
            color: Colors.transparent,
          ),
          child: new Stack(
            children: <Widget>[
              //dial and numbers

              new Container(
//                color: Colors.black,
                width: double.infinity,
                height: double.infinity,
                //padding: const EdgeInsets.all(1.0),
                child: new CustomPaint(
                  painter: new ClockDialPainter(
                      clockText: this.clockText, dateTime: this.dateTime),
                ),
              ),
              // hands

              new ClockHands(dateTime: dateTime),
            ],
          ),
        ),
      ),
    );
  }
}
