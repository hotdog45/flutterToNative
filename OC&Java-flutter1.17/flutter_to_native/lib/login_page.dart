import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';
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

class LoginPage extends StatefulWidget {
  final String route;

  const LoginPage({Key key, this.route}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("登录页"),
      ),
      body: Column(
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(left: 50, top: 20, right: 50),
              height: 46,
              width: double.infinity,
              child: FlatButton(
                color: getRandomColor(),
                child: Text("route"+widget.route),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                onPressed: () {
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (context) => HomePage()));


                },
              )),


        ],
      ),
    );
  }

  getRandomColor() {
    return Color.fromARGB(255, Random.secure().nextInt(255),
        Random.secure().nextInt(255), Random.secure().nextInt(255));
  }
}
