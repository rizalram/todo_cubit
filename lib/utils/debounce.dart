import 'dart:async';

import 'package:flutter/cupertino.dart';

class Debounce {
  final int duration;

  Debounce({
    required this.duration,
  });

  Timer? _timer;

  void run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }

    _timer = Timer(Duration(milliseconds: duration), action);
  }
}
