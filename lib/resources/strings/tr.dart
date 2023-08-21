import 'package:intl/intl.dart';

import '../../locator.dart';
import 'asset_map.dart';

enum Tr {
  setUserNameTitle,
  setUserNameLabel,
  setUserNameButton,
  popupTitleError,
  usernameInvalid,
  popupButtonText;

  const Tr();

  static String? fromKey(String? key) => sl<AssetMap>()[key];

  String call({Tr? fallback}) {
    var s = fromKey(name) ?? '';
    return Intl.message(s);
  }

  int getInt() => int.tryParse(call()) ?? 0;

  double getDouble() => double.tryParse(call()) ?? 0.0;

  bool getBool() {
    final value = call().toLowerCase();
    return value == '1' || value == 'true';
  }
}

extension TrListExtensions on Iterable<Tr> {
  bool has(String? key) => map((tr) => tr.name).contains(key);
}
