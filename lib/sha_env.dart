/// Yet another library to handle DotEnv file in Dart
/// ///
/// A few steps to begin :
/// 1. Create a .env file at the root of your projet
/// 2. Put values in your file in the following way : KEY=WALUE
/// 3. Put ShaEnv().loadSync(); after your main()
/// 4. Use the top level `env['key']` to get your environment variables !
library sha_env;

export 'src/sha_env.dart';
