/// Console application framework built on top of Corsac [Kernel] and Dart's
/// `args` package.
library corsac_console;

import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:corsac_kernel/corsac_kernel.dart';

export 'package:args/command_runner.dart';

class ConsoleKernelModule extends KernelModule {
  @override
  Map getServiceConfiguration(String environment) {
    return {'console.commands': new List<Command>(),};
  }
}

/// Console application built on top of Corsac [Kernel] and the `args` package.
class Console {
  final CommandRunner commandRunner;
  final Kernel kernel;

  Console(this.kernel, String name, String description)
      : commandRunner = new CommandRunner(name, description) {
    List<Command> commands = kernel.get('console.commands');
    commands.forEach((_) {
      commandRunner.addCommand(_);
    });
  }

  Future run(List<String> args) {
    return commandRunner.run(args).catchError((e) {
      print(e);
      var code = (e is UsageException) ? 64 : 255;
      exit(code);
    });
  }
}
