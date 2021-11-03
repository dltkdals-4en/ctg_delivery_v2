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
import 'collect_screen.dart';
import 'contstants/color.dart';
import 'fail_screen.dart';

class MapScreenP extends StatefulWidget {
  const MapScreenP(
    {
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
    Provider.of<DbProvider>(context, listen: false).getPosition();


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
    // _panelHeightOpen = MediaQuery.of(context).size.height * 0.30;
    MapCardModel data =provider.mapList[provider.mapCardIndex];

    return SafeArea(
      child: Material(
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            SlidingUpPanel(
              defaultPanelState: PanelState.CLOSED,
              maxHeight: _panelHeightOpen,
              minHeight: 30,
              parallaxEnabled: false,
              parallaxOffset: .5,
              body: _body(webViewController, provider),
              panelBuilder: (sc) => _panel(sc, data),
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

  Widget _panel(ScrollController sc,MapCardModel data) {
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
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    TodoProvider.nameSpilt(data, 'forward'),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    TodoProvider.nameSpilt(data, 'behind'),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: CoColor.coGrey3,
                      fontSize: 13,
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  TodoProvider.stateText(data.state, 'map'),
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
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(49),
                          child: setImage(data),
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
                                  data.address!,
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
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    child: ElevatedButton(
                        onPressed: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => FailScreen(data),
                          //     ));
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
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => CollectScreen(data),
                            //     ));
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

  Image setImage(MapCardModel data) {


    if (data.locationName == '포이엔') {
      return Image.asset(
        'assets/images/4enLogo2.png',
        fit: BoxFit.cover,
      );
    } else if (data.locationName == '집하') {
      return Image.asset(
        'assets/images/4en.jpg',
        fit: BoxFit.cover,
      );
      postalImage = AssetImage('assets/images/4en.jpg');
    } else if (data.locationName == '대림창고(성수)') {
      return Image.asset(
        'assets/images/daerim.jpg',
        fit: BoxFit.cover,
        width: 98,
        height: 98,
      );
      postalImage = AssetImage('assets/images/daerim.jpg');
    } else if (data.postal != null) {
      return Image.network(
        '${data.postal}',
        fit: BoxFit.cover,
      );
    } else {
      return Image.network(
        '${data.postal}',
        fit: BoxFit.cover,
      );
    }
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
                  source: 'var center = $mapCardIndex',
                  injectionTime: UserScriptInjectionTime.AT_DOCUMENT_START),
              UserScript(
                  source: 'var now =$mapCardIndex',
                  injectionTime: UserScriptInjectionTime.AT_DOCUMENT_START)
            ]),
            onWebViewCreated: (InAppWebViewController controller) {
              inAppWebViewController = controller;

              inAppWebViewController.addJavaScriptHandler(
                  handlerName: 'setPosition',
                  callback: (args) {
                    print('1111 ${provider.position}');
                    return provider.position;
                  });
              inAppWebViewController.addJavaScriptHandler(
                  handlerName: 'getPost',
                  callback: (args) {
                    print('args : ${args}');
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
