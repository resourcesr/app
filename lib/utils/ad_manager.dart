import 'dart:io';

class AdManager {
  static String get appId {
    if (Platform.isAndroid) {
      return "ca-app-pub-7415671935312587/4809484729";
    } else if (Platform.isIOS) {
      return "ca-app-pub-7415671935312587/4809484729";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-7415671935312587/4809484729";
    } else if (Platform.isIOS) {
      return "ca-app-pub-7415671935312587/4809484729";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}
