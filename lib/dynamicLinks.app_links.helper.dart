import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:dynamic_links_helper/abstracts/dynamicLinkHandler.abstract.dart';
// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class DynamicLinksHelper {
  static final _appLinks = AppLinks();
  static late StreamSubscription<Uri> _linkSubscription;

  // Initialization
  static Future<void> init({
    required DynamicLinkServiceHandler handler,
  }) async {
    // Get the initial/first link.
    // This is useful when app was terminated (i.e. not started)
    // Try to get initial value (app just open)
    handler.handler(await _appLinks.getInitialAppLink());

    _linkSubscription =
        _appLinks.uriLinkStream.listen((uri) => handler.handler(uri));
    // // Listen to dynamic (app has opened)
    // FirebaseDynamicLinks.instance.onLink.listen(
    //     (PendingDynamicLinkData dynamicLink) => handler.handler(dynamicLink));
  }

  static dispose() => _linkSubscription.cancel();

  // create link
  static Future<Uri> create({
    required String uriPrefix,
    required String appWebsiteUrl,
    required String bundleId,
    required String appStoreIdentifier,
    required String socialImage,
    required String path,
    required String socialTitle,
    required String socialDescription,
    String? params,
    bool shortLink = true,
  }) async {
    Uri url = Uri();
    return url;
    // // define url as payload
    // Uri url;
    // print(Uri.parse('$appWebsiteUrl/$path?$params'));
    // // initialize a dynamic link
    // final DynamicLinkParameters parameters = DynamicLinkParameters(
    //   uriPrefix: uriPrefix,
    //   link: Uri.parse('$appWebsiteUrl/$path?$params'),
    //   androidParameters: AndroidParameters(
    //     packageName: bundleId,
    //   ),
    //   iosParameters: IOSParameters(
    //     bundleId: bundleId,
    //     appStoreId: appStoreIdentifier,
    //   ),
    //   socialMetaTagParameters: SocialMetaTagParameters(
    //     title: socialTitle,
    //     description: socialDescription,
    //     imageUrl: Uri.parse(socialImage),
    //   ),
    // );

    // // build link as short or normal
    // if (shortLink) {
    //   final ShortDynamicLink shortenedLink =
    //       await FirebaseDynamicLinks.instance.buildShortLink(parameters);

    //   url = shortenedLink.shortUrl;
    // } else {
    //   url = await FirebaseDynamicLinks.instance.buildLink(parameters);
    // }

    // // return payload
    // return url;
  }
}
