import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class ThirdPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ThirdStatefulWidget();
  }
}

// 定义一个回调函数类型，用于接收开关状态改变时的值
typedef SwitchChangedCallback = void Function(bool value);


class ThirdStatefulWidget extends StatefulWidget {
  const ThirdStatefulWidget({Key? key}) : super(key: key);

  @override
  _ThirdStatefulWidgetState createState() => _ThirdStatefulWidgetState();
}

class _ThirdStatefulWidgetState extends State<ThirdStatefulWidget> {
  bool adb = false;

  @override
  Widget build(BuildContext context) {
    print('ThirdStatefulWidget build $adb');
    return Scaffold(
      appBar: AppBar(
        title: Text('Third Page'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Go back!'),
            ),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  adb = !adb;
                });
              },
              child: Text('更新'),
            ),

            ItemSwitchView(
              text: 'Switch 1',
              initialSwitchValue: adb,
              onSwitchChanged: (value) {
                print('Switch 1: $value');
              },
            ),
            
            Text("data: $adb"),

            Container(
              color: Colors.black,
              width: 100,
              height: 100,
            ),

            SizedBox(
              height: 20,
            ),

            Container(
              color: Colors.red,
              width: 100,
              height: 100,
              child: Center(
                child: GestureDetector(
                  onTap: (){
                    print('点击了绿色');
                    // try {
                      throw Exception('点击了绿色');
                    // } catch (e) {
                    //   print(e);
                    // }
                  },
                  child: Container(
                    color: Colors.green,
                    width: 50,
                    height: 50,
                    child: Center(
                      child: GestureDetector(
                        onTap: (){
                          print('点击了蓝色');
                        },
                        child: Container(
                          color: Colors.blue,
                          width: 30,
                          height: 30,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
// 自定义的ItemView Widget
class ItemSwitchView extends StatefulWidget {
  final String text;
  final bool initialSwitchValue;
  final SwitchChangedCallback onSwitchChanged;

  ItemSwitchView({
    super.key,
    required this.text,
    this.initialSwitchValue = false,
    required this.onSwitchChanged,
  }){
    print('ItemSwitchView constructor');
  }

  @override
  _ItemSwitchViewState createState() {
    print('ItemSwitchView createState');
    return _ItemSwitchViewState();
  }
}

class _ItemSwitchViewState extends State<ItemSwitchView> {
  bool _switchValue = false;

  @override
  void initState() {
    super.initState();
    _switchValue = widget.initialSwitchValue;
    print('ItemSwitchView initState');
  }

  @override
  void didUpdateWidget(covariant ItemSwitchView oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('didUpdateWidget: ${widget.initialSwitchValue}');
    if (widget.initialSwitchValue != oldWidget.initialSwitchValue) {
      _switchValue = widget.initialSwitchValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FlutterSwitch(
            inactiveColor: const Color(0x1affffff),
            activeColor: const Color(0x1AF66454),
            inactiveToggleColor: const Color(0x99ffffff),
            activeToggleColor: const Color(0x1AA31E0F),
            width: 30.33,
            height: 16,
            borderRadius: 8,
            toggleSize: 10.81,
            value: _switchValue,
            onToggle: (newValue) async {
              setState(() {
                _switchValue = newValue;
              });
              widget.onSwitchChanged(newValue);
            },
          ),
        ],
      ),
    );
  }
}