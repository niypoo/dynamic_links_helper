import 'dart:convert';

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
  Map<String, dynamic>? getParams(Map<dynamic, dynamic>? dynamicLink) {
    // skip
    if (dynamicLink == null || !dynamicLink.containsKey('queryParameters') || dynamicLink['queryParameters'].runtimeType != String) return null;
    // return payload
    return jsonDecode(dynamicLink['queryParameters']);
  }
}
