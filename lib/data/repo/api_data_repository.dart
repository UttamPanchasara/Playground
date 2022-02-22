import 'dart:io';

import 'package:gql/language.dart' as gql;
import 'package:gql_exec/gql_exec.dart';
import 'package:gql_dio_link/gql_dio_link.dart';
import 'package:playground/common/constants.dart';
import 'package:playground/data/repo/api_manager.dart';
import 'package:playground/data/repo/entities/character_data.dart';
import 'package:playground/network/app_exception.dart';

import "package:dio/dio.dart" as d;
import '../../network/client/api_client.dart';
import '../../network/model/base_reponse.dart';
import 'package:playground/utils/logs_util.dart';
import 'package:rxdart/rxdart.dart';

class ApiDataRepository {
  ApiManager apiManager = ApiManager();

  Stream<BaseResponse> getCharacters(int pageNo) {
    String query = """{
  characters(page: $pageNo) {
    info {
      pages
      next
    }
    results {
      id
      name
      status
      species
      gender
      image
      location{
        name
      }
      origin{
        name
      }
    }
  }
}""";

    return ApiClient()
        .dioLink()
        .request(
            Request(operation: Operation(document: gql.parseString(query))))
        .map((response) {
      return BaseResponse(
          data: CharacterData.fromJson(response.data), success: true);
    }).onErrorResume((error, stack) {
      return Stream.error(_getErrorObject(error));
    });
  }

  /// Parses the response to get the error object if any
  /// from the API response based on status code.
  AppException _getErrorObject(error) {
    try {
      if (error is DioLinkUnkownException) {
        DioLinkUnkownException exception = error;
        d.DioError dioError = exception.originalException;
        // If error is DioError i.e http exception, we
        // should parse the exact message instead of
        // returning the HTTP Status code and standard message.

        // Check if error is of time out error
        if (dioError.type == d.DioErrorType.sendTimeout ||
            dioError.type == d.DioErrorType.connectTimeout ||
            dioError.type == d.DioErrorType.receiveTimeout) {
          return ServerConnectionException(
              'Couldn\'t connect with server. Please try again.');
        }

        // Check if the error is regarding no internet connection.
        if (dioError.type == d.DioErrorType.other &&
            dioError.error is SocketException) {
          return NoInternetException();
        }
      }
      // We are here that means the error wasn't http exception.
      // This could be any un-handled exception from server.
      // In this case, instead of showing weird errors to users
      // like bad response or internal server error, show him
      // a generic message.
      return AppException(kSomethingWentWrongMessage);
    } on Exception catch (e) {
      LogsUtil.instance.printLog(e.toString());
      return AppException(kSomethingWentWrongMessage);
    }
  }
}
