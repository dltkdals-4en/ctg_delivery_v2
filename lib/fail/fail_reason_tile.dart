import 'package:flutter/material.dart';

import '../contstants/color.dart';

class FailReasonTile<T> extends StatelessWidget {
  const FailReasonTile(
      {required this.index,
      required this.value,
      required this.groupValue,
      required this.onChanged,
      required this.icon,
      required this.title,
      Key? key})
      : super(key: key);
  final int index;
  final T value;
  final T groupValue;
  final IconData icon;
  final String title;
  final ValueChanged<T?> onChanged;

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;
    bool visible = false;
    return Padding(
      padding: const EdgeInsets.only(top: 24, right: 12,left: 12),
      child: InkWell(
        onTap: () {
          return onChanged(value);
        },
        child: Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isSelected ? CoColor.coPrimary : CoColor.coGrey1,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                title,
                style: TextStyle(
                  color: isSelected ? CoColor.coPrimary : CoColor.coGrey1,
                ),
              )
            ],
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? CoColor.coPrimary : CoColor.coGrey2,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
