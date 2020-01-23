import 'dart:math';
import 'package:analog_clock/clock_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClockDialPainter extends CustomPainter {
  final clockText;

  final hourTickMarkLength = 10.0;
  final minuteTickMarkLength = 5.0;
  final dateTime;

  var hour = 0;
  var min = 0.0;

  final Paint tickPaint;
  final TextPainter textPainter;

//  final TextStyle textStyle;

  final romanNumeralList = [
    'XII',
    'I',
    'II',
    'III',
    'IV',
    'V',
    'VI',
    'VII',
    'VIII',
    'IX',
    'X',
    'XI'
  ];

  ClockDialPainter({this.clockText, this.dateTime})
      : tickPaint = new Paint(),
        textPainter = new TextPainter(
          textAlign: TextAlign.center,
          textDirection: TextDirection.rtl,
        ) {
    tickPaint.color = Colors.transparent;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var tickMarkLength;
    final angle = 2 * pi / 60;
    final radius = size.width / 2;
    Paint paintBorder = Paint()
      ..color = Colors.blueGrey
      ..strokeWidth = size.width / 600
      ..style = PaintingStyle.stroke;

    canvas.save();
    canvas.translate(radius, radius);
    //checks if hour is greater than 12
    var currentHour = 0;
    currentHour = dateTime.hour >= 12 ? (dateTime.hour - 12) : dateTime.hour;

    //rounding off hour and minute to closest hand
    if (currentHour == 11) {
      if (dateTime.minute <= 30) {
        hour = currentHour;
      } else {
        hour = 0;
      }
      ;
    } else {
      if (dateTime.minute <= 30) {
        hour = currentHour;
      } else {
        hour = currentHour + 1;
      }
      ;
    }
    ;

    this.min = dateTime.minute <= 57 ? (dateTime.minute) / 5 : 0;

    //drawing
    for (var i = 0; i < 60; i++) {
      //make the length and stroke of the tick marker longer and thicker depending
      tickMarkLength = i % 5 == 0 ? hourTickMarkLength : minuteTickMarkLength;

      canvas.drawLine(new Offset(0.0, -radius),
          new Offset(25.0, -radius + tickMarkLength), tickPaint);

      //draw the text
      if (i % 5 == 0) {
        canvas.save();
        canvas.translate(0.0, -radius + 20.0);
        //circle design
        canvas.drawCircle(Offset(0, 110), radius - 140, paintBorder);
        //  canvas.drawCircle(Offset(0, 80), radius -  190, paintBorder);
        canvas.drawCircle(Offset(0, 1.1), radius - 140, paintBorder);
        textPainter.text = new TextSpan(children: <TextSpan>[
          // change second color respecting to second hand
          dateTime.second == i
              ? TextSpan(
                  text: this.clockText == ClockText.roman
                      ? '${romanNumeralList[i ~/ 5]}'
                      : '${i == 0 ? 12 : i ~/ 5}',
                  style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                )
              : TextSpan(children: <TextSpan>[
                  // change hour color respecting to hour hand
                  hour == (i / 5)
                      ? TextSpan(
                          text: this.clockText == ClockText.roman
                              ? '${romanNumeralList[i ~/ 5]}'
                              : '${i == 0 ? 12 : i ~/ 5}',
                          style: TextStyle(
                              fontSize: 45,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent),
                        )
                      : TextSpan(children: <TextSpan>[
                          // change minute color respecting to minute hand
                          min.round() == (i / 5)
                              ? TextSpan(
                                  text: this.clockText == ClockText.roman
                                      ? '${romanNumeralList[i ~/ 5]}'
                                      : '${i == 0 ? 12 : i ~/ 5}',
                                  style: TextStyle(
                                      fontSize: 45,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueAccent),
                                )
                              : TextSpan(
                                  text: this.clockText == ClockText.roman
                                      ? '${romanNumeralList[i ~/ 5]}'
                                      : '${i == 0 ? 12 : i ~/ 5}',
                                  style: TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.yellow,
                                  ),
                                )
                        ])
                ]),
        ]);

        //helps make the text painted vertically
        canvas.rotate(-angle * i);

        textPainter.layout();

        textPainter.paint(canvas,
            new Offset(-(textPainter.width / 2), -(textPainter.height / 2)));
        canvas.restore();
      }
      canvas.rotate(angle);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
