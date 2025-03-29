import 'package:flutter_test/flutter_test.dart';
import 'package:device_utils/device_utils.dart';
import 'package:device_utils/device_utils_platform_interface.dart';
import 'package:device_utils/device_utils_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockDeviceUtilsPlatform
    with MockPlatformInterfaceMixin
    implements DeviceUtilsPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final DeviceUtilsPlatform initialPlatform = DeviceUtilsPlatform.instance;

  test('$MethodChannelDeviceUtils is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelDeviceUtils>());
  });

  test('getPlatformVersion', () async {
    DeviceUtils deviceUtilsPlugin = DeviceUtils();
    MockDeviceUtilsPlatform fakePlatform = MockDeviceUtilsPlatform();
    DeviceUtilsPlatform.instance = fakePlatform;

    expect(await deviceUtilsPlugin.getPlatformVersion(), '42');
  });
}
