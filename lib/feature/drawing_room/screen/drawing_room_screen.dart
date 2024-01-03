import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/drawing_room_controller.dart';
import '../widget/drawing_room_widget.dart';

class DrawingRoomScreen extends StatelessWidget {
  final drawingRoomController = Get.put(DrawingRoomController());
  DrawingRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DrawingRoomWidget(drawingRoomController: drawingRoomController);
  }
}


