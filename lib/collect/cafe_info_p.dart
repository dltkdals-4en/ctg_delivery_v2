import 'package:ctg_delivery_v2/contstants/color.dart';
import 'package:ctg_delivery_v2/db_provider.dart';
import 'package:ctg_delivery_v2/model/map_card_model.dart';
import 'package:ctg_delivery_v2/todo_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CafeInfoP extends StatelessWidget {
  const CafeInfoP(this.cardData, {Key? key}) : super(key: key);

  final MapCardModel cardData;
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<DbProvider>(context);
    final Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
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
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(49),
                      child: provider.setImage(cardData),
                    ),
                    backgroundColor: Colors.white,
                    radius: 49,
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
                  CardUiProvider.nameSpilt(cardData, 'forward'),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(
                  CardUiProvider.nameSpilt(cardData, 'behind'),
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
