import 'package:flutter/material.dart';

class CollectDataModel{
  int? collectId;
  double? volume;
  FocusNode? focusNode;
  TextEditingController? t;

  CollectDataModel({this.collectId, this.volume, this.focusNode, this.t});

}