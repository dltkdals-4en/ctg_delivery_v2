import 'package:ctg_delivery_v2/contstants/color.dart';
import 'package:flutter/material.dart';

class CafeInfo extends StatelessWidget {
  const CafeInfo(this.data, {Key? key}) : super(key: key);

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      height: size.height / 8,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 70,
              height: 70,
              child: CircleAvatar(
                radius: 35,
                child: CircleAvatar(
                  backgroundImage: (data['location_postal'] != null)
                      ? NetworkImage("${data['location_postal']}")
                      : const NetworkImage(
                          'https://picsum.photos/200/300'),
                  radius: 33,
                ),
                backgroundColor: CoColor.coGrey5,
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data['location_name'],
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 24),
                ),
                const Text(
                  '여의도',
                  style: TextStyle(color: CoColor.coGrey1),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
