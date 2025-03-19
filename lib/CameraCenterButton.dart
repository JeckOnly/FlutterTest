import 'package:flutter/material.dart';

class CameraCenterbutton extends StatefulWidget {
  const CameraCenterbutton({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CameraCenterState();
  }
}

class CameraCenterState extends State<CameraCenterbutton> with SingleTickerProviderStateMixin {
  CameraState cameraState = CaptureState();

  bool pressed = false;

  final double stokeWidth = 5;
  final double fullCircleRadius = 45.0;
  final double littleRectRadius = 20.0;
  final double fullCornerRadius = 45.0;
  final double littleCornerRadius = 10.0;

  late AnimationController _controller;

  late Animation<double> _radiusAnimation;
  late Animation<double> _cornerRadiusAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _radiusAnimation = Tween<double>(begin: fullCircleRadius, end: littleRectRadius).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _cornerRadiusAnimation = Tween<double>(begin: fullCornerRadius, end: littleCornerRadius).animate(_controller)
      ..addListener(() {
        setState(() {});
      });



  }


  @override
  Widget build(BuildContext context) {
    // onTapDown: (details) {
    //   print("onTapDown");
    // },
    // onTapUp: (details) {
    //   print("onTapUp");
    // },
    // onLongPress: () {
    //   print("onLongPress");
    //   // _updateCameraState();
    // },
    // onLongPressEnd: (details) {
    //   print("onLongPressEnd");
    // },
    // onLongPressDown: (details) {
    //   print("onLongPressDown");
    // },
    // onLongPressStart: (details) {
    //   print("onLongPressStart");
    // },
    // onLongPressMoveUpdate: (details) {
    //   print("onLongPressMoveUpdate");
    // },
    // onLongPressUp: () {
    //   print("onLongPressUp");
    // },

    return Center(
        child: GestureDetector(
      onTap: () => {
        print("onTap"),
        _updateCameraState()
      },
      child: CustomPaint(
        size: Size(100, 100), //指定画布大小
        painter: CameraCenterButtonPainter(
          stokeWidth: stokeWidth,
          nowRadius: _radiusAnimation.value,
          cornerRadius: _cornerRadiusAnimation.value,
        ),
      ),
    ));
  }

  void _updateCameraState() {
    print("当前类型: ${cameraState.runtimeType}");
    setState(() {
      switch (cameraState) {
        case CaptureState _:
          cameraState = RecordIdleState();
          break;
        case RecordIdleState _:
          cameraState = RecordRecordingState();
          _controller.forward();
          break;
        case RecordRecordingState _:
          cameraState = RecordIdleState();
          _controller.reverse();
          break;
        default:
          cameraState = CaptureState();
      }
      print("目标类型： ${cameraState.runtimeType}");
    });
  }
}

class CameraCenterButtonPainter extends CustomPainter {
  CameraCenterButtonPainter(
      {required this.stokeWidth,
      required this.nowRadius,
      required this.cornerRadius});

  final double stokeWidth;
  late double nowRadius;
  late double cornerRadius;

  @override
  void paint(Canvas canvas, Size size) {
    final double ringRadius = size.width / 2;

    Color centerColor;
    // if (cameraState.runtimeType == CaptureState) {
    centerColor = Colors.green;
    // } else {
    //   centerColor = Colors.red;
    // }

    // Paint for the white ring
    final Paint ringPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = stokeWidth;

    // Paint for the red circle
    final Paint circlePaint = Paint()
      ..color = centerColor
      ..style = PaintingStyle.fill;

    // Draw the white ring
    canvas.drawCircle(size.center(Offset.zero), ringRadius, ringPaint);

    // Draw the red circle inside the ring
    // canvas.drawCircle(size.center(Offset.zero), circleRadius, circlePaint);

    // Draw the rounded rectangle inside the ring

    double left = ringRadius - nowRadius;
    double top = ringRadius - nowRadius;
    double right = size.width - left;
    double bottom = size.height - top;
    final RRect roundedRect = RRect.fromRectAndRadius(
      Rect.fromLTRB(
        left,
        top,
        right,
        bottom,
      ),
      Radius.circular(cornerRadius),
    );
    canvas.drawRRect(roundedRect, circlePaint);
  }

  @override
  bool shouldRepaint(CameraCenterButtonPainter oldDelegate) {
    return oldDelegate.nowRadius != nowRadius || oldDelegate.cornerRadius != cornerRadius;
  }
}

class CameraState {}

class RecordState implements CameraState {}

class RecordIdleState implements RecordState {}

class RecordRecordingState implements RecordState {}

class CaptureState implements CameraState {}
