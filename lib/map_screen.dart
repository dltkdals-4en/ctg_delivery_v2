import 'dart:collection';
import 'dart:ui';

import 'package:ctg_delivery_v2/map/map_card.dart';
import 'package:ctg_delivery_v2/todo_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'collect_screen.dart';
import 'fail_screen.dart';

class MapScreen extends StatefulWidget {
  const MapScreen(
    this.mapList,
    this.mapIndex, {
    Key? key,
  }) : super(key: key);

  final List mapList;
  final int mapIndex;

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final double _initFabHeight = 120.0;
  double _fabHeight = 0;
  double _panelHeightOpen = 0;
  final double _panelHeightClosed = 20;
  int mapCardIndex = 0;
  InAppWebViewController? webViewController;
  List position = [];
  ImageProvider? postalImage;

  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  @override
  void initState() {
    super.initState();
    getPosition();
    setFirstIndex();

    _fabHeight = _initFabHeight;
  }

  setMapCardIndex(int i) {
    setState(() {
      mapCardIndex = i;
    });
  }

  getPosition() {
    if (position.isEmpty) {
      for (int i = 0; i < widget.mapList.length; i++) {
        position.add({
          'title': widget.mapList[i]['location_name'],
          'lat': widget.mapList[i]['location_gps_lat'],
          'lng': widget.mapList[i]['location_gps_long'],
          'state': widget.mapList[i]['pick_state'],
          'id': widget.mapList[i]['pick_id'],
        });
      }
      print(position);
    }
  }

  setFirstIndex() {
    setState(() {
      var i =
          widget.mapList.indexWhere((element) => element['pick_state'] == 0);
      print('qweqweqweqe $i');
      if (i != -1) {
        mapCardIndex = i;
      } else {
        mapCardIndex = widget.mapList.length - 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<TodoProvider>(context);
    _panelHeightOpen = MediaQuery.of(context).size.height * 0.3;
    var data = widget.mapList[mapCardIndex];

    return Material(
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          SlidingUpPanel(
            defaultPanelState: PanelState.OPEN,
            maxHeight: _panelHeightOpen,
            minHeight: 30,
            parallaxEnabled: false,
            parallaxOffset: .5,
            body: _body(webViewController),
            panelBuilder: (sc) => _panel(sc, data),
            // MapCard(sc, widget.mapList, mapCardIndex),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18.0),
                topRight: Radius.circular(18.0)),
            onPanelSlide: (double pos) => setState(() {
              _fabHeight = pos * (_panelHeightOpen - _panelHeightClosed) +
                  _initFabHeight;
            }),
          ),
        ],
      ),
    );
  }

  Widget _panel(ScrollController sc, data) {
    return Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 5,
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.all(Radius.circular(12.0))),
                  ),
                ],
              ),
              const SizedBox(
                height: 18.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    data['location_name'],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TodoProvider.stateText(data['pick_state'], 'map'),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Color(0xFFDDDDDD),
                      child: CircleAvatar(
                        backgroundImage: setImage(),
                        backgroundColor: Colors.white,
                        radius: 49,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: SizedBox(
                      height: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.location_on),
                              SizedBox(
                                width: 6,
                              ),
                              SizedBox(
                                width: 180,
                                child: Text(
                                  data['location_address'],
                                  softWrap: true,
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.phone),
                              SizedBox(
                                width: 6,
                              ),
                              SizedBox(
                                width: 180,
                                child: Text(data['location_tel'].toString()),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FailScreen(data),
                              ));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              '수거 실패',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          side: const BorderSide(
                              width: 1, color: Color(0xFFDDDDDD)),
                          primary: Color(0xFFDDDDDD),
                          elevation: 0,
                        )),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: SizedBox(
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CollectScreen(data),
                                ));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                '수거량 입력',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            side: const BorderSide(
                                width: 1, color: Color(0xFF5A96FF)),
                            primary: Color(0xFF5A96FF),
                            elevation: 0,
                          )),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  ImageProvider? setImage() {
    var data = widget.mapList[mapCardIndex];
    print(data['location_name']);
    if (data['location_name'] == '포이엔') {
      postalImage = AssetImage('assets/images/4en_logo_2021.png');
    } else if (data['location_name'] == '집하') {
      postalImage = AssetImage('assets/images/4en.jpg');
    } else if (data['location_postal'] != null) {
      postalImage = NetworkImage("${data['location_postal']}");
    } else {
      postalImage = const NetworkImage('https://picsum.photos/200/300');
    }
    print(postalImage);
    return postalImage;
  }

  Widget _body(inAppWebViewController) {
    return Column(
      children: [
        Expanded(
          child: InAppWebView(
            initialOptions: InAppWebViewGroupOptions(
                android: AndroidInAppWebViewOptions(
                  useWideViewPort: false,
                ),
                crossPlatform: InAppWebViewOptions(
                  supportZoom: true,
                  useShouldOverrideUrlLoading: true,
                )),
            initialFile: 'assets/html/kakao_map.html',
            initialUserScripts: UnmodifiableListView<UserScript>([
              UserScript(
                  source: 'var center = $mapCardIndex',
                  injectionTime: UserScriptInjectionTime.AT_DOCUMENT_START),
              UserScript(
                  source: 'var now =$mapCardIndex',
                  injectionTime: UserScriptInjectionTime.AT_DOCUMENT_START)
            ]),
            onWebViewCreated: (InAppWebViewController controller) {
              inAppWebViewController = controller;

              inAppWebViewController.addJavaScriptHandler(
                  handlerName: 'setposition',
                  callback: (args) {
                    return position;
                  });
              inAppWebViewController.addJavaScriptHandler(
                  handlerName: 'getPost',
                  callback: (args) {
                    print('args : ${args}');
                    var i = widget.mapList.indexWhere(
                        (element) => element['location_name'] == args[0]);
                    setMapCardIndex(i);
                  });
              inAppWebViewController.addJavaScriptHandler(
                  handlerName: 'gotoNavi',
                  callback: (ele) {
                    print('data : ${ele}');

                    // t.getNavi(url);
                  });
            },
            gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
              Factory(() => EagerGestureRecognizer()),
            ].toSet(),
          ),
        ),
      ],
    );
  }
}
