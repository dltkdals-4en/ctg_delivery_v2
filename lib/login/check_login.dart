import 'package:ctg_delivery_v2/database_helper.dart';
import 'package:ctg_delivery_v2/get_data_page.dart';
import 'package:ctg_delivery_v2/login/app_explain.dart';
import 'package:ctg_delivery_v2/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckLogin extends StatelessWidget {
  const CheckLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<DbHelper>(context);
    return FutureBuilder(
      future: provider.LoginPreferences(),
      builder: (context, snapshot) {
        print(snapshot.data);
        return (!snapshot.hasData)
            ? SplashScreen()
            : (snapshot.data == 0)
                ? AppExplain()
                : GetDataPage();
      },
    );
  }
}
