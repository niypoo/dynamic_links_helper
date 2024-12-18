abstract class DynamicLinkServiceHandler {
  // abstract
  void handler(Map<dynamic, dynamic>? dynamicLink);

  // Get Path
  String? getPath(Map<dynamic, dynamic>? dynamicLink) {
    // skip
    if (dynamicLink == null || !dynamicLink.containsKey('path')) return null;
    // return payload
    return dynamicLink['path'];
  }

  // Get Params
  Map<String, String>? getParams(Map<dynamic, dynamic>? dynamicLink) {
    // skip
    if (dynamicLink == null || !dynamicLink.containsKey('queryParameters')) return null;
    // return payload
    return Map.from((dynamicLink['queryParameters']));
  }
}
