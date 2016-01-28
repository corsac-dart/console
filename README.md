# Corsac Console

Console application framework built on top of `corsac-dart/kernel` and the
awesome `args` package.

## 1. Current status

This library is a work-in-progress. APIs can (and most likely will) change
without notice.

## 2. Installation

There is no Pub package yet so you have to use git dependency for now:

```yaml
dependencies:
  corsac_di:
    git: https://github.com/corsac-dart/console.git
```


## 3. Usage

This library is a thin wrapper on top of `CommandRunner` and `Command` classes
provided by the `args` package, so on how to use these classes please refer to
the `args` package docs.

What this library adds on top is:

1. Dependency injection for commands.
2. Access to `Kernel.execute()`.

The "hello_world" example can be found in the `example/hello_world.dart`.

## 4. License

BSD-2
