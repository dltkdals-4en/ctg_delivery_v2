import 'package:ctg_delivery_v2/db_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class VisibleCardP extends StatefulWidget {
  const VisibleCardP({Key? key}) : super(key: key);

  @override
  _VisibleCardPState createState() => _VisibleCardPState();
}

class _VisibleCardPState extends State<VisibleCardP> {

  @override
  Widget build(BuildContext context) {
    var textFactor = MediaQuery.of(context).textScaleFactor;
    var dbProvider = Provider.of<DbProvider>(context);
    var index = dbProvider.mapList.indexWhere((element) => element.state == 21);
    var data = dbProvider.mapList[index];
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 170,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '${data.locationName}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                const Divider(
                  color: Colors.grey,
                ),
                Expanded(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 85,
                        height: 85,
                        child: CircleAvatar(
                          radius: 42.5,
                          backgroundColor: Color(0xFFDDDDDD),
                          child: CircleAvatar(
                            radius: 42,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: SizedBox(
                                child: Image.asset(
                                  'assets/images/4en.jpg',
                                  fit: BoxFit.fill,
                                ),
                              ),
                              radius: 42,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${data.address}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: (MediaQuery.of(context).size.width -
                                            180) /
                                        2,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          launch(
                                              "tel://${data.tel}");
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/images/phone.png',
                                              fit: BoxFit.cover,
                                              width: 14 * textFactor,
                                              height: 14 * textFactor,
                                              alignment: Alignment.center,
                                            ),
                                            Text(
                                              '전화걸기',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14 * textFactor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.all(3),
                                          side: const BorderSide(
                                              width: 1,
                                              color: Color(0xFFDDDDDD)),
                                          primary: Colors.white,
                                          elevation: 0,
                                        )),
                                  ),
                                  SizedBox(
                                    width: (MediaQuery.of(context).size.width -
                                            180) /
                                        2,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          launch(
                                              'https://map.kakao.com/link/to/${data.locationName},${data.gps_lat},${data.gps_lng}');
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/images/navi.png',
                                              fit: BoxFit.cover,
                                              width: 14 * textFactor,
                                              height: 14 * textFactor,
                                              alignment: Alignment.center,
                                              color: Colors.white,
                                            ),
                                            Text(
                                              '길 안내',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14 * textFactor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.all(3),
                                          side: const BorderSide(
                                              width: 1,
                                              color: Color(0xFF5A96FF)),
                                          primary: Color(0xFF5A96FF),
                                          elevation: 0,
                                        )),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
