import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:woocommer_api/config.dart';
import 'package:woocommer_api/models/category.dart';
import 'package:woocommer_api/models/customer.dart';
import 'package:woocommer_api/models/login.dart';
import 'package:woocommer_api/models/product.dart';

class ApiService {
  Future<bool> createCustomer(CustomerModel model) async {
    var authToken =
        base64.encode(utf8.encode(Config.key + ":" + Config.secret));

    bool ret = false;
    try {
      var response = await Dio().post(Config.url + Config.customerUrl,
          data: model.toJson(),
          options: new Options(headers: {
            HttpHeaders.authorizationHeader: 'Basic $authToken',
            HttpHeaders.contentTypeHeader: 'application/json'
          }));
      if (response.statusCode == 201) {
        ret = true;
      }
    } on DioError catch (e) {
      if (e.response.statusCode == 404) {
        ret = false;
      } else {
        ret = false;
      }
    }
    return ret;
  }

  Future<LoginResponseModel> loginCustomer(
      String username, String password) async {
    LoginResponseModel model;

    try {
      var response = await Dio().post(Config.tokenUrl,
          data: {"username": username, "password": password},
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded',
          }));

      if (response.statusCode == 200) {
        model = LoginResponseModel.fromJson(response.data);
      }
    } on DioError catch (e) {
      print(e.message);
    }
    return model;
  }

  Future<List<Category>> getCategories() async {
    List<Category> data = new List<Category>();

    try {
      String url = Config.url +
          Config.categoryUrl +
          "?consumer_key=${Config.key}&consumer_secret=${Config.secret}";
      var response = await Dio().get(url,
          options: new Options(
              headers: {HttpHeaders.contentTypeHeader: 'application/json'}));

      if (response.statusCode == 200) {
        data =
            (response.data as List).map((i) => Category.fromJson(i)).toList();
      }
    } on DioError catch (e) {
      print(e.message);
    }
    return data;
  }

  Future<List<Product>> getProducts({
    String tagname,
    int pageNumber,
    int pageSize,
    String srtSearch,
    String categoryId,
    String sortBy,
    String sortOrder = "asc",
    List<int> productIDs,
  }) async {
    List<Product> data = new List<Product>();
    print("Page: $pageNumber");
    print("Order: $sortOrder");

    try {
      String parameter = "";

      if (srtSearch != null) {
        parameter += "&search=$srtSearch";
      }
      if (pageSize != null) {
        parameter += "&per_page=$pageSize";
      }
      if (pageNumber != null) {
        parameter += "&page=$pageNumber";
      }
      if (tagname != null) {
        parameter += "&tag=$tagname";
      }
      if (categoryId != null) {
        parameter += "&category=$categoryId";
      }
      if (sortBy != null) {
        parameter += "&orderby=$sortBy";
      }
      if (sortOrder != null) {
        parameter += "&order=$sortOrder";
      }
      if (productIDs != null) {
        parameter += "&include=${productIDs.join(",").toString()}";
      }

      String url = Config.url +
          Config.productsUrl +
          "?consumer_key=${Config.key}&consumer_secret=${Config.secret}${parameter.toString()}";
      print(url);
      // String url = "https://buymore-7643ec.ingress-baronn.easywp.com/wp-json/wc/v3/products?consumer_key=ck_6d94407ffd1c9dbf212edf86c117c7becefb930d&consumer_secret=cs_beeec2e29033bdb03411e9833b66866601b5dc0b&page=$pageNumber&order=$sortOrder";
      var response = await Dio().get(url,
          options: new Options(
              headers: {HttpHeaders.contentTypeHeader: 'application/json'}));

      if (response.statusCode == 200) {
        data = (response.data as List).map((i) => Product.fromJson(i)).toList();
      }
    } on DioError catch (e) {
      print(e.message);
    }
    return data;
  }
}
