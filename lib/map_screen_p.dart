import 'dart:collection';
import 'dart:ui';

import 'package:ctg_delivery_v2/db_provider.dart';
import 'package:ctg_delivery_v2/map/map_card.dart';
import 'package:ctg_delivery_v2/model/map_card_model.dart';
import 'package:ctg_delivery_v2/todo_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'collect/collect_screen.dart';
import 'collect/collect_screen_p.dart';
import 'contstants/color.dart';
import 'fail/fail_screen.dart';
import 'fail/fail_screen_p.dart';

class MapScreenP extends StatefulWidget {
  const MapScreenP({
    Key? key,
  }) : super(key: key);

  @override
  _MapScreenPState createState() => _MapScreenPState();
}

class _MapScreenPState extends State<MapScreenP> {
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  final double _initFabHeight = 120.0;
  double _fabHeight = 0;
  final double _panelHeightOpen = 236;
  final double _panelHeightClosed = 10;
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

    _fabHeight = _initFabHeight;
  }

  setMapCardIndex(int i) {
    setState(() {
      mapCardIndex = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<DbProvider>(context);
    var mapList = Provider.of<List<MapCardModel>>(context);
    // for (int i = 0; i < mapList.length; i++) {
    //   print('${mapList[i].locationName} // ${mapList[i].state}');
    // }

    return SafeArea(
      child: Material(
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            SlidingUpPanel(
              defaultPanelState: provider.mapCardPanelState,
              maxHeight: _panelHeightOpen,
              minHeight: 30,
              parallaxEnabled: false,
              parallaxOffset: .5,
              body: _body(webViewController, provider),
              panelBuilder: (sc) => _panel(sc, provider.mapCardIndex),
              // MapCard(sc, widget.mapList, mapCardIndex),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(18.0),
                  topRight: Radius.circular(18.0)),
              onPanelSlide: (double pos) => setState(() {
                _fabHeight = pos * (_panelHeightOpen - 0) + _initFabHeight;
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _panel(ScrollController sc, int index) {
    var provider = Provider.of<DbProvider>(context);
    var mapList = Provider.of<List<MapCardModel>>(context);
    MapCardModel data = mapList[provider.mapCardIndex];

    return Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 40),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12.0))),
                  ),
                ],
              ),
              const SizedBox(
                height: 18.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    CardUiProvider.nameSpilt(data, 'forward'),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    CardUiProvider.nameSpilt(data, 'behind'),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: CoColor.coGrey3,
                      fontSize: 13,
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  CardUiProvider.stateText(data.state, 'map'),
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
                      radius: 49.5,
                      backgroundColor: Color(0xFFDDDDDD),
                      child: CircleAvatar(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(49),
                          child: provider.setImage(data),
                        ),
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
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.location_on),
                              const SizedBox(
                                width: 6,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 200,
                                child: Text(
                                  data.address!,
                                  softWrap: true,
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.phone),
                              const SizedBox(
                                width: 6,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 200,
                                child: Text(data.tel!),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              (data.state == 21 || data.state == 20)
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/navi.png',
                              fit: BoxFit.cover,
                              width: 16,
                              height: 16,
                              alignment: Alignment.center,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              '길 안내',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          side: const BorderSide(
                              width: 1, color: CoColor.coPrimary),
                          primary: CoColor.coPrimary,
                          elevation: 0,
                        ),
                      ),
                    )
                  : Row(
                      children: [
                        SizedBox(
                          width: (MediaQuery.of(context).size.width) / 3,
                          child: ElevatedButton(
                              onPressed: () {

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FailScreenP(provider.mapCardIndex),
                                    ));
                                provider.tab!.animateTo(0);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    '수거 실패',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              style: ElevatedButton.styleFrom(
                                side: const BorderSide(
                                    width: 1, color: CoColor.coGrey6),
                                primary: CoColor.coGrey6,
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
                                        builder: (context) => CollectScreenP(
                                            provider.mapCardIndex),
                                      ));
                                  provider.tab!.animateTo(0);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      '수거량 입력',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                style: ElevatedButton.styleFrom(
                                  side: const BorderSide(
                                      width: 1, color: CoColor.coPrimary),
                                  primary: CoColor.coPrimary,
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

  Widget _body(inAppWebViewController, DbProvider provider) {
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
                  source: 'var center = ${provider.mapCardIndex}',
                  injectionTime: UserScriptInjectionTime.AT_DOCUMENT_START),
              UserScript(
                  source:
                      'var now =${provider.mapList.indexWhere((element) => element.state == 0)}',
                  injectionTime: UserScriptInjectionTime.AT_DOCUMENT_START)
            ]),
            onWebViewCreated: (InAppWebViewController controller) {
              inAppWebViewController = controller;

              inAppWebViewController.addJavaScriptHandler(
                  handlerName: 'setPosition',
                  callback: (args) {
                    return provider.position;
                  });
              inAppWebViewController.addJavaScriptHandler(
                  handlerName: 'getPost',
                  callback: (args) {
                    print('args : ${args}');
                    provider.changeMapCard(args[0]);
                    // var i = widget.mapList.indexWhere(
                    //         (element) => element['location_name'] == args[0]);
                    // setMapCardIndex(i);
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
