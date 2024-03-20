import 'package:dynamic_links_helper/abstracts/dynamicLinkHandler.abstract.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class DynamicLinksHelper {
  // Initialization
  static Future<void> init({
    required DynamicLinkServiceHandler handler,
  }) async {
    // Try to get initial value (app just open)
    handler.handler(await FirebaseDynamicLinks.instance.getInitialLink());
    // Listen to dynamic (app has opened)
    FirebaseDynamicLinks.instance.onLink.listen(
        (PendingDynamicLinkData dynamicLink) => handler.handler(dynamicLink));
  }

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
    // define url as payload
    Uri url;

    // initialize a dynamic link
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: uriPrefix,
      link: Uri.parse('$appWebsiteUrl/$path?$params'),
      androidParameters: AndroidParameters(
        packageName: bundleId,
        minimumVersion: 0,
      ),
      iosParameters: IOSParameters(
        bundleId: bundleId,
        appStoreId: appStoreIdentifier,
        minimumVersion: '0',
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
        title: socialTitle,
        description: socialDescription,
        imageUrl: Uri.parse(socialImage),
      ),
    );

    // build link as short or normal
    url = await FirebaseDynamicLinks.instance.buildLink(parameters);
    // if (shortLink) {
    //   final ShortDynamicLink shortenedLink =
    //       await FirebaseDynamicLinks.instance.buildShortLink(parameters);

    //   url = shortenedLink.shortUrl;
    // } else {
    //   url = await FirebaseDynamicLinks.instance.buildLink(parameters);
    // }

    // return payload
    return url;
  }
}
