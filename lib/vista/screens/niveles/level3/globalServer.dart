import 'package:flutter/foundation.dart';

class GlobalObserver with ChangeNotifier {
  int _myGlobalVar = 0;

  int get myGlobalVar => _myGlobalVar;

  set myGlobalVar(int value) {
    _myGlobalVar = value;
    notifyListeners();
  }
}

final globalObserver = GlobalObserver();
