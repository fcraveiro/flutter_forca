import 'package:flutter/material.dart';
import 'package:flutter_view_controller/flutter_view_controller.dart';
import 'display_result/controller.dart';
import 'display_result/view.dart';
import 'drag_word/controller.dart';
import 'drag_word/view.dart';

class GameSentenceBuildingController extends Controller {
  late DisplayResultController displayResult;
  late NotifierList<DragWordController> dragWords = NotifierList();

  Notifier<bool> isFinished = Notifier(false);
  Notifier<bool> isLoading = Notifier(false);
  Notifier<bool> isResultCorrect = Notifier(false);

  @override
  onInit() {
    _configDisplayResult();
    _configDragWords();
  }

  _configDisplayResult() {
    displayResult = DisplayResultController();
    displayResult.onRemove.take(_enableWord);
  }

  String palavras = 'João desceu do pé de goiaba';

  _configDragWords() {
    String words = palavras
//    "${data?.answers[0].name ?? ''} ${data?.answers[0].description ?? ''}"
        .replaceAll(RegExp(r'\s+'), ' ');

    final controllers = words
        .split(' ')
        .map((word) => _buildDragControllerForWord(word))
        .toList();

    controllers.shuffle();

    dragWords.value = controllers;
  }

  DragWordController _buildDragControllerForWord(String word) {
    final dragWord = DragWordController();
    dragWord.word = word;
    dragWord.onAdd.then(() => _disableWord(dragWord));
    return dragWord;
  }

  _disableWord(DragWordController word) {
    dragWords.value
        .firstWhere((dragWord) => dragWord.word == word.word)
        .disable();
//    onAllowVerifying();
  }

  _enableWord(String word) {
    dragWords.value.firstWhere((dragWord) => dragWord.word == word).enable();
  }

  @override
  onClose() {
    isLoading.dispose();
    isResultCorrect.dispose();
  }

  // @override
  // RoundResultModel showResult() {
  //   isCorrect = displayResult.text.trim() == data!.answers[0].name.trim();
  //   displayResult.gameStatus.value = GameStatus.finished;
  //   displayResult.isCorrect = isCorrect;
  //   isFinished.value = true;

  //   return RoundResultModel(activityId: data!.id, isOk: isCorrect, points: isCorrect ? data!.gameType.score : 0);
  // }
}

class GameSentenceBuildingView extends ViewOf<GameSentenceBuildingController> {
  const GameSentenceBuildingView(
      {required GameSentenceBuildingController controller})
      : super(controller: controller);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: controller.isLoading.show(
        (isLoading) => isLoading
            ? const Center(child: CircularProgressIndicator())
            : controller.isFinished.show((isFinished) {
                return IgnorePointer(
                  ignoring: isFinished,
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * .82,
                        margin: const EdgeInsets.only(top: 20, bottom: 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          controller.palavras,
                          //                        controller.data?.title.toString() ?? '',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      // Container(
                      //   width: MediaQuery.of(context).size.width * .82,
                      //   height: MediaQuery.of(context).size.height * .23,
                      //   alignment: Alignment.center,
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(10),
                      //   ),
                      //   child: () {
                      //     if (controller.data?.gameType !=
                      //             GameTypes.sentenceBuildingText &&
                      //         controller.data?.source == '') {
                      //       return const Center(
                      //           child: CircularProgressIndicator());
                      //     }

                      //     switch (controller.data?.gameType) {
                      //       case GameTypes.sentenceBuildingImage:
                      //         return Image.network(
                      //           controller.data!.source.toString(),
                      //           fit: BoxFit.fill,
                      //         );
                      //       case GameTypes.sentenceBuildingAudio:
                      //         return GameAudioPlayer(
                      //             src: controller.data!.source.toString());
                      //       case GameTypes.sentenceBuildingVideo:
                      //         return GameVideoPlayer(
                      //           src: controller.data!.source.toString(),
                      //           alternativeSrc:
                      //               controller.data!.sourceId.toString(),
                      //         );
                      //       default:
                      //         return Text(
                      //           controller.data!.description ?? '',
                      //           style: const TextStyle(
                      //             fontWeight: FontWeight.bold,
                      //             fontSize: 22,
                      //             color: Color(0xff589fc8),
                      //           ),
                      //         );
                      //     }
                      //   }(),
                      // ),
                      DisplayResultView(controller: controller.displayResult),
                      Container(
                        width: MediaQuery.of(context).size.width - 20,
                        color: Colors.transparent,
                        alignment: Alignment.center,
                        child: controller.dragWords.show(
                          (dragWords) => Wrap(
                            direction: Axis.horizontal,
                            children: dragWords
                                .map((dragWord) =>
                                    DragWordView(controller: dragWord))
                                .toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
      ),
    );
  }
}
