import 'dart:async';

import 'package:flutter/services.dart';

class ScoreIos {
  static const MethodChannel _channel = const MethodChannel('score_ios');
  static Future showAppStoreReView(String appStoreUrl) async {
    await _channel.invokeMethod('showReview', [appStoreUrl]);
  }
}
