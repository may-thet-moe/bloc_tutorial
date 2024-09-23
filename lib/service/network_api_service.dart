import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc_tutorial/model/movie_list_response.dart';
import 'package:bloc_tutorial/service/base_api_service.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class NetworkApiServices implements BaseApiService {
  Map<String, String> header = {'Accept': 'application/json'};
  @override
  Future<dynamic> getAPi(String url) async {
    dynamic jsonResponse;
    try {
      final response = await http
          .get(Uri.parse(url), headers: header)
          .timeout(const Duration(seconds: 50));
      if (kDebugMode) {
        print("status: ${response.statusCode}");
        print("response: ${jsonDecode(response.body)}");
      }
      if (response.statusCode == 200) {
        jsonResponse = jsonDecode(response.body);
      }
    } on SocketException {
      throw Exception("No Internet");
    } on TimeoutException {
      throw Exception('Time Out Exception');
    }
    return jsonResponse;
  }
}
