// ignore_for_file: prefer_interpolation_to_compose_strings, unnecessary_null_comparison

import 'dart:convert';

import 'package:flutter_scale/models/news_model.dart';
import 'package:flutter_scale/models/product_model.dart';
import 'package:flutter_scale/utils/constants.dart';
import 'package:flutter_scale/utils/utility.dart';
import 'package:http/http.dart' as http;

class CallAPI {
  // Set Header
  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };

  // Login API Method
  loginAPI(data) async {
    // check network connection
    if (await Utility.checkNetwork() == '') {
      return http.Response(
        jsonEncode(
          {'status': 'error', 'message': 'No Internet Connection'},
        ),
        200,
      );
    } else {
      return await http.post(
        // Uri.parse('http://localhost:8000/api/login'),
        Uri.parse('${baseURLAPI}login'),
        body: jsonEncode(data),
        headers: _setHeaders(),
      );
    }
  }

  // Read Last News API Method
  Future<List<NewsModel>?> getLastNews() async {
    // check network connection
    if (await Utility.checkNetwork() == '') {
      return null;
    } else {
      final response = await http.get(
        Uri.parse(baseURLAPIItgenius + 'lastnews'),
        headers: _setHeaders(),
      );

      if (response.body != null) {
        return newsModelFromJson(response.body);
      } else {
        return null;
      }
    }
  }

  // Read All News API Method
  Future<List<NewsModel>?> getAllNews() async {
    // check network connection
    if (await Utility.checkNetwork() == '') {
      return null;
    } else {
      final response = await http.get(
        Uri.parse(baseURLAPIItgenius + 'news'),
        headers: _setHeaders(),
      );

      if (response.body != null) {
        return newsModelFromJson(response.body);
      } else {
        return null;
      }
    }
  }

  // ===============================================
  // CRUD Product API Method
  // ===============================================
  // Get All Product API Method
  Future<List<ProductModel>?> getAllProducts() async {
    // check network connection
    if (await Utility.checkNetwork() == '') {
      return null;
    } else {
      final response = await http.get(
        Uri.parse(baseURLAPIItgenius + 'products'),
        headers: _setHeaders(),
      );

      if (response.body != null) {
        return productModelFromJson(response.body);
      } else {
        return null;
      }
    }
  }

  // Get Product By ID API Method
  Future<ProductModel?> getProductByID(id) async {
    // check network connection
    if (await Utility.checkNetwork() == '') {
      return null;
    } else {
      final response = await http.get(
        Uri.parse(baseURLAPIItgenius + 'products/' + id.toString()),
        headers: _setHeaders(),
      );

      if (response.body != null) {
        return ProductModel.fromJson(jsonDecode(response.body));
      } else {
        return null;
      }
    }
  }

  // Create Product By ID API Method
  Future<bool> addProduct(ProductModel data) async {
    // check network connection
    if (await Utility.checkNetwork() == '') {
      return false;
    } else {
      final response = await http.post(
        Uri.parse(baseURLAPIItgenius + 'products/'),
        body: productModelToJson(data),
        headers: _setHeaders(),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    }
  }

  // Update Product By ID API Method
  Future<bool> updateProduct(ProductModel data) async {
    // check network connection
    if (await Utility.checkNetwork() == '') {
      return false;
    } else {
      final response = await http.put(
        Uri.parse(baseURLAPIItgenius + 'products/${data.id}'),
        body: productModelToJson(data),
        headers: _setHeaders(),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    }
  }

  // Delete Product By ID API Method
  Future<bool> deleteProduct(String id) async {
    // check network connection
    if (await Utility.checkNetwork() == '') {
      return false;
    } else {
      final response = await http.delete(
        Uri.parse(baseURLAPIItgenius + 'products/$id'),
        headers: _setHeaders(),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    }
  }
}
