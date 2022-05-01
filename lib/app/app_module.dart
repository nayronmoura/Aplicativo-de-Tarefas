import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto/aoth_service.dart';
import 'package:projeto/app/modules/auth/auth_module.dart';
import 'package:projeto/app/modules/createdocument/createdocument_module.dart';

import 'modules/home/home_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.singleton((i) => AothService()),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: AuthModule()),
    ModuleRoute("/home", module: HomeModule()),
    ModuleRoute("/aoth", module: AuthModule()),
    ModuleRoute("/home/create", module: CreatedocumentModule())
  ];
}
