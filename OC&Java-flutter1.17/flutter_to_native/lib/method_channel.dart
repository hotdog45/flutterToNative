import 'package:flutter/services.dart';

class MyMethodChannel {
  static const methodChannel = MethodChannel('hh://MethodChannelPlugin');

  ///----------------------- 事件路由名 -------------------------------

  //打开人脸识别页面
  static const String OPEN_FACE_LIVE_PAGE = "hh://openFaceLivePage";
  //打开视频监控页面
  static const String OPEN_GOODS_LIST_PAGE = "hh://openGoodsListPage";

  static const String GET_LOCATION = "hh://getLocation";


  ///----------------------- 事件路由名 end-------------------------------

  static Future<dynamic> invokeMethod(String route, [dynamic arguments]) async {
    try {
      //回调成功
      final dynamic callbackResult =
          await methodChannel.invokeMethod(route, arguments);
      return callbackResult;
    } on PlatformException catch (e) {
      //回调失败
      return "";
    }
  }
}
