import 'package:flutter_view_controller/flutter_view_controller.dart';

import 'button_word/controller.dart';

class DisplayResultController extends Controller {
  NotifierList<ButtonWordController> words = NotifierList();
  // Notifier<GameStatus> gameStatus = Notifier(GameStatus.blocked);

  bool isCorrect = false;
  String get text => words.value
      .fold('', (previousValue, element) => '$previousValue ${element.word}');

  Plug<String> onRemove = Plug();

  @override
  onInit() {}

  updateText(String word) {
    ButtonWordController button = ButtonWordController();
    button.word = word;
    button.onClick.then(() => _removeButton(button));
    words.add(button);
  }

  _removeButton(ButtonWordController button) {
    onRemove.send(button.word);
    words.remove(button);
  }

  @override
  onClose() {}
}
