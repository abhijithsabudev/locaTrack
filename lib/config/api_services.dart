import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:locatrack/config/api_endpoints.dart';

enum Method { post, get, put, delete, patch }

enum DioMethod { post, get, put, delete, patch, putForm, patchForm, postForm }

class ApiServices {
  ApiEndPoints serverAddresses = ApiEndPoints();

  Future<dynamic> dioRequest(
      {required String url,
      required DioMethod method,
      bool removeAuth = false,
      Map<String, dynamic>? params,
      required String token,
      CancelToken? cancelToken,
      required int userId,
      void Function(int, int)? onSendProgress}) async {
    late Response response;
    var dio = Dio();
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers['authorization'] = 'Bearer $token';
    dio.options.headers['userId'] = '$userId';
    try {
      if (method == DioMethod.putForm) {
        response = await dio.put(url, data: FormData.fromMap(params!));
        log('response => ${response.toString()}');
      }
      if (method == DioMethod.patchForm) {
        response = await dio.patch(url, data: FormData.fromMap(params!));
        log(response.toString());
      }
      if (method == DioMethod.postForm) {
        response = await dio.post(url,
            data: FormData.fromMap(params!), onSendProgress: onSendProgress);
        log(response.toString());
      }
      if (method == DioMethod.post) {
        response = await dio.post(url, data: params);
      }
      if (method == DioMethod.delete) {
        response = await dio.delete(url, data: params);
      }
      if (method == DioMethod.patch) {
        response = await dio.patch(url, data: params);
      }
      if (method == DioMethod.put) {
        response = await dio.put(url, data: params);
      }
      if (method == DioMethod.get) {
        response = await dio.get(url);
      }
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else if (response.statusCode == 400) {
        return response.data;
      } else if (response.statusCode == 401) {
        throw Exception("Unauthorized");
      } else if (response.statusCode == 500) {
        throw Exception("Server Error");
      } else {
        log(response.statusCode.toString());
        log(response.statusMessage.toString());
        throw Exception("Something went wrong");
      }
    } on SocketException catch (e) {
      log('error => ${e.toString()}');
      throw Exception("No Internet Connection");
    } on FormatException catch (e) {
      log('error => ${e.toString()}');
      throw Exception("Bad response format");
    } catch (e) {
      if (e.toString().contains('401')) {
        throw Exception("Unauthorized");
      } else {
        log('error => ${e.toString()}');
        throw Exception("Something went wrong 2");
      }
    }
  }

  /// Request for public api
  Future<dynamic> dioRequestPublic({
    required String url,
    required DioMethod method,
    bool removeAuth = false,
    Map<String, dynamic>? params,
  }) async {
    late Response response;
    var dio = Dio();
    dio.options.headers['content-Type'] = 'application/json';
    try {
      if (method == DioMethod.putForm) {
        response = await dio.put(url, data: FormData.fromMap(params!));
        log('response => ${response.toString()}');
      }
      if (method == DioMethod.patchForm) {
        response = await dio.patch(url, data: FormData.fromMap(params!));
        log(response.toString());
      }
      if (method == DioMethod.post) {
        response = await dio.post(url, data: params);
      }
      if (method == DioMethod.delete) {
        response = await dio.delete(url, data: params);
      }
      if (method == DioMethod.patch) {
        response = await dio.patch(url, data: params);
      }
      if (method == DioMethod.put) {
        response = await dio.put(url, data: params);
      }
      if (method == DioMethod.get) {
        response = await dio.get(url);
      }
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else if (response.statusCode == 400) {
        return response.data;
      } else if (response.statusCode == 401) {
        throw Exception("Unauthorized");
      } else if (response.statusCode == 500) {
        throw Exception("Server Error");
      } else {
        log(response.statusCode.toString());
        log(response.statusMessage.toString());
        throw Exception("Something went wrong");
      }
    } on SocketException catch (e) {
      log('error => ${e.toString()}');
      throw Exception("No Internet Connection");
    } on FormatException catch (e) {
      log('error => ${e.toString()}');
      throw Exception("Bad response format");
    } catch (e) {
      log('error => ${e.toString()}');
      throw Exception("Something went wrong");
    }
  }
}
