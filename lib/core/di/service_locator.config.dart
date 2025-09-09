// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../data/api/number_api.dart' as _i868;
import '../../data/repositories/notification_repository.dart' as _i337;
import '../../data/repositories/number_repository.dart' as _i618;
import '../../ui/screens/numbers/num_model.dart' as _i315;
import '../../ui/screens/numbers/num_wm.dart' as _i26;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt init(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.lazySingleton<_i868.NumberApi>(() => _i868.NumberApi(gh<_i361.Dio>()));
  gh.factory<_i618.NumberRepository>(
      () => _i618.NumberRepositoryImpl(gh<_i868.NumberApi>()));
  gh.factory<_i26.NumbersWidgetModel>(() => _i26.NumbersWidgetModel(
        gh<_i315.NumbersModel>(),
        gh<_i337.NotificationRepository>(),
        gh<_i618.NumberRepository>(),
      ));
  return getIt;
}
