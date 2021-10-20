import 'package:ctg_delivery_v2/contstants/color.dart';
import 'package:ctg_delivery_v2/todo_provider.dart';
import 'package:flutter/material.dart';

class CafeInfo extends StatelessWidget {
  const CafeInfo(this.data, {Key? key}) : super(key: key);

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,

      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 70,
              height: 70,
              child: CircleAvatar(
                radius: 35,
                child: CircleAvatar(
                  radius: 34.5,
                  backgroundColor: CoColor.coGrey5,
                  child: CircleAvatar(
                    backgroundImage: TodoProvider.checkImage(data),
                    // (data['location_postal'] != null)
                    //     ? NetworkImage(
                    //         "${data['location_postal']}")
                    //     : const NetworkImage(
                    //         'https://picsum.photos/200/300'),
                    radius: 34,
                  ),
                ),
                backgroundColor: CoColor.coGrey5,
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  TodoProvider.nameSpilt(data, 'forward'),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(
                  TodoProvider.nameSpilt(data, 'behind'),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: CoColor.coGrey3),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
