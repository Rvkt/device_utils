import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'device_utils_platform_interface.dart';

/// An implementation of [DeviceUtilsPlatform] that uses method channels.
class MethodChannelDeviceUtils extends DeviceUtilsPlatform {
  static const MethodChannel _channel = MethodChannel('device_utils');

  @override
  Future<String?> getPlatformVersion() async {
    return await _channel.invokeMethod<String>('getPlatformVersion');
  }

  @override
  Future<String?> getDeviceId() async {
    return await _channel.invokeMethod<String>('getDeviceId');
  }

  @override
  Future<int?> getBatteryLevel() async {
    return await _channel.invokeMethod<int>('getBatteryLevel');
  }

  @override
  Future<String?> getNetworkStatus() async {
    return await _channel.invokeMethod<String>('getNetworkStatus');
  }

  @override
  Future<int?> getFreeSpace() async {
    return await _channel.invokeMethod<int>('getFreeSpace');
  }
}
