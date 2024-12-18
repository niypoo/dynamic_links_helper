import 'dart:async';
import 'package:dynamic_links_helper/abstracts/dynamicLinkHandler.abstract.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';

class DynamicLinksHelper {
  // Initialization
  static Future<void> init({
    required DynamicLinkServiceHandler handler,
    bool test = true,
  }) async {


    await FlutterBranchSdk.init(enableLogging: test, disableTracking: test);

    // // Try to get initial value (app just open)
    // handler.handler(await FirebaseDynamicLinks.instance.getInitialLink());
    // // Listen to dynamic (app has opened)
    // FirebaseDynamicLinks.instance.onLink.listen(
    //     (PendingDynamicLinkData dynamicLink) => handler.handler(dynamicLink));

    FlutterBranchSdk.listSession().listen((data) {
      print('Custom string 1 : $data');
      if (data.containsKey("+clicked_branch_link") &&
          data["+clicked_branch_link"] == true) {
        //Link clicked. Add logic to get link data
        print('Custom string 2: $data');
      }
    }, onError: (error) {
      print('listSession error: ${error.toString()}');
    });

    Map<dynamic, dynamic> params =
        await FlutterBranchSdk.getFirstReferringParams();

    print('Custom string 3: ${params}');
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
    // payload link
    String? payload;

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
    // Extra
    if (queryParameters != null && queryParameters.isNotEmpty) {
      queryParameters.forEach((k, v) => lp.addControlParam(k, v));
    }

    BranchResponse response =
        await FlutterBranchSdk.getShortUrl(buo: buo, linkProperties: lp);
    if (response.success) {
      payload = response.result;
    }

    // return payload
    return payload;
  }
}
