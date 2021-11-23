import 'package:ctg_delivery_v2/database_helper.dart';
import 'package:ctg_delivery_v2/db_provider.dart';
import 'package:ctg_delivery_v2/main.dart';
import 'package:ctg_delivery_v2/map_screen_p.dart';
import 'package:ctg_delivery_v2/model/todo_card_model.dart';
import 'package:ctg_delivery_v2/splash_page.dart';
import 'package:ctg_delivery_v2/todo_screen_p.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'contstants/color.dart';
import 'model/map_card_model.dart';
import 'my_page_screen.dart';

class GetDataPage extends StatefulWidget {
  const GetDataPage({Key? key}) : super(key: key);

  @override
  State<GetDataPage> createState() => _GetDataPageState();
}

class _GetDataPageState extends State<GetDataPage>
    with SingleTickerProviderStateMixin {
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Provider.of<DbProvider>(context, listen: false).tab =
          TabController(length: 2, vsync: this);
    });
    super.initState();
  }

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var dbHelper = Provider.of<DbHelper>(context);
    var dbProvider = Provider.of<DbProvider>(context);

    return MultiProvider(
      providers: [
        FutureProvider<List<MapCardModel>>.value(
          initialData: [],
          value: dbProvider.getMapList(),
        ),
      ],
      child: DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
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
                dbProvider.dataInitialization();
              },
              color: Colors.grey,
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.account_circle),
                onPressed: () {
                  for (int i = 0; i < dbProvider.mapList.length; i++) {
                    print(
                        '${dbProvider.mapList[i].locationName} // ${dbProvider.mapList[i].state}');
                  }
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => MyPageScreen(),
                  //     ));
                },
                color: Colors.grey,
              ),
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  setState(() {
                    prefs.clear();
                  });
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyApp(),
                      ));
                },
                color: Colors.grey,
              ),
            ],
            bottom: TabBar(
              controller: dbProvider.tab,
              tabs: [
                Tab(
                  child:
                      Text('일정', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Tab(
                  child:
                      Text('지도', style: TextStyle(fontWeight: FontWeight.bold)),
                )
              ],
              labelColor: CoColor.coPrimary,
              unselectedLabelColor: CoColor.coGrey3,
            ),
            backgroundColor: Colors.white,
          ),
          body: TabBarView(
            controller: dbProvider.tab,
            children: [
              TodoScreenP(),
              MapScreenP(),
            ],
          ),

          // TabPage(tab, todoList, mapList, finalCard)
        ),
      ),
    );
  }
}
