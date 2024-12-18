abstract class DynamicLinkServiceHandler {
  // abstract
  void handler(Map<dynamic, dynamic>? dynamicLink);

  // Get Path
  String? getPath(Map<dynamic, dynamic> dynamicLink) => dynamicLink['path'];

  // Get Params
  Map<String, String>? getParams(Map<dynamic, dynamic> dynamicLink) =>
      dynamicLink['queryParameters'];
}
