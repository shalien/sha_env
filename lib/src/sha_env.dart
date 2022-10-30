import 'dart:collection';
import 'dart:io';

import 'package:path/path.dart';

/// Singleton
ShaEnv? _instance;

/// Global [UnmodifiableMapView] hodling the variables
/// Will be empty if called before `ShaEnv().load()`
UnmodifiableMapView<String, dynamic> get env => UnmodifiableMapView(_env);

/// The hidden map for building the [UnmodifiableMapView]
final Map<String, dynamic> _env = <String, dynamic>{};

/// The default file name
String get _filename => '.env';

/// Default extension for `isProduction`
String get _production => '.production';

/// Default extension for `isDebug`
String get _debug => '.debug';

/// Will handle the loading from the .env file
class ShaEnv {
  /// The path for the .env [File] is if isn't in the Dart/Flutter project
  final String path;

  /// if set to true, the file used gonna be .env.production
  /// Will supersede [isDebug]
  final bool isProduction;

  /// if set to true, the file used gonna be .env.production
  final bool isDebug;

  /// if set to true, varaibles from [Platform.environment] will aslo be loaded into our env
  final bool includePlatformEnvironment;

  /// Private constructor
  const ShaEnv._(
      {required this.path,
      required this.isProduction,
      required this.isDebug,
      required this.includePlatformEnvironment});

  factory ShaEnv(
      {String path = ".",
      bool isProduction = false,
      bool isDebug = false,
      bool includePlatformEnvironment = false}) {
    return _instance ??= ShaEnv._(
        path: path,
        isDebug: isDebug,
        isProduction: isProduction,
        includePlatformEnvironment: includePlatformEnvironment);
  }

  /// Will load the environment variables asynchrosnously
  Future<bool> load() async {
    File envFile = File('$path$separator${_formatName()}');

    if (!await envFile.exists()) {
      throw FileSystemException('File ${envFile.path} nout found !');
    }

    List<String> lines = await envFile.readAsLines();
    _fillEnvMap(lines);

    return true;
  }

  /// Will load the environment variables synchronously
  bool loadSync() {
    File envFile = File('$path$separator${_formatName()}');

    if (!envFile.existsSync()) {
      throw FileSystemException('File ${envFile.path} nout found !');
    }

    List<String> lines = envFile.readAsLinesSync();
    _fillEnvMap(lines);

    return true;
  }

  /// Format the file name
  String _formatName() {
    if (isProduction) {
      return '$_filename$_production';
    }

    if (isDebug) {
      return '$_filename$_debug';
    }

    return _filename;
  }

  /// Shorthand for mapping the values
  void _fillEnvMap(List<String> lines) {
    for (String line in lines.map((e) => e.trim())) {
      List<String> lineSplitted = line.split('=');
      String key = lineSplitted.first;
      String values = lineSplitted.getRange(1, lineSplitted.length).join('=');

      _env[key] = values;
    }

    if (includePlatformEnvironment) {
      _env.addAll(Platform.environment);
    }
  }
}
