import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_recaptcha_enterprise/flutter_recaptcha_enterprise.dart';
import 'package:flutter_recaptcha_enterprise/recaptcha_action.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final flutterRecaptchaEnterprise = FlutterRecaptchaEnterprise();

  String result = "action";

  Future<void> initPlatformState() async {
    String envRaw = await rootBundle.loadString('assets/env.json');
    var env = json.decode(envRaw) as Map<String, dynamic>;

    String siteKeyAndroid = env["siteKeyAndroid"];
    String siteKeyIOS = env["siteKeyIOS"];

    if (Platform.isAndroid) {
      await flutterRecaptchaEnterprise.setupAndroid(siteKeyAndroid);
    } else {
      await flutterRecaptchaEnterprise.setupIOS(siteKeyIOS);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              TextButton(
                onPressed: () async {
                  await initPlatformState();

                  setState(() {
                    result = "ok";
                  });
                },
                child: const Text("setup"),
              ),
              TextButton(
                onPressed: () async {
                  String customAction = "test";

                  String result = await flutterRecaptchaEnterprise
                      .execute(RecaptchaAction.custom(customAction));

                  setState(() {
                    log(result);
                    this.result = result;
                  });
                },
                child: Text(result),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
