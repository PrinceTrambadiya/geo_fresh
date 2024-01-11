import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:http/http.dart' as http;

class WebClient {
  const WebClient();

  String _checkUrl(String url) {
    if (!url.startsWith('http')) {
      if (!url.contains('/api/v1')) {
        url = '/api/v1' + url;
      }

//      url = kApiUrl + url;
    }

    if (!url.contains('?')) {
      url += '?';
    }

    return url;
  }

  String _parseError(int code, String response) {
    dynamic message = response;

    if (response.contains('DOCTYPE html')) {
      return '$code: An error occurred';
    }

    try {
      final dynamic jsonResponse = json.decode(response);
      message = jsonResponse['error'] ?? jsonResponse;
      message = message['message'] ?? message;
      try {
        jsonResponse['errors'].forEach((String field, List<String> errors) =>
            errors.forEach((error) => message += '\n$field: $error'));
      } catch (error) {
        // do nothing
      }
    } catch (error) {
      // do nothing
    }

    return '$message';
  }

  Future<dynamic> get(String url, {Map<String, String> headers}) async {
    url = _checkUrl(url);
    // debugPrint('GET: $url');

    if (headers == null) {
      headers = new Map<String, String>();
    }
    // debugPrint('==== HEADERS ====');
    // debugPrint(headers.toString());
    final http.Response response =
        await http.Client().get(Uri.parse(url), headers: headers);

    if (response.statusCode == 500 ||
        response.statusCode == 400 ||
        response.statusCode == 401 ||
        response.statusCode == 404) {
      // final jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      // debugPrint('==== FAILED ====');
      // debugPrint('body: ${response.body}');
      // debugPrint('body: $jsonResponse');
      if (response.statusCode == 500) {
        Future.error("Internal server error");
      }
      throw _parseError(response.statusCode, response.body);
    }

    try {
      final jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      jsonResponse['status'] = response.statusCode;
      return jsonResponse;
    } catch (exception) {
      if (response.statusCode == 200) {
        return true;
      }
      throw ('An error occurred');
    }
  }

  Future<dynamic> post(String url, dynamic data,
      {Map<String, String> headers}) async {
    /*url = _checkUrl(url);*/
    // debugPrint('POST: $url');
    // debugPrint('Data: $data');
    if (headers == null) {
      headers = new Map<String, String>();
    }
    headers.addAll({
      'Content-Type': 'application/json',
    });
    data = json.encode(data);
    // debugPrint('Data : $data');
    final http.Response response = await http.Client().post(
      Uri.parse(url),
      body: data,
      headers: headers,
    );
    // debugPrint(response.statusCode.toString());

    if (response.statusCode == 400 ||
        response.statusCode == 401 ||
        response.statusCode == 404 ||
        response.statusCode == 500) {
      // debugPrint('==== FAILED ====');
      // debugPrint('body: ${response.body}');
      // debugPrint('body: ${json.decode(utf8.decode(response.bodyBytes))}');
      throw _parseError(response.statusCode, response.body);
    }
    try {
      final jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      jsonResponse['status'] = response.statusCode;
      return jsonResponse;
    } catch (exception) {
      if (response.statusCode == 200) {
        // debugPrint(response.statusCode.toString());
        return true;
      }
      throw ('An error occurred');
    }
  }

  Future<dynamic> patch(String url, dynamic data,
      {Map<String, String> headers}) async {
    url = _checkUrl(url);
    data = json.encode(data);
    // debugPrint('PATCH: $url');
    // debugPrint('Data: $data');
    if (headers == null) {
      headers = new Map<String, String>();
    }
    headers.addAll({
      'Content-Type': 'application/json',
    });
    // debugPrint(headers.toString());
    final http.Response response = await http.Client().patch(
      Uri.parse(url),
      body: data,
      headers: headers,
    );

    if (response.statusCode >= 400) {
      // debugPrint('==== FAILED ====');
      // debugPrint('body: ${response.body}');

      throw _parseError(response.statusCode, response.body);
    }
    try {
      if (response.statusCode == 204 || response.statusCode == 200) {
        final jsonResponse = response.body.isEmpty
            ? ""
            : json.decode(utf8.decode(response.bodyBytes));
        return jsonResponse;
      }
    } catch (exception) {
      // debugPrint(response.body);
      throw ('An error occurred');
    }
  }

  Future<dynamic> put(String url, dynamic data,
      {Map<String, String> headers}) async {
    url = _checkUrl(url);
    data = json.encode(data);
    // debugPrint('PUT: $url');
    // debugPrint('Data: $data');
    if (headers == null) {
      headers = new Map<String, String>();
    }
    headers.addAll({
      'Content-Type': 'application/json',
    });
    final http.Response response = await http.Client().put(
      Uri.parse(url),
      body: data,
      headers: headers,
    );

    if (response.statusCode >= 400) {
      // debugPrint('==== FAILED ====');
      // debugPrint('body: ${response.body}');

      throw _parseError(response.statusCode, response.body);
    }

    try {
      final jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      return jsonResponse;
    } catch (exception) {
      //debugPrint(response.body);
      throw ('An error occurred');
    }
  }

  Future<dynamic> delete(String url, {Map<String, String> headers}) async {
    /*url = _checkUrl(url);*/
    //debugPrint('DELETE: $url');
    if (headers == null) {
      headers = new Map<String, String>();
    }
    final http.Response response = await http.Client().delete(
      Uri.parse(url),
      headers: headers,
    );

    if (response.statusCode == 204) {
      return response.body;
    }

    if (response.statusCode >= 400) {
      //debugPrint('==== FAILED ====');
      //debugPrint('body: ${response.body}');

      throw _parseError(response.statusCode, response.body);
    }
    final jsonResponse = json.decode(utf8.decode(response.bodyBytes));

    try {
      final jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      return jsonResponse;
    } catch (exception) {
      if (response.statusCode == 200) {
        return jsonResponse;
      }
      //debugPrint(response.body);
      throw ('An error occurred');
    }
  }

  Future<dynamic> uploadImage(String url, dynamic data,
      {Map<String, String> headers}) async {
    var uri = Uri.parse(url);
    //debugPrint('Upload Image = $url');
    if (headers == null) {
      headers = new Map<String, String>();
    }
    headers.addAll({"Accept": "*/*", "Content-Type": "multipart/form-data"});
    var request = new http.MultipartRequest('POST', uri);
    request.fields["sampleFile"] = data;
    var multiPartFile = await http.MultipartFile.fromPath("sampleFile", data);

    request.headers
        .addAll({"Accept": "*/*", "Content-Type": "multipart/form-data"});
    request.files.add(multiPartFile);
    var response = await request.send();

    if (response.statusCode == 400 ||
        response.statusCode == 401 ||
        response.statusCode == 404 ||
        response.statusCode == 500) {
      //debugPrint('==== FAILED ====');
      //debugPrint('body: ${response.toString()}');
      throw _parseError(response.statusCode, response.toString());
    }
    var jsonResponse = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      //debugPrint("Image Uploaded");
      //debugPrint("Response " + jsonResponse);
      return json.decode(jsonResponse);
    } else {
      //debugPrint("Upload Failed");
    }

    throw ('An error occurred');
  }
}
