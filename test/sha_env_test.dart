import 'package:sha_env/sha_env.dart';
import 'package:test/test.dart';

void main() {
  test('Testing Dart running mode', () {
    bool isDartVM = bool.fromEnvironment('dart.vm.product');

    expect(isDartVM, true);
  });

  test('Getting URL from env', () async {
    try {
      await load();
    } catch (e) {
      print(e);
    }

    final String url = env['URL']!;

    expect(url, 'https://ulr.com?ejkehe');
  });
}
