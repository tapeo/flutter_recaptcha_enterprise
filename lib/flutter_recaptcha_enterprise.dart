import 'dart:async';

import 'package:flutter_recaptcha_enterprise/recaptcha_action.dart';

import 'flutter_recaptcha_enterprise_platform_interface.dart';

class FlutterRecaptchaEnterprise {
  Future<String> setupAndroid(String siteKeyAndroid) async {
    return await FlutterRecaptchaEnterprisePlatform.instance
        .setupAndroid(siteKeyAndroid) as String;
  }

  Future<String> setupIOS(String siteKeyIOS) async {
    return await FlutterRecaptchaEnterprisePlatform.instance
        .setupIOS(siteKeyIOS) as String;
  }

  Future<String> execute(RecaptchaAction action) async {
    return await FlutterRecaptchaEnterprisePlatform.instance.execute(action)
        as String;
  }
}
