import 'package:dio/dio.dart' as d;
import 'package:flutter/foundation.dart';
import 'package:gql_dio_link/gql_dio_link.dart';
import 'package:gql_link/gql_link.dart';
import 'package:playground/network/rest_constants.dart';

class ApiClient {
  static final ApiClient _converter = ApiClient._internal();

  static const String kRequiredHeader = 'Header';
  static const String kAuthorization = 'Authorization';

  factory ApiClient() {
    return _converter;
  }

  ApiClient._internal();

  d.Dio dio() {
    var dio = d.Dio(
      d.BaseOptions(
        connectTimeout: 10000,
        receiveTimeout: 10000,
      ),
    );

    if (kDebugMode) {
      dio.interceptors.add(d.LogInterceptor(
        error: true,
        requestHeader: true,
        requestBody: true,
        responseBody: true,
      ));
    }
    return dio;
  }

  Link dioLink() {
    return DioLink(
      RestConstants.kGraphQLEndPoint,
      client: dio(),
    );
  }
}
