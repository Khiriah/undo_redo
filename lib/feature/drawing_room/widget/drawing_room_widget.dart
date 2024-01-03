import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_color.dart';
import '../controller/drawing_room_controller.dart';
import '../model/drawing_point.dart';
import 'drawing_painter_widget.dart';

class DrawingRoomWidget extends StatelessWidget {
  const DrawingRoomWidget({
    super.key,
    required this.drawingRoomController,
  });

  final DrawingRoomController drawingRoomController;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DrawingRoomController>(builder: (_) {
      return Column(
        children: [
          Stack(
            children: [
              SizedBox(
                height: 600,
                width: Get.width,
                child: GestureDetector(
                  onPanStart: (details) {
                    drawingRoomController.currentDrawingPoint = DrawingPoint(
                      id: DateTime.now().microsecondsSinceEpoch,
                      offsets: [
                        details.localPosition,
                      ],
                      color: drawingRoomController.selectedColor,
                      width: drawingRoomController.selectedWidth,
                    );
                    if (drawingRoomController.currentDrawingPoint == null) {
                      return;
                    }
                    drawingRoomController.drawingPoints
                        .add(drawingRoomController.currentDrawingPoint!);
                    drawingRoomController.historyDrawingPoints =
                        List.of(drawingRoomController.drawingPoints);
                    drawingRoomController.update();
                  },
                  onPanUpdate: (details) {
                    if (drawingRoomController.currentDrawingPoint == null) {
                      return;
                    }

                    drawingRoomController.currentDrawingPoint =
                        drawingRoomController.currentDrawingPoint?.copyWith(
                          offsets:
                          drawingRoomController.currentDrawingPoint!.offsets
                            ..add(details.localPosition),
                        );
                    drawingRoomController.drawingPoints.last =
                    drawingRoomController.currentDrawingPoint!;
                    drawingRoomController.historyDrawingPoints =
                        List.of(drawingRoomController.drawingPoints);
                    drawingRoomController.update();
                  },
                  onPanEnd: (_) {
                    drawingRoomController.currentDrawingPoint = null;
                  },
                  child: CustomPaint(
                    painter: DrawingPainterWidget(
                      drawingPoints: drawingRoomController.drawingPoints,
                    ),
                    child: SizedBox(
                      width: Get.size.width,
                      height: Get.size.height,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).padding.top,
                left: 16,
                right: 16,
                child: SizedBox(
                  height: 30,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: drawingRoomController.availableColor.length,
                    separatorBuilder: (_, __) {
                      return const SizedBox(width: 8);
                    },
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          drawingRoomController.selectedColor =
                          drawingRoomController.availableColor[index];
                          drawingRoomController.update();
                        },
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: drawingRoomController.availableColor[index],
                            shape: BoxShape.circle,
                          ),
                          foregroundDecoration: BoxDecoration(
                            border: drawingRoomController.selectedColor ==
                                drawingRoomController.availableColor[index]
                                ? Border.all(
                                color: AppColor.primaryColor, width: 4)
                                : null,
                            shape: BoxShape.circle,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).padding.top + 80,
                right: 0,
                bottom: 300,
                child: RotatedBox(
                  quarterTurns: 3, // 270 degree
                  child: Slider(
                    value: drawingRoomController.selectedWidth,
                    min: 1,
                    max: 20,
                    onChanged: (value) {
                      drawingRoomController.selectedWidth = value;
                      drawingRoomController.update();
                    },
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  heroTag: "Undo",
                  onPressed: () {
                    if (drawingRoomController.drawingPoints.isNotEmpty &&
                        drawingRoomController.historyDrawingPoints.isNotEmpty) {
                      drawingRoomController.drawingPoints.removeLast();
                      drawingRoomController.update();
                    }
                  },
                  child: const Icon(Icons.undo),
                ),
                const SizedBox(width: 16),
                FloatingActionButton(
                  heroTag: "Redo",
                  onPressed: () {
                    if (drawingRoomController.drawingPoints.length <
                        drawingRoomController.historyDrawingPoints.length) {
                      final index = drawingRoomController.drawingPoints.length;
                      drawingRoomController.drawingPoints.add(
                          drawingRoomController.historyDrawingPoints[index]);
                    }
                    drawingRoomController.update();
                  },
                  child: const Icon(Icons.redo),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}