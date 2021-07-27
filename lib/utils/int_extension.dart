import 'dart:async';

extension intextension on int {
  Timer delayMethod(Function() function) {
    return Timer(Duration(milliseconds: this), function);
  }
}
