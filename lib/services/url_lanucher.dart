import 'dart:developer';

import 'package:url_launcher/url_launcher.dart';

class ContactUs{
  static void launchPhone() async {
    final phoneNumber="+923235025632";
    final url = 'tel:$phoneNumber';
    var uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }
  static Future<bool> open(String url) async {
    try {
      await launch(
        url,
        enableJavaScript: true,
      );
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}