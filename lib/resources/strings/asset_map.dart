import 'dart:convert';
import 'dart:ui';

import 'package:flutter/services.dart' show rootBundle;
import 'package:injectable/injectable.dart';

const supportedLocales = [Locale("tr")];

@lazySingleton
class AssetMap {
  late Map<String, dynamic> _data;

  AssetMap();


  init() async {
    final String assets = await rootBundle.loadString('assets/strings/tr.json');
    _data = json.decode(assets);
  }

  String? operator [](String? key) => _data[key];

  Map<int, String> getList(String prefix) => Map.fromEntries(
    _data.entries
        .where((e) => e.key.startsWith(prefix) && int.tryParse(e.key.substring(prefix.length)) != null)
        .map((e) => MapEntry(int.parse(e.key.substring(prefix.length)), e.value.toString())),
  );

}
