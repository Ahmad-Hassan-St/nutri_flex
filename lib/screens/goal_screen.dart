import 'package:flutter/material.dart';

class extra extends StatelessWidget {
  const extra({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Text(
              "Huzaifa meri jan",
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontSize: 50,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/images/logo.png',
                  // Replace 'image.jpg' with your image asset path
                  width: 100.0,
                  height: 100.0,
                ),
                const SizedBox(height: 10.0),
                const Text(
                  'Hello, Flutter!',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
