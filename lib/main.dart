import 'dart:developer';

import 'package:battery/battery.dart';
import 'package:firstapp/Echo.dart';
import 'package:firstapp/async_state_example.dart';
import 'package:firstapp/globalkey_learn.dart';
import 'package:firstapp/isolate_test_manager.dart';
import 'package:firstapp/route/second_page.dart';
import 'package:firstapp/route/third_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hello/hello.dart';
import 'CameraCenterButton.dart';
import 'GradientButton.dart';

void main() {
  debugPaintSizeEnabled = true;
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue asyncValue = ref.watch(asyncStateExampleProvider);
    print("Jeck   " + asyncValue.toString());

    ref.listen(asyncStateExampleProvider, (AsyncValue<bool>? previous, AsyncValue<bool> next) {
      print("Jeck   ${previous.toString()}  ${next.toString()}");
    });
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amberAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter De+++'),
      routes: {
        "second": (context) =>  SecondPage(),
        "third": (context) =>  ThirdPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({ super.key, required this.title });

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 1;
  Calculator calculatorCounter = Calculator();
  IsolateTestManager isolateTestManager = IsolateTestManager();

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('Jeck test initState');
  }

  @override
  Widget build(BuildContext context) {
    print("Jeck 计数${_counter} ${_counter % 2}" );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // button jump to second page
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "second");
              },
              child: Text("Jump to second page"),
            ),

            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "third");
              },
              child: Text("Jump to third page"),
            ),

            GestureDetector(
              onTap: () {
                isolateTestManager.runIsolate();
              },
              child: Text("测试isolate改变变量"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _incrementCounter();
          // print number per second
          // for (int i = 0; i < 1000000; i++) {
          //   // delay 1s
          //   await Future.delayed(const Duration(seconds: 1));
          //   print(i);
          // }

          GlobalKeyChild.globalKey.currentState?.changeColor();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class VersionWidget extends StatefulWidget {
  const VersionWidget({super.key});

  @override
  State<VersionWidget> createState() => VersionState();
}

class VersionState extends State<VersionWidget> {
  String _platformVersion = 'Unknown';
  final _helloPlugin = Hello();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await _helloPlugin.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text('Running on: $_platformVersion\n');
  }
}

class TextWidget extends StatefulWidget {
  const TextWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return TextState();
  }
}

class TextState extends State<TextWidget> {

  String _specificText = "Unknown";

  final platform = const MethodChannel('samples.flutter.dev/specific_text');
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text(_specificText);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSpecificText();
  }

  Future<void> getSpecificText() async {

      String specificText;
      try {
        specificText = await platform.invokeMethod('getSpecificText');
      } on PlatformException {
        specificText = 'Failed to get specific text.';
      }

      setState(() {
        _specificText = specificText;
      });
    }
}

