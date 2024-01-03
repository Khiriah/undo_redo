import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/text_info.dart';

class EditImageController extends GetxController {
  TextEditingController textEditingController = TextEditingController();
  TextEditingController creatorText = TextEditingController();

  List<TextInfo> texts = [];
  int currentIndex = 0;

  var selectedColor = Colors.black;

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

  TextInfo? currentTextInfo;

  List<TextInfo> historyTextInfoPoints = <TextInfo>[];
  List<TextInfo> textInfoPoints = <TextInfo>[];

  removeText(BuildContext context) {
    texts.removeAt(currentIndex);
    update();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Deleted',
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }

  setCurrentIndex(BuildContext context, index) {
    currentIndex = index;
    update();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Selected For Styling',
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }

  void addEdit() {
    currentTextInfo = TextInfo(
        text: texts[currentIndex].text,
        left: double.parse(texts[currentIndex].left.toString()),
        top: double.parse(texts[currentIndex].top.toString()),
        color: texts[currentIndex].color,
        fontWeight: texts[currentIndex].fontWeight,
        fontStyle: texts[currentIndex].fontStyle,
        fontSize: double.parse(texts[currentIndex].fontSize.toString()),
        textAlign: texts[currentIndex].textAlign);
    if (currentTextInfo == null) return;
    textInfoPoints.add(currentTextInfo!);
    historyTextInfoPoints = List.of(textInfoPoints);
    Get.back();
    update();
  }

  void redo() async {
    if (textInfoPoints.isNotEmpty && historyTextInfoPoints.isNotEmpty) {
      textInfoPoints.removeLast();
      texts[currentIndex].text = textInfoPoints.last.text;
      texts[currentIndex].left = textInfoPoints.last.left;
      texts[currentIndex].top = textInfoPoints.last.top;
      texts[currentIndex].color = textInfoPoints.last.color;
      texts[currentIndex].fontWeight = textInfoPoints.last.fontWeight;
      texts[currentIndex].fontStyle = textInfoPoints.last.fontStyle;
      texts[currentIndex].fontSize = textInfoPoints.last.fontSize;
      texts[currentIndex].textAlign = textInfoPoints.last.textAlign;
    } else {
      texts[currentIndex].text = textEditingController.text;
      texts[currentIndex].left = 0;
      texts[currentIndex].top = 0;
      texts[currentIndex].color = Colors.black;
      texts[currentIndex].fontWeight = FontWeight.normal;
      texts[currentIndex].fontStyle = FontStyle.normal;
      texts[currentIndex].fontSize = 20;
      texts[currentIndex].textAlign = TextAlign.left;
    }
    update();
  }

  void undo() {
    if (textInfoPoints.length < historyTextInfoPoints.length) {
      final index = textInfoPoints.length;
      textInfoPoints.add(historyTextInfoPoints[index]);
      texts[currentIndex].text = textInfoPoints.last.text;
      texts[currentIndex].left = textInfoPoints.last.left;
      texts[currentIndex].top = textInfoPoints.last.top;
      texts[currentIndex].color = textInfoPoints.last.color;
      texts[currentIndex].fontWeight = textInfoPoints.last.fontWeight;
      texts[currentIndex].fontStyle = textInfoPoints.last.fontStyle;
      texts[currentIndex].fontSize = textInfoPoints.last.fontSize;
      texts[currentIndex].textAlign = textInfoPoints.last.textAlign;
    }
    update();
  }

  void noEdit() {
    texts.clear();
    historyTextInfoPoints.clear();
    textInfoPoints.clear();
    textEditingController.clear();
    creatorText.clear();
    Get.back();
    update();
  }

  changeTextColor(Color color) {
    texts[currentIndex].color = color;
    update();
  }

  increaseFontSize() {
    texts[currentIndex].fontSize += 2;
    update();
  }

  decreaseFontSize() {
    texts[currentIndex].fontSize -= 2;
    update();
  }

  alignLeft() {
    texts[currentIndex].textAlign = TextAlign.left;
    update();
  }

  alignCenter() {
    texts[currentIndex].textAlign = TextAlign.center;
    update();
  }

  alignRight() {
    texts[currentIndex].textAlign = TextAlign.right;
    update();
  }

  boldText() {
    if (texts[currentIndex].fontWeight == FontWeight.bold) {
      texts[currentIndex].fontWeight = FontWeight.normal;
    } else {
      texts[currentIndex].fontWeight = FontWeight.bold;
    }
    update();
  }

  italicText() {
    if (texts[currentIndex].fontStyle == FontStyle.italic) {
      texts[currentIndex].fontStyle = FontStyle.normal;
    } else {
      texts[currentIndex].fontStyle = FontStyle.italic;
    }
    update();
  }

  addLinesToText() {
    if (texts[currentIndex].text.contains('\n')) {
      texts[currentIndex].text = texts[currentIndex].text.replaceAll('\n', ' ');
    } else {
      texts[currentIndex].text = texts[currentIndex].text.replaceAll(' ', '\n');
    }
    update();
  }
}
