import 'package:get/get.dart';
import '../controllers/owner_chat_list_controller.dart';

class OwnerChatListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OwnerChatListController>(
      () => OwnerChatListController(),
    );
  }
}
