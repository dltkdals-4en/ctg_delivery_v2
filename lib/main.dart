// main.dart
import 'dart:io';

import 'package:ctg_delivery_v2/contstants/color.dart';
import 'package:ctg_delivery_v2/database_helper.dart';
import 'package:ctg_delivery_v2/splash_page.dart';
import 'package:ctg_delivery_v2/tab_page.dart';
import 'package:ctg_delivery_v2/todo_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<TodoProvider>(
          create: (_) => TodoProvider(),
        ),
        ChangeNotifierProvider<DbHelper>(
          create: (_) => DbHelper(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // Remove the debug banner
        debugShowCheckedModeBanner: false,
        title: 'CoffeeToGO',
        theme: ThemeData(
            fontFamily: 'NotoSansKR',
            iconTheme: const IconThemeData(color: CoColor.coBlack)),
        home: const HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  bool isLoading = false;
  late final TabController tab;
  List todoList = [];
  List mapList = [];
  List finalCard = [];

  @override
  void initState() {
    super.initState();

    getData();
    tab = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tab.dispose();
    super.dispose();
  }

  void getData() async {
    print('getData');
    final todoData = await DbHelper().getTodoList();
    final mapData = await DbHelper().getMapList();
    final finalLocation = await DbHelper().finalLocation();
    setState(() {
      print(mapList.length);
      todoList = todoData;
      mapList = mapData;
      finalCard = finalLocation;
      isLoading = true;
      print(todoList.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return (!isLoading)?SplashScreen() :Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Center(
          child: Image.asset(
            'assets/images/mainLogo.png',
            fit: BoxFit.cover,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () {
            setState(() {
              isLoading = false;
            });

            DbHelper().dataInitialization();
            getData();
          },
          color: Colors.grey,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              for (int i = 0; i < mapList.length; i++) {
                print(mapList[i]['pick_state']);
              }
              // for(int i in todoList) {
              //   print(todoList[i]);
              // }
            },
            color: Colors.grey,
          ),
        ],
        bottom: TabBar(
          controller: tab,
          tabs: const [
            Tab(
              child: Text('일정',
                  style: TextStyle(
                      color: Color(0xFF5A96FF), fontWeight: FontWeight.bold)),
            ),
            Tab(
              child: Text('지도',
                  style: TextStyle(
                      color: Color(0xFF5A96FF), fontWeight: FontWeight.bold)),
            )
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body:
          TabPage(tab, todoList, mapList, finalCard)

    );
  }
}
