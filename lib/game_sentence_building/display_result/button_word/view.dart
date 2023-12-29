import 'package:flutter/material.dart';
import 'package:flutter_view_controller/flutter_view_controller.dart';
import 'controller.dart';

class ButtonWordView extends ViewOf<ButtonWordController> {
  const ButtonWordView({required ButtonWordController controller}) : super(controller: controller);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: controller.click,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.blue.shade800,
            width: 2,
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        margin: const EdgeInsets.only(right: 2, bottom: 2),
        alignment: Alignment.center,
        child: FittedBox(
          child: Text(
            controller.word,
            style: const TextStyle(
              decoration: TextDecoration.none,
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.normal,
              letterSpacing: .4,
            ),
          ),
        ),
      ),
    );
  }
}
