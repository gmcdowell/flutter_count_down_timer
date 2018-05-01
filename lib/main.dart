import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    home: new MyApp(),
  ));
}

class Countdown extends AnimatedWidget {
  Countdown({ Key key, this.animation }) : super(key: key, listenable: animation);

  Animation<int> animation;

  String timerString(int count) {    
    var countDownTo = new Duration(seconds: count);
    return '${countDownTo.inHours}:${(countDownTo.inMinutes % 60).toString().padLeft(2, '0')}:${(countDownTo.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  build(BuildContext context){
    return new Text(
      timerString(animation.value),
      style: new TextStyle(fontSize: 80.0),
    );
  }


}

class MyApp extends StatefulWidget {
  State createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  AnimationController _controller;

  DateTime nextShift;
  Duration _duration;

  @override
  void initState() {
    super.initState();
    
    var currentTime = new DateTime.now();
    this.nextShift = currentTime.add(new Duration(hours: 1));
    this._duration = nextShift.difference(currentTime);

    _controller = new AnimationController(
      vsync: this,
      duration: this._duration,
    );

    _controller.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        child: new Center(
          child: new Countdown(
            animation: new StepTween(
              begin: this._duration.inSeconds,
              end: 0,
            ).animate(_controller),
          ),
        ),
      ),
    );
  }
}