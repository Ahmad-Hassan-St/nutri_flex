import 'dart:ui' ;

import 'package:flutter/material.dart';


class ScannerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double scannerWidth = 300;
    double scannerHeight = 380;
    double scannerLeft = (size.width - scannerWidth) / 2;
    double scannerTop = (size.height - scannerHeight) / 2;

    path.addRect(Rect.fromLTRB(0, 0, size.width, size.height));
    path.addRRect(RRect.fromRectAndRadius(
      Rect.fromLTRB(scannerLeft, scannerTop, scannerLeft + scannerWidth,
          scannerTop + scannerHeight),
      const Radius.circular(20),
    ));
    path.fillType = PathFillType.evenOdd;

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class LinePainter extends CustomPainter {
  final double position;

  LinePainter(this.position);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green
      ..strokeWidth = 4;

    final yPos = position * size.height;
    canvas.drawLine(Offset(0, yPos), Offset(size.width, yPos), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}


class ScannerOverlay extends StatelessWidget {
  final Animation<double> animation;

  ScannerOverlay({required this.animation});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: 300,
              height: 380,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: AnimatedBuilder(
              animation: animation,
              builder: (context, child) {
                return CustomPaint(
                  painter: LinePainter(animation.value),
                );
              },
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20)),
              ),
              padding: const EdgeInsets.all(8),
              child: const Text(
                'Scan meal',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}