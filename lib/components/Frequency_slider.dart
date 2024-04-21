import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:lifefit/constants/colors.dart';

class RadioFrequencySlider extends StatefulWidget {
  final void Function(double) onValueChanged;
  double intialValue;
  double currentVal = 100.0; // Initial value
  double minCurrentVal = 100.0; // Minimum value (scaled to 100)
  double maxCurrentVal = 200.0;

  RadioFrequencySlider({
    super.key,
    required this.onValueChanged,
    this.currentVal=100,
    this.minCurrentVal=100,
    this.maxCurrentVal=200,
    this.intialValue=120,
  });

  @override
  _RadioFrequencySliderState createState() => _RadioFrequencySliderState();
}

class _RadioFrequencySliderState extends State<RadioFrequencySlider> {
 late double _currentVal ; // Initial value
  double get currentVal => _currentVal;
  set currentVal(double value) {
    setState(() {
      _currentVal = value;
    });
  }

  double get _minCurrentVal => widget.minCurrentVal;
  double get _maxCurrentVal => widget.maxCurrentVal;
  double _ratio = 10; // Ratio for drawing ticks
  late double _touchStart; // Touch start position
  late double _touchEnd; // Current touch position

  @override
  void initState() {
    super.initState();
    _currentVal = widget.intialValue;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onHorizontalDragStart: (details) {
            setState(() {
              _touchStart = details.localPosition.dx;
              _touchEnd = _currentVal;
            });
          },
          onHorizontalDragUpdate: (details) {
            double delta = details.localPosition.dx - _touchStart;
            double currentVal = _touchEnd -
                (delta /
                    (_maxCurrentVal - _minCurrentVal) *
                    (_maxCurrentVal - _minCurrentVal));
            _currentVal = currentVal.clamp(_minCurrentVal, _maxCurrentVal);
            setState(() {
              widget.onValueChanged(_currentVal);
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: CustomPaint(
              size: Size(double.infinity, 140),
              painter: FrequencyRulerPainter(
                currentVal: _currentVal,
                minCurrentVal: _minCurrentVal,
                maxCurrentVal: _maxCurrentVal,
                ratio: _ratio,
              ),
            ),
          ),
        ),
        // Text(_currentVal.toInt().toString(),style: Theme.of(context).textTheme.displayLarge,),
      ],
    );
  }
}

class FrequencyRulerPainter extends CustomPainter {
  final double currentVal;
  final double minCurrentVal;
  final double maxCurrentVal;
  final double ratio;

  FrequencyRulerPainter({
    required this.currentVal,
    required this.minCurrentVal,
    required this.maxCurrentVal,
    required this.ratio,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint linePaint = Paint()
      ..color = greyColor.withOpacity(0.6)
      ..strokeWidth = 2.0;

    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final Paint centerLinePaint = Paint()
      ..color = greenColor
      ..strokeWidth = 3.0;
    // Draw center line
    canvas.drawLine(Offset(centerX, centerY - 20),
        Offset(centerX, centerY + 50), centerLinePaint);

    // Draw tick marks and labels
    for (double i = minCurrentVal; i <= maxCurrentVal; i += 1) {
      final double x = centerX + (i - currentVal) * ratio;
      final double y1 = centerY - 5;
      final double y2 = centerY + (i % ratio == 0 ? 30 : 20);

      // Draw tick mark
      canvas.drawLine(Offset(x, y1), Offset(x, y2), linePaint);

      // Draw label
      if (i % ratio == 0) {
        final text = (i > 100 ? (i / ratio).toStringAsFixed(0) : '100');
        TextSpan span = TextSpan(
            style: const TextStyle(color: Colors.white, fontSize: 12),
            text: text);
        TextPainter tp = TextPainter(
            text: span,
            textAlign: TextAlign.center,
            textDirection: TextDirection.ltr);
        tp.layout();
        tp.paint(canvas, Offset(x - tp.width / 2, centerY + 60));
      }
    }

    for (double i = minCurrentVal; i <= maxCurrentVal; i += 10) {
      // Draw labels every 10 units
      final double x = centerX + (i - currentVal) * ratio;
      final double labelY = centerY + 60;
      // Draw label
      final text = (i).toStringAsFixed(0);
      TextSpan span = TextSpan(
          style: const TextStyle(
            color: secondaryDarkGreen,
            fontSize: 14,
            fontFamily: "Zen Kaku Gothic Antique",
            fontWeight: FontWeight.w900,
          ),
          text: text);
      TextPainter tp = TextPainter(
          text: span,
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr);
      tp.layout();
      tp.paint(canvas, Offset(x - tp.width / 2, labelY));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
