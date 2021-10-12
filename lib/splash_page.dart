import 'package:ctg_delivery_v2/contstants/color.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: CoColor.coPrimary,
      child: Center(
        child: Image.asset('assets/images/splashLogo.png'),
      ),
    );
  }
}
