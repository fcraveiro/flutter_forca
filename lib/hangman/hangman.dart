import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_view_controller/flutter_view_controller.dart';

import '../audios.dart';
import '../icons/icons_app.dart';

class GameHangmanController extends Controller {
  Notifier<String> hangmanWord = Notifier('');
  NotifierList keySelected = NotifierList();
  Notifier<int> numberOfHits = Notifier(0);
  Notifier<int> numberOfAttempts = Notifier(0);
  Notifier<bool> finalSuccess = Notifier(false);
  Notifier<bool> finalGame = Notifier(false);

  List<String> l1 = ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"];
  List<String> l2 = ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'];
  List<String> l3 = ["Z", "X", "C", "V", "B", "N", "M"];
  int numberOfLetters = 0;

  AudioPlayer player = AudioPlayer();
  AudioCache audio = AudioCache();
  String palavra = 'Petro';

  @override
  onInit() {
    numberOfHits.value = 0;
    numberOfAttempts.value = 0;
    keySelected.value = [''];
    finalSuccess.value = false;
    finalGame.value = false;
    assembleWord();
  }

  assembleWord() async {
    hangmanWord.value = palavra.toUpperCase();
    //    data!.answers[0].name.toUpperCase();
    numberOfLetters = hangmanWord.value.length;
    await checkSpace();
  }

  checkKey(e) {
    keySelected.value.contains(e)
        ? null
        : {
            keySelected.add(e),
            if (!hangmanWord.value.split('').contains(e.toUpperCase()))
              {
                numberOfAttempts.value++,
                if (numberOfAttempts.value == 10)
                  {
                    finalGame.value = true,
                    finalSuccess.value = false,
                    // soundOnwer = true,
                    finaliza(),
                  }
              }
            else
              {
                for (var i = 0; i < hangmanWord.value.length; i++)
                  {
                    if (hangmanWord.value[i].toString() == e.toString())
                      {
                        numberOfHits.value++,
                        if (numberOfHits.value == hangmanWord.value.length)
                          {
                            finalGame.value = true,
                            finalSuccess.value = true,
                            // isCorrect = true,
//                            showResult(),
//                            onAllowContinue(),
                          }
                      }
                  }
              }
          };
  }

  checkSpace() {
    for (var i = 0; i < hangmanWord.value.length; i++) {
      if (hangmanWord.value[i].toString() == ' ') {
        numberOfHits.value++;
      }
    }
  }

  finaliza() async {
    player.play(AssetSource(Audios.hangmanLose));
//    onAllowContinue();
  }

  // @override
  // RoundResultModel showResult() {
  //   return RoundResultModel(
  //       activityId: data!.id,
  //       isOk: isCorrect,
  //       points: isCorrect ? data!.gameType.score : 0);
  // }

  @override
  onClose() {
    player.stop();
  }
}

class GameHangmanView extends ViewOf<GameHangmanController> {
  const GameHangmanView({required GameHangmanController controller})
      : super(controller: controller);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Text(
                controller.palavra,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * .62,
                height: MediaQuery.of(context).size.height * .17,
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                // child: Image.network(
                //            controller.data!.answers[0].src.toString(),
                //   fit: BoxFit.fill,
                // ),
              ),
              Container(
                width: 150,
                height: 150,
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 15, bottom: 20),
                child: controller.numberOfAttempts.show(
                  (numberOfAttempts) => showHangMan(
                      controller.numberOfAttempts.value >= 0,
                      'assets/images/png/game_hangman_${controller.numberOfAttempts.value}.png'),
                ),
              ),
              controller.keySelected.show(
                (p0) => Wrap(
                  spacing: 2,
                  runSpacing: 10,
                  children: controller.hangmanWord.value
                      .split('')
                      .map((e) => exibeVisor(
                          e.toUpperCase(),
                          controller.keySelected.value
                              .contains(e.toUpperCase())))
                      .toList(),
                ),
              ),
              const SizedBox(height: 20),
              controller.finalGame.show(
                (p0) => controller.finalGame.value
                    ? Container(
                        width: MediaQuery.of(context).size.width * .82,
                        height: MediaQuery.of(context).size.height * .12,
                        margin: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: controller.finalSuccess.value
                              ? const Color.fromARGB(255, 16, 179, 143)
                              : const Color(0xfff87a63),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  controller.hangmanWord.value,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                controller.finalSuccess.value
                                    ? const Icon(
                                        IconsApp.success,
                                        size: 40,
                                        color: Colors.white,
                                      )
                                    : const Icon(
                                        IconsApp.close,
                                        size: 40,
                                        color: Colors.white,
                                      )
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      )
                    : const SizedBox(),
              ),
              const SizedBox(height: 20),
              controller.finalGame.show(
                (p0) => controller.finalGame.value
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        color: Colors.transparent,
                      )
                    : Container(
                        width: MediaQuery.of(context).size.width,
                        height: 140,
                        color: Colors.transparent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            controller.keySelected.show(
                              (keySelected) => Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: controller.l1.map((e) {
                                  return GestureDetector(
                                    onTap: () {
                                      controller.checkKey(e);
                                      keysOfKeyboard(e);
                                    },
                                    child: keysOfKeyboard(e),
                                  );
                                }).toList(),
                              ),
                            ),
                            const SizedBox(height: 10),
                            controller.keySelected.show(
                              (keySelected) => Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: controller.l2.map((e) {
                                  return GestureDetector(
                                    onTap: () {
                                      controller.checkKey(e);
                                      keysOfKeyboard(e);
                                    },
                                    child: keysOfKeyboard(e),
                                  );
                                }).toList(),
                              ),
                            ),
                            const SizedBox(height: 10),
                            controller.keySelected.show(
                              (keySelected) => Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: controller.l3.map((e) {
                                  return GestureDetector(
                                    onTap: () {
                                      controller.checkKey(e);
                                    },
                                    child: keysOfKeyboard(e),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget exibeVisor(String character, bool hidden) {
    return character == ' '
        ? Container(
            height: 30,
            width: 15,
            alignment: Alignment.center,
            margin: const EdgeInsets.only(right: 5, bottom: 0),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(4.0),
            ),
          )
        : Container(
            height: 30,
            width: 25,
            alignment: Alignment.center,
            margin: const EdgeInsets.only(right: 5, bottom: 0),
            decoration: BoxDecoration(
              color: const Color(0xFF231954),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Visibility(
              visible: hidden,
              child: Text(
                character,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ),
          );
  }

  keysOfKeyboard(e) {
    return Container(
      width: 30,
      height: 30,
      alignment: Alignment.center,
      margin: const EdgeInsets.only(right: 6),
      decoration: BoxDecoration(
        color: controller.keySelected.value.contains(e)
            ? Colors.grey.shade600
            : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          width: 1,
          color: Colors.grey.shade900,
        ),
      ),
      child: Text(
        e,
        style: TextStyle(
          color: controller.keySelected.value.contains(e)
              ? Colors.white
              : Colors.blue.shade800,
          fontSize: 19.0,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  showHangMan(bool visible, String path) {
    return Visibility(
      visible: visible,
      child: SizedBox(
        child: Image.asset(
          path,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
