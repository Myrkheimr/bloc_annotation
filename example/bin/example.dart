import 'package:example/counter_example.dart' as counter;
import 'package:example/counter_bloc_example.dart' as counter_bloc;

void main(List<String> args) {
  if (args.length != 1) {
    print(
      'Only 1 example example can be executed at a time.'
      '\n'
      '\n'
      'Supported args:'
      '\n'
      '\n'
      '1. --counter_example'
      '\n'
      '2. --counter_bloc_example',
    );

    return;
  }

  return switch (args.first) {
    "--counter_example" => counter.run(),
    "--counter_bloc_example" => counter_bloc.run(),
    _ => () {
      print(
        '${args.first} is not supported, choose one of the below mentioned examples.'
        '\n'
        '\n'
        'Supported args:'
        '\n'
        '\n'
        '1. --counter_example'
        '\n'
        '2. --counter_bloc_example',
      );
    }(),
  };
}
