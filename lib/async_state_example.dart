import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'async_state_example.g.dart';

@riverpod
class AsyncStateExample extends _$AsyncStateExample {
  @override
  FutureOr<bool> build() async {
    // delay 2000
    await Future.delayed(const Duration(milliseconds: 2000));
    return false;
  }
}
