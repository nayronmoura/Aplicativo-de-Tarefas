import 'package:flutter_test/flutter_test.dart';
import 'package:projeto/app/modules/createdocument/createdocument_store.dart';
 
void main() {
  late CreatedocumentStore store;

  setUpAll(() {
    store = CreatedocumentStore();
  });

  test('increment count', () async {
    expect(store.state, equals(0));
    store.update(store.state + 1);
    expect(store.state, equals(1));
  });
}