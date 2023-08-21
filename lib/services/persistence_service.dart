import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../locator.dart';
import '../util/date.dart';

///Service to persist data in the device storage
///[SharedPreferences] is used to persist data
///[Cached] is used to access the data
@lazySingleton
class PersistenceService {
  late SharedPreferences _prefs;

  init() async {
    _prefs = await SharedPreferences.getInstance();
    await reload();
    Cached.resetInMemory();
  }

  reload() => _prefs.reload();

  reset() => Cached.values.where((c) => !c.persistent).forEach((e) => e.set());
}

///Enum to access the cached data
///[ttl] is the time to live of the data (null means no expiration)
///[persistent] is true if the data should be persisted
///[inMemory] is true if the data should be reset when the app is closed
///[getOptional] returns the data if it exists and is not expired
///[get] returns the data if it exists and is not expired, otherwise it throws an exception
///[has] returns true if the data exists and is not expired
///[getInt] returns the data as an integer if it exists and is not expired, otherwise it returns 0
///[set] sets the data if it is not expired, otherwise it removes the data
///[remove] removes the data
///[setWithFallback] sets the data if it is not expired or if it does not exist, otherwise it removes the data
///[resetInMemory] resets the data if it is in memory
///[Cached.values] returns all the cached data
enum Cached {
  username(ttl: Duration(days: 1), persistent: true);

  final Duration? ttl;
  final bool persistent;
  final bool inMemory;

  const Cached({this.ttl, this.persistent = false, this.inMemory = false});

  ///save the data with ttl with name prefixed with '_ttl_'
  String get _ttl => '_ttl_$name';

  SharedPreferences get _prefs => sl<PersistenceService>()._prefs;

  ///check if the data exists and is not expired
  ///if it is expired, removes it
  String? get getOptional =>
      ttl == null || (_prefs.getString(_ttl)?.date ?? now).compareTo(now) > 0 ? _prefs.getString(name) : null;

  ///same as [getOptional] but throws an exception if the data does not exist or is expired
  String get get => getOptional!;

  bool get has => getOptional != null;

  int getInt() => has ? int.tryParse(get) ?? 0 : 0;

  ///if value is null, removes the data
  ///if ttl is null, removes the ttl
  ///if value is not null and ttl is not null, sets the data and the ttl
  ///if value is not null and ttl is null, sets the data
  set([String? value]) {
    value != null ? _prefs.setString(name, value) : _prefs.remove(name);
    if (ttl != null) value != null ? _prefs.setString(_ttl, now.add(ttl!).toIso8601String()) : _prefs.remove(_ttl);
  }

  remove() => _prefs.remove(name);

  ///if newValue is null, saves the fallback
  setWithFallback(String? newValue, String fallback) {
    if (newValue != null || !has) set(newValue ?? fallback);
  }

  ///resets the data if it is in memory
  static resetInMemory() => values.where((c) => c.inMemory).forEach((e) => e.set());
}
