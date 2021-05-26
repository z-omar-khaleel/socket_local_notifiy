import 'package:get/get.dart';

class Controller extends GetxController with StateMixin<User> {
  var count = 0.obs;
  @override
  void change(newState, {RxStatus status}) {
    // TODO: implement change
    super.change(newState, status: status);
  }
}

class User {
  String name;
  String title;

  User(this.name, this.title);
}

class IntinalBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => Controller());
  }
}
