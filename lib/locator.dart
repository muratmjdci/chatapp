import 'locator.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'resources/strings/asset_map.dart';

@injectableInit
configureDependencies() => sl.init();

initDependencies() async {
  await sl<AssetMap>().init();
}

GetIt get sl => GetIt.I;
