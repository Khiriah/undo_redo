import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_color.dart';
import '../controller/edit_image_controller.dart';
import '../model/text_info.dart';
import '../widget/image_text.dart';

class EditImageScreen extends StatelessWidget {
  final editImageController = Get.put(EditImageController());
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final String selectedImage;

  EditImageScreen({Key? key, required this.selectedImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
          child: GetBuilder<EditImageController>(builder: (_) {
            return SizedBox(
              height: Get.height,
              child: Stack(
                children: [
                  Center(
                    child: Image.file(
                      File(
                        selectedImage,
                      ),
                      fit: BoxFit.fill,
                      width: size.width,
                    ),
                  ),
                  for (int i = 0; i < editImageController.texts.length; i++)
                    Positioned(
                      left: editImageController.texts[i].left,
                      top: editImageController.texts[i].top,
                      child: GestureDetector(
                        onLongPress: () {
                          editImageController.currentIndex = i;
                          editImageController.removeText(context);
                          editImageController.update();
                        },
                        onTap: () =>
                            editImageController.setCurrentIndex(context, i),
                        child: Draggable(
                          feedback:
                              ImageText(textInfo: editImageController.texts[i]),
                          child:
                              ImageText(textInfo: editImageController.texts[i]),
                          onDragEnd: (drag) {
                            final renderBox =
                                context.findRenderObject() as RenderBox;
                            Offset off = renderBox.globalToLocal(drag.offset);
                            editImageController.texts[i].top = off.dy - 96;
                            editImageController.texts[i].left = off.dx;
                            editImageController.update();
                          },
                        ),
                      ),
                    ),
                  editImageController.creatorText.text.isNotEmpty
                      ? Positioned(
                          left: 0,
                          bottom: 0,
                          child: Text(
                            editImageController.creatorText.text,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black.withOpacity(
                                  0.3,
                                )),
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            );
          }),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              FloatingActionButton(
                heroTag: "Back",
                backgroundColor: Colors.white,
                onPressed: () {
                  Get.back();
                },
                child: const Icon(Icons.close),
              ),
              const SizedBox(width: 16),
              FloatingActionButton(
                onPressed: () => showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text(
                      'Add New Text',
                    ),
                    content: TextField(
                      controller: editImageController.textEditingController,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        suffixIcon: Icon(
                          Icons.add,
                        ),
                        filled: true,
                        hintText: 'Your Text Here..',
                      ),
                    ),
                    actions: <Widget>[
                      ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Back'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          editImageController.texts.add(
                            TextInfo(
                              text: editImageController
                                  .textEditingController.text,
                              left: 0,
                              top: 0,
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontStyle: FontStyle.normal,
                              fontSize: 20,
                              textAlign: TextAlign.left,
                            ),
                          );
                          Navigator.of(context).pop();
                          editImageController.update();
                        },
                        child: const Text('Add Text'),
                      ),
                    ],
                  ),
                ),
                backgroundColor: Colors.white,
                tooltip: 'Add New Text',
                child: const Icon(
                  Icons.add,
                ),
              ),
              const SizedBox(width: 16),
              FloatingActionButton(
                heroTag: "Edit",
                onPressed: () {
                  _scaffoldKey.currentState!.showBottomSheet((context) =>
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 50, horizontal: 8),
                        height: 280,
                        color: Colors.grey.shade50,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 40,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.add,
                                      color: Colors.black,
                                    ),
                                    onPressed:
                                        editImageController.increaseFontSize,
                                    tooltip: 'Increase font size',
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.remove,
                                      color: Colors.black,
                                    ),
                                    onPressed:
                                        editImageController.decreaseFontSize,
                                    tooltip: 'Decrease font size',
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.format_align_left,
                                      color: Colors.black,
                                    ),
                                    onPressed: editImageController.alignLeft,
                                    tooltip: 'Align left',
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.format_align_center,
                                      color: Colors.black,
                                    ),
                                    onPressed: editImageController.alignCenter,
                                    tooltip: 'Align Center',
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.format_align_right,
                                      color: Colors.black,
                                    ),
                                    onPressed: editImageController.alignRight,
                                    tooltip: 'Align Right',
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.format_bold,
                                      color: Colors.black,
                                    ),
                                    onPressed: editImageController.boldText,
                                    tooltip: 'Bold',
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.format_italic,
                                      color: Colors.black,
                                    ),
                                    onPressed: editImageController.italicText,
                                    tooltip: 'Italic',
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.space_bar,
                                      color: Colors.black,
                                    ),
                                    onPressed:
                                        editImageController.addLinesToText,
                                    tooltip: 'Add New Line',
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              height: 30,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    editImageController.availableColor.length,
                                separatorBuilder: (_, __) {
                                  return const SizedBox(width: 8);
                                },
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      editImageController.changeTextColor(
                                          editImageController
                                              .availableColor[index]);
                                      editImageController.selectedColor =
                                          editImageController
                                              .availableColor[index];
                                      editImageController.update();
                                    },
                                    child: Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        color: editImageController
                                            .availableColor[index],
                                        shape: BoxShape.circle,
                                      ),
                                      foregroundDecoration: BoxDecoration(
                                        border: editImageController
                                                    .selectedColor ==
                                                editImageController
                                                    .availableColor[index]
                                            ? Border.all(
                                                color: AppColor.primaryColor,
                                                width: 4)
                                            : null,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FloatingActionButton(
                                  heroTag: "No Edit",
                                  onPressed: () {
                                    editImageController.noEdit();
                                  },
                                  child: const Icon(Icons.cleaning_services),
                                ),
                                const SizedBox(width: 16),
                                FloatingActionButton(
                                  heroTag: "Edit",
                                  onPressed: () {
                                    editImageController.addEdit();
                                  },
                                  child: const Icon(Icons.check),
                                ),
                              ],
                            )
                          ],
                        ),
                      ));
                },
                backgroundColor: Colors.white,
                child: const Icon(Icons.edit),
              ),
              const SizedBox(width: 16),
              FloatingActionButton(
                heroTag: "Undo",
                onPressed: () {
                  editImageController.undo();
                },
                child: const Icon(Icons.undo),
              ),
              const SizedBox(width: 16),
              FloatingActionButton(
                heroTag: "Redo",
                onPressed: () {
                  editImageController.redo();
                },
                child: const Icon(Icons.redo),
              ),
            ],
          ),
        ));
  }
}
