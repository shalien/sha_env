import 'package:sha_env/src/sha_env.dart';
import 'package:test/test.dart';

void main() {
  group('Testing shaenv loading', () {
    setUp(() async {
      await ShaEnv().load();
    });

    test('Print all Env from platform', () {
      const bool isProduction = bool.fromEnvironment('dart.vm.product');

      print(isProduction);

      env.forEach((key, value) {
        print("$key $value");
      });

      assert(isProduction, true);
    });
  });
}
