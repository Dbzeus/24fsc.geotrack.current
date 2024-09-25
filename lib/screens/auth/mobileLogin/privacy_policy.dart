import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:geotrack24fsc/helpers/colors.dart';
import 'package:get/get.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  PrivacyPolicyScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    dynamic url = WebUri("https://dbzeus.com/privacy-policy-2/");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          "Privacy Policy",
          style: TextStyle(fontSize: 14, color: whiteColor),
        ),
        leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back,
              color: whiteColor,
            )),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: url),
      ),
    );
  }
}
