import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Common {
  pagePushReplaceRoute(BuildContext context, String pageName, Object argument) {
    Navigator.of(context)
        .pushReplacementNamed("/$pageName", arguments: argument);
  }

  pagePushRoute(BuildContext context, String pageName, Object argument) async {
   return await Navigator.of(context).pushNamed("/$pageName", arguments: argument);
  }
  //toastMsg
  showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}

final common = Common();
