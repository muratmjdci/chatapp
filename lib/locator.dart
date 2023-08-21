import 'package:chatappocr/services/persistence_service.dart';

import 'locator.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'resources/strings/asset_map.dart';
import 'services/navigator_service.dart';

@injectableInit
configureDependencies() => sl.init();

initDependencies() async {
  await sl<PersistenceService>().init();
  await sl<AssetMap>().init();
}

GetIt get sl => GetIt.I;

NavigatorService get navigator => sl<NavigatorService>();

