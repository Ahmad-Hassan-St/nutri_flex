import 'package:fluttertoast/fluttertoast.dart';
import 'package:lifefit/constants/colors.dart';

void showToastMsg(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: kPrimaryColorGreen,
    textColor: kSecondaryDarkGreen,
  );
}