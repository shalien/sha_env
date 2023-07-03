/// Yet another library to handle DotEnv file in Dart
/// ///
/// A few steps to begin :
/// 1. Create a .env file at the root of your projet
/// 2. Put values in your file in the following way : KEY=WALUE
/// 3. Put ShaEnv().loadSync(); after your main()
/// 4. Use the top level `env['key']` to get your environment variables !
library sha_env;

import 'package:sha_env/sha_env.dart';

export 'src/sha_env.dart';

Map<String, String> get env => _withShaEnvSync((shaEnv) => shaEnv.env);

int fromEnvironment(String name, {int defaultValue = 0}) {
  if (env.containsKey(name)) {
    return int.parse(env[name]!);
  } else {
    return int.fromEnvironment(name, defaultValue: defaultValue);
  }
}

bool fromEnvironmentBool(String name, {bool defaultValue = false}) {
  if (env.containsKey(name)) {
    return bool.parse(env[name]!);
  } else {
    return bool.fromEnvironment(name, defaultValue: defaultValue);
  }
}

String fromEnvironmentString(String name, {String defaultValue = ''}) {
  if (env.containsKey(name)) {
    return env[name]!;
  } else {
    return String.fromEnvironment(name, defaultValue: defaultValue);
  }
}

load() async => _withShaEnv((shaEnv) async => await shaEnv.load());

Map<String, String> _withShaEnvSync(Map<String, String> Function(ShaEnv) fn) {
  final ShaEnv shaEnv = ShaEnv();

  try {
    fn(shaEnv);
  } catch (e) {
    print(e);
  }

  return shaEnv.env;
}

Future<void> _withShaEnv(Future<void> Function(ShaEnv) fn) async {
  final ShaEnv shaEnv = ShaEnv();

  try {
    await fn(shaEnv);
  } catch (e) {
    print(e);
  }
}
