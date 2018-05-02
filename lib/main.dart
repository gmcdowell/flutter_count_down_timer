import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    home: new MyApp(),
  ));
}

class Countdown extends AnimatedWidget {
  Countdown({Key key, Animation<int> animation})
      : super(key: key, listenable: animation);

  String hoursString(Duration duration) => '${duration.inHours}';
  String minsString(Duration duration) =>
      '${(duration.inMinutes % 60).toString().padLeft(2, '0')}';
  String secsString(Duration duration) =>
      '${(duration.inSeconds % 60).toString().padLeft(2, '0')}';

  @override
  build(BuildContext context) {
    final Animation<int> animation = listenable;

    Duration duration = new Duration(seconds: animation.value);

    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      textBaseline: TextBaseline.alphabetic,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      children: <Widget>[
        new Text(
          hoursString(duration),
          style: new TextStyle(fontSize: 80.0),
        ),
        new Text(':', style: new TextStyle(fontSize: 80.0)),
        new Text(
          minsString(duration),
          style: new TextStyle(fontSize: 80.0),
        ),
        new Text(':', style: new TextStyle(fontSize: 80.0)),
        new Text(
          secsString(duration),
          style: new TextStyle(fontSize: 80.0),
        )
      ],
    );
  }
}

// class

class MyApp extends StatefulWidget {
  State createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<int> animation;

  DateTime nextShift;
  Duration _duration;

  @override
  void initState() {
    super.initState();

    var currentTime = new DateTime.now();
    this.nextShift = currentTime.add(new Duration(hours: 1));
    this._duration = nextShift.difference(currentTime);

    controller = new AnimationController(
      vsync: this,
      duration: this._duration,
    );

    animation = new StepTween(
      begin: this._duration.inSeconds,
      end: 0,
    ).animate(controller);

    controller.forward();
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        child: new Center(
          child: new Countdown(
            animation: animation,
          ),
        ),
      ),
    );
  }
}
