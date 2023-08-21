// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:chatappocr/resources/strings/asset_map.dart' as _i3;
import 'package:chatappocr/services/chat_service.dart' as _i4;
import 'package:chatappocr/services/connectivity_service.dart' as _i5;
import 'package:chatappocr/services/navigator_service.dart' as _i6;
import 'package:chatappocr/services/persistence_service.dart' as _i7;
import 'package:chatappocr/services/socket_service.dart' as _i8;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i3.AssetMap>(() => _i3.AssetMap());
    gh.lazySingleton<_i4.ChatService>(() => _i4.ChatService());
    gh.lazySingleton<_i5.ConnectivityService>(() => _i5.ConnectivityService());
    gh.lazySingleton<_i6.NavigatorService>(() => _i6.NavigatorService());
    gh.lazySingleton<_i7.PersistenceService>(() => _i7.PersistenceService());
    gh.lazySingleton<_i8.SocketService>(() => _i8.SocketService());
    return this;
  }
}
