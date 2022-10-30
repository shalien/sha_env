Yet another DotEnv handling library for Dart but all the other gave me headaches.
So let's keep thing simple, just an .env with KEY=WALUE inside and one line to load it and a top level object to access those, ok ?


## Features

- Simplicity 
- 1 Line to load
- 1 top level object to access

## Getting started

Run 
```sh
    dart pub add sha_env
```

## Usage


```dart
/// You must create the .env file at the root of your dart project
/// OR use the `path` parameter to specify the file path

import 'package:sha_env/sha_env.dart';


void main() {
  /// Will load the variablesfrom .env file
  ShaEnv().loadSync();

  /// print variable api key
  print(env['API_KEY']);
}


```

## Additional information

- You can use `=` inside values BUT not in key
- Inspired by the PHP's DotEnv lib used by Laravel