import 'package:flutter/foundation.dart';

class NameProvider extends ChangeNotifier {
  final List<String> _names = [];
  List<String> get names => _names;

  void addName(String name) {
    _names.insert(0, name);
    notifyListeners();
  }

  void deleteName(int index) {
    _names.removeAt(index);
    notifyListeners();
  }

  void clearAll() {
    _names.clear();
    notifyListeners();
  }
}
