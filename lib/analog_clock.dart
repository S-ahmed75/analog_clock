import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:analog_clock/clock_face.dart';
import 'package:analog_clock/clock_text.dart';
import 'dart:async';

class AnalogClock extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Clock(),
    );
  }
}

class Clock extends StatefulWidget {
  final Duration updateDuration = const Duration(seconds: 1);

  @override
  State<StatefulWidget> createState() {
    return _Clock();
  }
}

class _Clock extends State<Clock> {
  Timer _timer;
  DateTime dateTime;
  var _temperature = 0;
  var _temperatureRange = '';
  var _condition = '';
  var _location = '';
  var _lowTemp = 0;

  var _highTemp = 0;

  @override
  void initState() {
    super.initState();
    dateTime = new DateTime.now();
    this._timer = new Timer.periodic(widget.updateDuration, setTime);
    this._temperature = 33;
    this._location = 'Mountain View, CA';
    this._highTemp = _temperature + 4;
    this._lowTemp = _temperature - 8;
    this._temperatureRange = '$_lowTemp - $_highTemp';
    this._condition = 'Sunny';
  }

  void setTime(Timer timer) {
    setState(() {
      dateTime = DateTime.now();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final weatherInfo = DefaultTextStyle(
      style: TextStyle(color: Colors.black, fontSize: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('$_temperature °C'),
          Text('($_temperatureRange °C )'),
          Text(_condition),
          Text(_location),
        ],
      ),
    );

    return new Scaffold(
        body: new SafeArea(
            bottom: true,
            child: new Center(
                child: AspectRatio(
              aspectRatio: 5 / 3,
              child: new Stack(children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  child: new ClockFace(
                    clockText: ClockText.roman,
                    dateTime: dateTime,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 30),
                  alignment: Alignment.centerLeft,
                  child: weatherInfo,
                )
              ]),
            ))));
  }
}
