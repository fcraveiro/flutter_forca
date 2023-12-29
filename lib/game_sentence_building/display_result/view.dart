import 'package:flutter/material.dart';
import 'package:flutter_view_controller/flutter_view_controller.dart';

import '../../icons/icons_app.dart';
import 'button_word/view.dart';
import 'controller.dart';

class DisplayResultView extends ViewOf<DisplayResultController> {
  const DisplayResultView({required DisplayResultController controller})
      : super(controller: controller);

  final style = const TextStyle(
    color: Colors.white,
    fontSize: 18,
    letterSpacing: 1.2,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return

        // controller.gameStatus.show((status) {
        //   return

        DragTarget<String>(
      builder: (
        BuildContext context,
        List<dynamic> accepted,
        List<dynamic> rejected,
      ) {
        return Container(
          width: MediaQuery.of(context).size.width * .82,
          height: MediaQuery.of(context).size.height * .12,
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: Colors.blue),
            color: () {
              if (1 == 1) {
                //  status == GameStatus.finished) {
                if (controller.isCorrect) {
                  return const Color.fromARGB(255, 16, 179, 143);
                } else {
                  return Colors.blue.withOpacity(.1);
                }
              } else {
                return const Color(0xFF2064B4);
              }
            }(),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // controller.gameStatus.show(
              //   (status) => status == GameStatus.finished
              2 == 1
                  ? Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          controller.text,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    )
                  : controller.words.show(
                      (words) => Expanded(
                        child: Wrap(
                          alignment: WrapAlignment.start,
                          children: words
                              .map((word) => FittedBox(
                                  child: ButtonWordView(controller: word)))
                              .toList(),
                        ),
                      ),
                    ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (2 == 1) //   status == GameStatus.finished)
                    if (controller.isCorrect)
                      const Icon(
                        IconsApp.success,
                        size: 40,
                        color: Colors.white,
                      )
                    else
                      const Icon(
                        IconsApp.close,
                        size: 40,
                        color: Colors.white,
                      )
                ],
              )
            ],
          ),
        );
      },
      onAccept: controller.updateText,
    );
    // }

    // );
  }
}
