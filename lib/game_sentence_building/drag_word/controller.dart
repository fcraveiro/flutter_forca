import 'package:flutter_view_controller/flutter_view_controller.dart';

class DragWordController extends Controller {
  String word = "";
  Notifier<bool> enabled = Notifier(true);

  Plug onAdd = Plug();

  @override
  onInit() {}

  enable() {
    enabled.value = true;
  }

  disable() {
    enabled.value = false;
  }

  add() {
    onAdd();
  }

  @override
  onClose() {}
}
