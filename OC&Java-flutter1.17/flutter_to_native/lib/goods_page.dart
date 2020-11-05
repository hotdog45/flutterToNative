import 'dart:math';

import 'package:flutter/material.dart';
/**
 * Copyright (C), 2015-2020, 谊品生鲜
 * FileName: goods_page
 * Author: lishunfeng
 * Date: 2020/11/5 11:17 PM
 * Description:
 * History:
 * <author> <time> <version> <desc>
 * 作者姓名 修改时间 版本号 描述
 */

class GoodsPage extends StatefulWidget {
  final String name;

  const GoodsPage({Key key, this.name}) : super(key: key);
  @override
  _GoodsPageState createState() => _GoodsPageState();
}

class _GoodsPageState extends State<GoodsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("商品详情"),
      ),
      body: Column(
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(left: 50, top: 20, right: 50),
              height: 46,
              width: double.infinity,
              child: FlatButton(
                color: getRandomColor(),
                child: Text("商品名称:"+widget.name),
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
