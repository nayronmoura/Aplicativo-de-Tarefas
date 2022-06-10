import 'package:flutter/material.dart';
import 'package:projeto/app/modules/createdocument/createdocument_Page.dart';
import 'package:projeto/app/modules/createdocument/createdocument_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CreatedocumentModule extends Module {

  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => CreatedocumentStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const CreatedocumentPage()),
  ];
}
