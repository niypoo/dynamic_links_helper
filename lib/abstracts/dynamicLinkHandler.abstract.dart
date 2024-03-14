import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

abstract class DynamicLinkServiceHandler {
  // abstract
  void handler(PendingDynamicLinkData? dynamicLink);

  // Get Path
  String getPath(PendingDynamicLinkData dynamicLink) => dynamicLink.link.path;

  // Get Params
  Map<String, String> getParams(PendingDynamicLinkData dynamicLink) =>
      dynamicLink.link.queryParameters;
}
