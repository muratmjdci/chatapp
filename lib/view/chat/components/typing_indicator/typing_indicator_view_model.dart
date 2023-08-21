import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

class TypingIndicatorViewModel extends BaseViewModel {
  final Curve curve = Curves.bounceInOut;
  double start = 1.0;
  double end = 1.0;
  onEnd() {
    end = end + start;
    notifyListeners();
  }

}
