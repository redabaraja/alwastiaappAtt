import 'dart:io';

// import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdsManager {
  static bool _testMode = false;
  // ca-app-pub-3940256099942544~3347511713   test app id
  static String get appId {
    if (Platform.isAndroid)
      return "ca-app-pub-9326310243717687~2918309086";
    else if (Platform.isIOS)
      return "ca-app-pub-2136157919933059~9314842187";
    else {
      return "";
    }
  }
    


    


  static String get adId {
    if (_testMode) {
      return  'ca-app-pub-3940256099942544/6300978111';
    } else {
      if (Platform.isAndroid)
        return "ca-app-pub-9326310243717687/2859170158";
      else if (Platform.isIOS)
        return "ca-app-pub-2136157919933059/1436352166";
      else {
        return "";
      }
    }
  }

  static final BannerAdListener bannerLisnter = BannerAdListener(
    onAdLoaded: (ad) => debugPrint('AdLoaded.'),
    onAdFailedToLoad: (ad, error) {
      ad.dispose();
      debugPrint('ads faild to load : $error');
    },
    onAdOpened: (ad) => debugPrint('ads opended'),
    onAdClosed: (ad) => debugPrint('ads closded'),
  );
}
