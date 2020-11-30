import 'package:flutter/services.dart';

class MyMethodChannel {
  static const methodChannel = MethodChannel('hh://MethodChannelPlugin');

  ///----------------------- 事件method -------------------------------

  //打开商品详情页
  static const String OPEN_GOODS_LIST_PAGE = "hh://openGoodsListPage";

  //打开原生首页
  static const String OPEN_HOME_PAGE = "hh://openNativeHomePage";

  //获取定位
  static const String GET_LOCATION = "hh://getLocation";


  ///----------------------- 事件method end-------------------------------

  static Future<dynamic> invokeMethod(String method, [dynamic arguments]) async {
    try {
      //回调成功
      final dynamic callbackResult =
          await methodChannel.invokeMethod(method, arguments);
      return callbackResult;
    } on PlatformException catch (e) {
      //回调失败
      return "";
    }
  }
}
