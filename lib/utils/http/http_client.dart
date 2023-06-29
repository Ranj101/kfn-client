import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:kurdistan_food_network/utils/http/http_response.dart';
import 'package:http/http.dart' as http;

class HttpClient {
  static const String _url =
      'https://kurdistan-food-network-api.up.railway.app';

  static Future<Map<String, String>> _headers() async {
    final token = await FirebaseAuth.instance.currentUser?.getIdToken();

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };

    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    print('=== TOKEN ===\n$token');

    return headers;
  }

  static Future<HTTPResponse> get(
    String path, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
  }) async {
    final reponse = await http.get(
        Uri.parse('$_url$path').replace(queryParameters: queryParameters),
        headers: headers ?? await _headers());

    dynamic responseBody;

    try {
      responseBody = jsonDecode(reponse.body);
    } catch (_) {
      responseBody = reponse.body;
    }

    return HTTPResponse(
      body: responseBody,
      statusCode: reponse.statusCode,
      isSuccessful: reponse.statusCode >= 200 && reponse.statusCode <= 299,
    );
  }

  static Future<HTTPResponse> post(
    String path, {
    Object? body,
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
  }) async {
    final reponse = await http.post(
        Uri.parse('$_url$path').replace(queryParameters: queryParameters),
        body: body,
        headers: headers ?? await _headers());

    dynamic responseBody;

    try {
      responseBody = await jsonDecode(reponse.body);
    } catch (_) {
      responseBody = reponse.body;
    }

    return HTTPResponse(
      body: responseBody,
      statusCode: reponse.statusCode,
      isSuccessful: reponse.statusCode >= 200 && reponse.statusCode <= 299,
    );
  }

  static Future<HTTPResponse> put(
    String path, {
    Object? body,
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
  }) async {
    final reponse = await http.put(
        Uri.parse('$_url$path').replace(queryParameters: queryParameters),
        body: body,
        headers: headers ?? await _headers());

    dynamic responseBody;

    try {
      responseBody = await jsonDecode(reponse.body);
    } catch (_) {
      responseBody = reponse.body;
    }

    return HTTPResponse(
      body: responseBody,
      statusCode: reponse.statusCode,
      isSuccessful: reponse.statusCode >= 200 && reponse.statusCode <= 299,
    );
  }

  static Future<HTTPResponse> patch(
    String path, {
    Object? body,
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
  }) async {
    final reponse = await http.patch(
        Uri.parse('$_url$path').replace(queryParameters: queryParameters),
        body: body,
        headers: headers ?? await _headers());

    dynamic responseBody;

    try {
      responseBody = await jsonDecode(reponse.body);
    } catch (_) {
      responseBody = reponse.body;
    }

    return HTTPResponse(
      body: responseBody,
      statusCode: reponse.statusCode,
      isSuccessful: reponse.statusCode >= 200 && reponse.statusCode <= 299,
    );
  }

  static Future<HTTPResponse> delete(
    String path, {
    Object? body,
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
  }) async {
    final reponse = await http.delete(
        Uri.parse('$_url$path').replace(queryParameters: queryParameters),
        body: body,
        headers: headers ?? await _headers());

    dynamic responseBody;

    try {
      responseBody = await jsonDecode(reponse.body);
    } catch (_) {
      responseBody = reponse.body;
    }

    return HTTPResponse(
      body: responseBody,
      statusCode: reponse.statusCode,
      isSuccessful: reponse.statusCode >= 200 && reponse.statusCode <= 299,
    );
  }
}
