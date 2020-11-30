import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_to_native/goods_page.dart';
import 'package:flutter_to_native/login_page.dart';

import 'my_method_channel.dart';
/**
 * Copyright (C), 2015-2020, 谊品生鲜
 * FileName: home_page
 * Author: lishunfeng
 * Date: 2020/11/5 11:16 PM
 * Description:
 * History:
 * <author> <time> <version> <desc>
 * 作者姓名 修改时间 版本号 描述
 */

class HomePage extends StatefulWidget {
  final String route;

  const HomePage({Key key, this.route}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _longitude = "";
  String _latitude = "";

  @override
  void initState() {
    MyMethodChannel.methodChannel
        .setMethodCallHandler(platformCallHandler); //设置监听
    super.initState();
  }

// 监听原生调用flutter方法
  Future<dynamic> platformCallHandler(MethodCall call) async {
    switch (call.method) {
      case "hh://openGoodsPage":
        Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (context) => GoodsPage(
                      name: call.arguments,
                    )));
        break;
      case "hh://postLocation":
        // 监听原生发来的定位信息
        _latitude = (call.arguments as Map)["latitude"].toString();
        _longitude = (call.arguments as Map)["longitude"].toString();

        setState(() {});

        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("首页"+widget.route),
      ),
      body: Column(
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(left: 50, top: 20, right: 50),
              height: 46,
              width: double.infinity,
              child: FlatButton(
                color: getRandomColor(),
                child: Text("打开原生商品列表页面"),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                onPressed: () {
                  MyMethodChannel.invokeMethod(
                      MyMethodChannel.OPEN_GOODS_LIST_PAGE,
                      {"id": "aabbbcccc"});
                },
              )),
          Container(
              margin: EdgeInsets.only(left: 50, top: 20, right: 50),
              height: 46,
              width: double.infinity,
              child: FlatButton(
                color: getRandomColor(),
                child: Text("去登录"),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                onPressed: () {
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (context) => LoginPage()));
                },
              )),
          Container(
              margin: EdgeInsets.only(left: 50, top: 20, right: 50),
              height: 46,
              width: double.infinity,
              child: FlatButton(
                color: getRandomColor(),
                child: Text("去首页"),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                onPressed: () {
                  MyMethodChannel.invokeMethod(
                      MyMethodChannel.OPEN_HOME_PAGE,
                      {"id": "aabbbcccc"});
                },
              )),
          Container(
              margin: EdgeInsets.only(left: 50, top: 20, right: 50),
              height: 46,
              width: double.infinity,
              child: FlatButton(
                color: getRandomColor(),
                child: Text("获取当前定位"),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                onPressed: () async {
                  var map = await MyMethodChannel.invokeMethod(
                      MyMethodChannel.GET_LOCATION);
                  if (map == null || map.toString().isEmpty) {
                    print("获取定位失败==>+" + map.toString());
                    return;
                  }
                  _latitude = (map as Map)["latitude"].toString();
                  _longitude = (map as Map)["longitude"].toString();

                  setState(() {});
                },
              )),
          Text("当前定位:longitude=" + _longitude + "\nlatitude=" + _latitude)
        ],
      ),
    );
  }

  getRandomColor() {
    return Color.fromARGB(255, Random.secure().nextInt(255),
        Random.secure().nextInt(255), Random.secure().nextInt(255));
  }
}
