import 'package:flutter/material.dart';
import 'package:mapas_app/markers/markers.dart';

class TestMarkerScreen extends StatelessWidget {
  const TestMarkerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.blue,
          width: 30,
          height: 30,
          child: CustomPaint(
            painter: HouseMarkerPainter(Colors.yellow),
          ),
        )
      ),
    );
  }
}
