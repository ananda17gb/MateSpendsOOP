import 'dart:convert';
import 'dart:io';

class User {
  String name;

  User({required this.name});

  String? loadName() {
    try {
      File file = File('name.json');
      if (file.existsSync()) {
        String contents = file.readAsStringSync();
        Map<String, dynamic> data = jsonDecode(contents);
        return data['name'];
      }
    } catch (e) {
      print("Error loading name: $e");
    }
    return null;
  }

  void saveName(String name) {
    try {
      File file = File('name.json');
      Map<String, dynamic> data = {'name': name};
      file.writeAsStringSync(jsonEncode(data));
    } catch (e) {
      print("Error saving name: $e");
    }
  }
}
