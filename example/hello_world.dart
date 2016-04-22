#!/usr/bin/env dart
library corsac_console.hello_world;

import 'package:corsac_console/corsac_console.dart';
import 'package:corsac_kernel/corsac_kernel.dart';
import 'dart:async';

// Create a subclass of `Command` to define your own command.
class HelloWorldCommand extends Command {
  /// Speaker to illustrate dependency injection. See constructor for details.
  final Speaker speaker;

  @override
  String get description => 'Says hi to the world!';

  @override
  String get name => 'hello-world';

  /// The [speaker] parameter will be injected by the Kernel when this command
  /// is instantiated.
  HelloWorldCommand(this.speaker);

  @override
  run() {
    speaker.sayHelloWorld();
  }
}

/// Speaker to illustrate dependency injection.
class Speaker {
  void sayHelloWorld() {
    print('Hello world!');
  }
}

/// One way to register commands with the Console is via kernel modules.
/// The [Console] expects that command be added to a special
/// container entry under key `console.commands` which is a "dynamic list".
/// To add your commands use `DI.add()` helper as follows.
///
/// Another option is to subclass `Console` and register commands in constructor.
/// E.g.:
///     class MyConsole extends Console {
///       MyConsole(Kernel kernel)
///       : super(kernel, 'my_console', 'Description for my console.') {
///         commandRunner.addCommand(kernel.get(HelloWorldCommand));
///       }
///     }
class HelloWorldKernelModule extends KernelModule {
  Map getServiceConfiguration(String environment) => {
        // Register our command with the console app by adding it to special
        // `console.commands` list.
        'console.commands': DI.add([DI.get(HelloWorldCommand)])
      };
}

// Our main function.
Future main(List<String> args) async {
  var kernel = await Kernel.build('dev', {}, [new HelloWorldKernelModule()]);
  var console =
      new Console(kernel, 'hello_world.dart', 'Says hi to the world.');
  return console.run(args);
}
