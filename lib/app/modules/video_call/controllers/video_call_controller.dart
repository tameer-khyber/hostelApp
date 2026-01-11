import 'dart:async';
import 'package:get/get.dart';

class VideoCallController extends GetxController {
  
  final isMicOn = true.obs;
  final isCameraOn = true.obs;
  final duration = "00:00".obs;
  final remoteUserName = "Unknown".obs;
  final remoteUserImage = RxnString();
  
  Timer? _timer;
  int _seconds = 0;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null && args is Map) {
      remoteUserName.value = args['name'] ?? "Unknown";
      remoteUserImage.value = args['image'];
    }
    _startTimer();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  void toggleMic() => isMicOn.toggle();
  void toggleCamera() => isCameraOn.toggle();

  void endCall() {
    Get.back();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _seconds++;
      final minutes = (_seconds ~/ 60).toString().padLeft(2, '0');
      final seconds = (_seconds % 60).toString().padLeft(2, '0');
      duration.value = "$minutes:$seconds";
    });
  }
}
