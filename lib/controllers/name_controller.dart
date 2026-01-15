import 'package:get/get.dart';

class NameController extends GetxController {
  var names = <String>[].obs;

  void addName(String name) {
    if (name.trim().isEmpty) return;
    names.add(name.trim());
  }

  void deleteName(int index) {
    names.removeAt(index);
  }

  void clearAll() {
    names.clear();
  }
}
