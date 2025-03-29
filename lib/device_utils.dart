
import 'device_utils_platform_interface.dart';

class DeviceUtils {
  Future<String?> getPlatformVersion() {
    return DeviceUtilsPlatform.instance.getPlatformVersion();
  }

  Future<String?> getDeviceId() {
    return DeviceUtilsPlatform.instance.getDeviceId();
  }

  Future<int?> getBatteryLevel() {
    return DeviceUtilsPlatform.instance.getBatteryLevel();
  }

  Future<String?> getNetworkStatus() {
    return DeviceUtilsPlatform.instance.getNetworkStatus();
  }

  Future<int?> getFreeSpace() {
    return DeviceUtilsPlatform.instance.getFreeSpace();
  }
}
