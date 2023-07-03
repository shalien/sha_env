import 'dart:collection';
import 'dart:io';

import 'package:meta/meta.dart';

const String environmentFilename = '.env';
const String debugEnvironmentFilename = '.env.debug';
const String releaseEnvironmentFilename = '.env.release';
const String profileEnvironmentFilename = '.env.profile';

@immutable
final class ShaEnv {
  static ShaEnv? _instance;

  final Map<String, String> _env = {};

  UnmodifiableMapView<String, String> get env => UnmodifiableMapView(_env);

  ShaEnv._();

  factory ShaEnv() => _instance ??= ShaEnv._();

  Future<void> load() async {
    File envFile;

    if (bool.fromEnvironment('dart.vm.product')) {
      envFile = File(releaseEnvironmentFilename);
    } else {
      envFile = File(debugEnvironmentFilename);
    }

    if (!await envFile.exists()) {
      envFile = File(environmentFilename);
    }

    if (!await envFile.exists()) {
      throw Exception('Environment file not found !');
    }

    final List<String> lines = await envFile.readAsLines();

    for (final String line in lines) {
      if (line.isNotEmpty && !line.startsWith('#')) {
        final List<String> parts = line.split('=');
        if (parts.length == 2) {
          _env[parts[0]] = parts[1];
        }
      }
    }

    _env.addAll(Platform.environment);
  }
}
