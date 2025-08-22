import 'package:bloc_builder_generator/src/cubit_generator.dart';
import 'package:source_gen_test/source_gen_test.dart';

Future<void> main() async {
  final reader = await initializeLibraryReaderForDirectory(
    'test/generators',
    'cubit_generator_tests.dart',
  );

  initializeBuildLogTracking();

  testAnnotatedElements(reader, const CubitGenerator());
}
