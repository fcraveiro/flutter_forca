import 'package:flutter/material.dart';
import 'package:flutter_view_controller/flutter_view_controller.dart';

import 'controller.dart';

class DragWordView extends ViewOf<DragWordController> {
  const DragWordView({required DragWordController controller}) : super(controller: controller);

  @override
  Widget build(BuildContext context) {
    return controller.enabled.show(
      (enabled) => enabled
          ? Draggable<String>(
              data: controller.word,
              dragAnchorStrategy: (draggable, context, position) {
                final RenderBox renderObject = context.findRenderObject()! as RenderBox;
                return renderObject.paintBounds.center;
              },
              onDragCompleted: controller.add,
              onDragStarted: () {},
              feedback: buildWord(controller.word),
              childWhenDragging: buildWord(controller.word),
              child: buildWord(controller.word),
            )
          : Container(
              width: 100,
              height: 35,
              decoration: BoxDecoration(
                color: const Color(0xFF2064B4),
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.only(right: 10, bottom: 10),
              alignment: Alignment.center),
    );
  }

  buildWord(caixaDeEscolha) {
    return Container(
      width: 100,
      height: 35,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.blue.shade800,
          width: 2,
        ),
      ),
      padding: const EdgeInsets.only(left: 10, right: 10),
      margin: const EdgeInsets.only(right: 10, bottom: 10),
      alignment: Alignment.center,
      child: FittedBox(
        child: Text(
          caixaDeEscolha,
          style: const TextStyle(
              decoration: TextDecoration.none,
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.normal,
              letterSpacing: .4),
        ),
      ),
    );
  }
}
