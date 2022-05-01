
import 'package:modular_test/modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:projeto/app/modules/home/home_module.dart';
 
void main() {

  setUpAll(() {
    initModule(HomeModule());
  });
}