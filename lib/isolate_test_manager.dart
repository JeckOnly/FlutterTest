import 'dart:isolate';

class IsolateTestManager {
  static IsolateTestManager instance = IsolateTestManager._();
  IsolateTestManager._();

  factory IsolateTestManager() => instance;

  bool mutex = false;

  void runIsolate() {
    print('runIsolate 主isolate$mutex  hashcode: ${this.hashCode}');
    if (mutex) {
      print('runIsolate return');
      return;
    }
    mutex = true;
    Isolate.run(() async {
      print('Isolate.run');
      // delay 3 seconds
      print('Isolate.run Future.delayed start');
      await Future.delayed(Duration(seconds: 3), () {
        print('Isolate.run Future.delayed end');
      });
      mutex = false;
      print('runIsolate 子isolate $mutex hashcode: ${this.hashCode}');
    });
  }
}