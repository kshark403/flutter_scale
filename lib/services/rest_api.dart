import 'dart:convert';

import 'package:flutter_scale/utils/constants.dart';
import 'package:http/http.dart' as http;

class CallAPI {
  // Set Header
  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };

  // Login API Method
  loginAPI(data) async {
    return await http.post(
      // Uri.parse('http://localhost:8000/api/login'),
      Uri.parse('${baseURLAPI}login'),
      body: jsonEncode(data),
      headers: _setHeaders(),
    );
  }
}
