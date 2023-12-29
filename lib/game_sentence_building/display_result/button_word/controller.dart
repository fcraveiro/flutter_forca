import 'package:flutter_view_controller/flutter_view_controller.dart';

class ButtonWordController extends Controller {
  String word = '';

  Plug onClick = Plug();

  @override
  onInit() {}

  click() {
    onClick();
  }

  @override
  onClose() {}
}
