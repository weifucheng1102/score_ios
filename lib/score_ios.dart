import 'dart:async';

import 'package:flutter/services.dart';

class ScoreIos {
  static const MethodChannel _channel = const MethodChannel('score_ios');
  static Future showAppStoreReView(String appid) async {
    await _channel.invokeMethod('showReview', [appid]);
  }
}
