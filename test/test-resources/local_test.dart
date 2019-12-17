import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:sounds_good/core/models/local.dart';
import 'dart:async';

Future<Local> getLocal() async {
  final file = File('test/test-resources/local.json');
  final json = jsonDecode(await file.readAsString());

  return Local.fromJson(json);
}

void main() {
  group('Profile ViewModel', () {
    Local local;

    setUpAll(() async {
      local = Local();
      local = await getLocal();
      print(local.contactMethod);
    });
  });
}
