import 'package:flutter/material.dart';

class Echo extends StatefulWidget {
  const Echo({
    super.key,
    required this.text,
    this.backgroundColor = Colors.grey, //默认为灰色
  });

  final String text;

  final Color backgroundColor;

  @override
  State<StatefulWidget> createState() {
    return _EchoState();
  }
}

class _EchoState extends State<Echo> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: widget.backgroundColor,
        child: Column(
          children: [Text(widget.text)],
        ),
      ),
    );
  }
}
