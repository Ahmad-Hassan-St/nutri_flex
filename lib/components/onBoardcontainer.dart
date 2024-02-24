import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class onboardContainer extends StatelessWidget {
  late String text1;
  late String text2;
  final VoidCallback onpressed;
  final IconData? icon;
  late double progress;

  onboardContainer({
    super.key,
    required this.text1,
    required this.text2,
    required this.onpressed,
    required this.progress,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFf6f7f7),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 28.0),
            child: Text(
              text1,
              style: const TextStyle(
                  fontFamily: "Zen Kaku Gothic Antique",
                  fontSize: 26,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            text2,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: "Zen Kaku Gothic Antique",
              fontSize: 15,
            ),
          ),
          const SizedBox(
            height: 70,
          ),
          Container(
            child: CircularPercentIndicator(
              radius: 40,
              lineWidth: 3,
              percent: progress,
              progressColor: const Color(0xFF19B888),
              circularStrokeCap: CircularStrokeCap.round,
              backgroundColor: const Color(0xFFB8C7CB),
              center: FittedBox(
                child: FloatingActionButton(
                  heroTag: null,
                  elevation: 0,
                  backgroundColor: const Color(0xFF173430),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  onPressed: onpressed,
                  child: icon != null
                      ? Icon(
                          icon,
                          color: Colors.white,
                          size: 18,
                        )
                      : const Text(
                          "Start",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Zen Kaku Gothic Antique",
                              fontSize: 10),
                        ), //
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
