import 'package:flutter_test/flutter_test.dart';
import 'package:projeto/app/modules/createdocument/createdocument_store.dart';
 
void main() {
  late CreatedocumentStore store;

  setUpAll(() {
    store = CreatedocumentStore();
  });
}