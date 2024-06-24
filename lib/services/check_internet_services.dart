import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class CheckInternetConnectionWidget extends StatelessWidget {
  final AsyncSnapshot<ConnectivityResult> snapshot;
  final Widget widget;

  const CheckInternetConnectionWidget(
      {Key? key, required this.snapshot, required this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (snapshot.connectionState) {
      case ConnectionState.active:
        final state = snapshot.data!;
        switch (state) {
          case ConnectivityResult.none:
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.wifi_off_rounded,
                  size: 80,
                ),
                 Center(child: Text('Check Internet access',style: Theme.of(context).textTheme.displayMedium,)),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(Size(150, 50)), // set your desired width and height here

                  ),
                    onPressed: () async {
                      ConnectivityResult result =
                          await Connectivity().checkConnectivity();
                      print(result);
                    },
                    child:  Text("Refresh",style:Theme.of(context).textTheme.displayLarge,)),
              ],
            );
          default:
            return widget;
        }
      // break;
      default:
        return const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.wifi_off_rounded,
              size: 50,
            ),
            Center(
              child: Text('No Internet access'),
            ),
          ],
        );
    }
  }
}
