import 'package:flutter_recaptcha_enterprise/recaptcha_action.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_recaptcha_enterprise_method_channel.dart';

abstract class FlutterRecaptchaEnterprisePlatform extends PlatformInterface {
  FlutterRecaptchaEnterprisePlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterRecaptchaEnterprisePlatform _instance =
      MethodChannelFlutterRecaptchaEnterprise();

  static FlutterRecaptchaEnterprisePlatform get instance => _instance;

  static set instance(FlutterRecaptchaEnterprisePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> setupAndroid(String siteKeyAndroid) async {
    throw UnimplementedError(
        'execute(String setup() has not been implemented.');
  }

  Future<void> setupIOS(String siteKeyIOS) async {
    throw UnimplementedError(
        'execute(String setup() has not been implemented.');
  }

  Future<void> execute(RecaptchaAction action) {
    throw UnimplementedError(
        'execute(String action() has not been implemented.');
  }
}
