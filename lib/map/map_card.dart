import 'package:flutter/material.dart';

import '../collect/collect_screen.dart';
import '../fail/fail_screen.dart';
import '../todo_provider.dart';

class MapCard extends StatefulWidget {
  const MapCard(this.sc, this.mapdata, this.index, {Key? key})
      : super(key: key);

  final ScrollController sc;
  final List mapdata;
  final int index;

  @override
  _MapCardState createState() => _MapCardState();
}

class _MapCardState extends State<MapCard> {
  ImageProvider? postalImage;

  @override
  initState() {
    setImage();
    super.initState();
  }

  setImage() {
    var data = widget.mapdata[widget.index];
    print(data);
    if (data['location_name'] == '포이엔') {
      setState(() {
        postalImage = AssetImage('asstes/images/4en.jpg');
      });
    } else if (data['location_name'] == '집하지') {
      setState(() {
        postalImage = AssetImage('asstes/images/4en_logo.png');
      });
    } else if (data['location_postal'] != null) {
      setState(() {
        postalImage = NetworkImage("${data['location_postal']}");
      });
    } else {
      setState(() {
        postalImage = const NetworkImage('https://picsum.photos/200/300');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var data = widget.mapdata[widget.index];
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
                        backgroundImage: postalImage,
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
}
