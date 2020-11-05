import 'dart:math';

import 'package:flutter/material.dart';
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
                child: Text("立即登录"),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                onPressed: () {



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
