import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Random Squares",
      home: RandomAquaresApp(),
    );
  }
}

class RandomAquaresApp extends StatefulWidget {
  @override
  RandomAquaresAppState createState() => RandomAquaresAppState();
}

class RandomAquaresAppState extends State<RandomAquaresApp> {
  final Random _random = Random();
  Color color = Colors.amber;

  void onTap() {
    setState(() {
      color = Color.fromRGBO(_random.nextInt(256), _random.nextInt(256),
          _random.nextInt(256), _random.nextDouble());
    });
  }

  @override
  Widget build(BuildContext context) {
    return ColorState(
      color: color,
      onTap: onTap,
      child: BoxTree(),
    );
  }
}

class ColorState extends InheritedWidget {
  ColorState({Key key, this.color, this.onTap, Widget child})
      : super(key: key, child: child);

  final Color color;
  final Function onTap;

  @override
  bool updateShouldNotify(ColorState oldWidget) {
    return color != oldWidget.color;
  }

  static of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(ColorState);
  }
}

class BoxTree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Random Squares"),
        ),
        body: Center(
          child: Row(
            children: <Widget>[
              Box(),
              Box(),
            ],
          ),
        ));
  }
}

class Box extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorState = ColorState.of(context);
    return GestureDetector(
      onTap: colorState.onTap,
      onHorizontalDragDown: (d) => print("Finger Down"),
      onHorizontalDragStart: (d) => print("starting drag"),
      onVerticalDragUpdate: (d) => print(""),
      onHorizontalDragUpdate: (d) => print("still dragging"),
      onHorizontalDragCancel: () => print("canceled drag"),
      onHorizontalDragEnd: (d) => print("End"),
      child: Container(
        width: 100.0,
        height: 100.0,
        margin: EdgeInsets.only(left: 80.0),
        color: colorState.color,
      ),
    );
  }
}
