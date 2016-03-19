/// Console application framework built on top of Corsac [Kernel] and Dart's
/// `args` package.
library corsac_console;

import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:corsac_kernel/corsac_kernel.dart';

export 'package:args/command_runner.dart';

/// Console application built on top of Corsac [Kernel] and the `args` package.
class Console {
  /// The ID of kernel's container entry with the list of console commands.
  final String commandsEntryId = 'console.commands';
  final CommandRunner commandRunner;
  final Kernel kernel;

  Console(this.kernel, String name, String description)
      : commandRunner = new CommandRunner(name, description) {
    if (kernel.container.has(commandsEntryId)) {
      List<Command> commands = kernel.get(commandsEntryId);
      commands.forEach((_) {
        commandRunner.addCommand(_);
      });
    }
  }

  Future run(List<String> args) {
    var code = 0;
    return kernel.execute(() => commandRunner.run(args)).catchError((e) {
      print(e);
      code = (e is UsageException) ? 64 : 255;
    }).whenComplete(() {
      exit(code);
    });
  }
}
