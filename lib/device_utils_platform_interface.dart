import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'device_utils_method_channel.dart';

abstract class DeviceUtilsPlatform extends PlatformInterface {
  DeviceUtilsPlatform() : super(token: _token);

  static final Object _token = Object();
  static DeviceUtilsPlatform _instance = MethodChannelDeviceUtils();

  static DeviceUtilsPlatform get instance => _instance;

  static set instance(DeviceUtilsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('getPlatformVersion() has not been implemented.');
  }

  Future<String?> getDeviceId() {
    throw UnimplementedError('getDeviceId() has not been implemented.');
  }

  Future<int?> getBatteryLevel() {
    throw UnimplementedError('getBatteryLevel() has not been implemented.');
  }

  Future<String?> getNetworkStatus() {
    throw UnimplementedError('getNetworkStatus() has not been implemented.');
  }

  Future<int?> getFreeSpace() {
    throw UnimplementedError('getFreeSpace() has not been implemented.');
  }
}
