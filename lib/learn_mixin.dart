// abstract class Walker {
//   void walk() {
//     print('I am walking');
//   }
// }
//
// mixin Flyer {
//   void fly() {
//     print('I am flying');
//   }
// }
//
// class Dog with Flyer implements Walker  {
//   @override
//   void walk() {
//     print('Dog is walking');
//
//   }
//
// }
//
// void main() {
//   var dog = Dog();
//   dog.walk();
//   dog.fly();
// }

//BindingBase
abstract class BindingBase {
  void initInstances() {
    print("BindingBase——initInstances ${super.runtimeType.toString()}");
  }
}
//GestureBinding
mixin GestureBinding on BindingBase{
  @override
  void initInstances() {
    print("GestureBinding——initInstances ${super.runtimeType.toString()}");
    super.initInstances();
  }
}
//RendererBinding
mixin RendererBinding on BindingBase {
  @override
  void initInstances() {
    print("RendererBinding——initInstances ${super.runtimeType.toString()}");
    super.initInstances();

  }
}
// WidgetsBinding
mixin WidgetsBinding on BindingBase
{

  @override
  void initInstances() {
    print("WidgetsBinding——initInstances ${super.runtimeType.toString()}");
    super.initInstances();
  }
}
//WidgetsFlutterBinding
class WidgetsFlutterBinding extends BindingBase
    with GestureBinding, RendererBinding, WidgetsBinding {
  static WidgetsBinding ensureInitialized() {
    return WidgetsFlutterBinding();
  }
}


void main(List<String> arguments) {

  WidgetsFlutterBinding.ensureInitialized().initInstances();
}