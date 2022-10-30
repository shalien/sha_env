import 'package:sha_env/sha_env.dart';

void main() {
  /// Will load the variablesfrom .env file
  ShaEnv().loadSync();

  /// print variable api key
  print(env['API_KEY']);
}
