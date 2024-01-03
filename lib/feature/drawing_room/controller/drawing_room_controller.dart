import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/drawing_point.dart';

class DrawingRoomController extends GetxController {

  var availableColor = [
    Colors.black,
    Colors.grey,
    Colors.white,
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.teal,
    Colors.indigo,
    Colors.purple,
    Colors.deepPurple,
    Colors.blue
  ];

  var historyDrawingPoints = <DrawingPoint>[];
  var drawingPoints = <DrawingPoint>[];
  var selectedColor = Colors.black;
  var selectedWidth = 2.0;

  DrawingPoint? currentDrawingPoint;
}