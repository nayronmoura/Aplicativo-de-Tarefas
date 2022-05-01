import 'package:flutter_test/flutter_test.dart';
import 'package:projeto/app/modules/tasks/tasks_store.dart';
 
void main() {
  late TasksStore store;

  setUpAll(() {
    store = TasksStore();
  });

  test('increment count', () async {
    expect(store.state, equals(0));
    store.update(store.state + 1);
    expect(store.state, equals(1));
  });
}