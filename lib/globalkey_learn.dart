import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GlobalKeyChild extends StatefulWidget {
  static GlobalKey<_GlobalKeyChildState> globalKey = GlobalKey();

  GlobalKeyChild():super(key: globalKey);

  @override
  _GlobalKeyChildState createState() => _GlobalKeyChildState();
}

class _GlobalKeyChildState extends State<GlobalKeyChild> {

  Color _color = Colors.red;

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      color: _color,
      child: Text('Color'),
    );
  }

  void changeColor() {
    setState(() {
      _color = Colors.blue;
    });
  }
}