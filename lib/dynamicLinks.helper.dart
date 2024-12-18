import 'dart:async';
import 'dart:convert';
import 'package:dynamic_links_helper/abstracts/dynamicLinkHandler.abstract.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';

class DynamicLinksHelper {
  // Initialization
  static Future<void> init({
    required DynamicLinkServiceHandler handler,
    bool test = true,
  }) async {
    // init branch sdk
    await FlutterBranchSdk.init(enableLogging: test, disableTracking: test);

    // // Try to get initial value (app just open)
    handler.handler(await FlutterBranchSdk.getFirstReferringParams());
    // // Listen to dynamic (app has opened)

    FlutterBranchSdk.listSession().listen((data) {
      // skip
      if (!data.containsKey("+clicked_branch_link") ||
          data["+clicked_branch_link"] != true) return;

      //Link clicked. Add logic to get link data
      handler.handler(data);
    });
  }

  // create link
  static Future<String?> create({
    required String identifier,
    required String imageUrl,
    required String path,
    required String title,
    required String description,
    required List<String> keywords,
    Map<String, dynamic>? queryParameters,
  }) async {

    // Create content reference
    //To Setup Data For Generation Of Deep Link
    BranchUniversalObject buo = BranchUniversalObject(
      canonicalIdentifier: identifier,
      title: title,
      imageUrl: imageUrl,
      contentDescription: description,
      keywords: keywords,
      publiclyIndex: true,
      locallyIndex: true,
      contentMetadata: BranchContentMetaData()
        ..addCustomMetadata('title', title),
    );

    // Inject queryParameters
    BranchLinkProperties lp = BranchLinkProperties();
    lp.addControlParam('path', path);
    lp.addControlParam('queryParameters', jsonEncode(queryParameters));

    BranchResponse response =
        await FlutterBranchSdk.getShortUrl(buo: buo, linkProperties: lp);

    if (!response.success) return null;

    // return payload
    return response.result;
  }
}
