package com.rvkt.device_utils;

import android.annotation.SuppressLint;
import android.content.Context;
import android.os.BatteryManager;
import android.os.Build;
import android.os.Environment;
import android.provider.Settings;
import android.net.ConnectivityManager;
import android.net.NetworkCapabilities;
import android.net.NetworkInfo;

import androidx.annotation.NonNull;

import java.io.File;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/** DeviceUtilsPlugin */
public class DeviceUtilsPlugin implements FlutterPlugin, MethodCallHandler {
  private MethodChannel channel;
  private Context context;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    context = flutterPluginBinding.getApplicationContext();
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "device_utils");
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    switch (call.method) {
      case "getPlatformVersion":
        result.success("Android " + android.os.Build.VERSION.RELEASE);
        break;
      case "getDeviceId":
        result.success(getDeviceId());
        break;
      case "getFreeSpace":
        result.success(getFreeSpace());
        break;
      case "getBatteryLevel":
        result.success(getBatteryLevel());
        break;
      case "getNetworkStatus":
        result.success(getNetworkStatus());
        break;
      default:
        result.notImplemented();
        break;
    }
  }

  @SuppressLint("HardwareIds")
  private String getDeviceId() {
    return Settings.Secure.getString(context.getContentResolver(), Settings.Secure.ANDROID_ID);
  }

  private long getFreeSpace() {
    File path = Environment.getDataDirectory();
    long freeSpaceBytes = path.getFreeSpace();

    return freeSpaceBytes / (1024 * 1024); // Convert bytes to MB
  }


  private int getBatteryLevel() {
    BatteryManager batteryManager = (BatteryManager) context.getSystemService(Context.BATTERY_SERVICE);
    if (batteryManager != null) {
      return batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY);
    }
    return -1; // Error retrieving battery level
  }

  private String getNetworkStatus() {
    ConnectivityManager cm = (ConnectivityManager) context.getSystemService(Context.CONNECTIVITY_SERVICE);
    if (cm != null) {
      if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
        NetworkCapabilities capabilities = cm.getNetworkCapabilities(cm.getActiveNetwork());
        if (capabilities != null) {
          if (capabilities.hasTransport(NetworkCapabilities.TRANSPORT_WIFI)) {
            return "WiFi";
          } else if (capabilities.hasTransport(NetworkCapabilities.TRANSPORT_CELLULAR)) {
            return "Mobile Data";
          }
        }
      } else {
        NetworkInfo activeNetwork = cm.getActiveNetworkInfo();
        if (activeNetwork != null) {
          if (activeNetwork.getType() == ConnectivityManager.TYPE_WIFI) {
            return "WiFi";
          } else if (activeNetwork.getType() == ConnectivityManager.TYPE_MOBILE) {
            return "Mobile Data";
          }
        }
      }
    }
    return "No Internet";
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }
}
