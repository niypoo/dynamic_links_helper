abstract class DynamicLinkServiceHandler {
  // abstract
  void handler(Uri? dynamicLink);

  // Get Path
  String? getPath(Uri dynamicLink) => dynamicLink.path;

  // Get Params
  Map<String, String>? getParams(Uri dynamicLink) =>
      dynamicLink.queryParameters;
}
