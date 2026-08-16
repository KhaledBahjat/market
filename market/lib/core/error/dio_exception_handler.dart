

import 'package:dio/dio.dart';
import 'package:market/core/error/failure.dart';

class DioExceptionHandler {
  static Failure handle(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return const ServerFailure(
          'The connection took too long. Please try again.',
        );

      case DioExceptionType.sendTimeout:
        return const ServerFailure(
          'Unable to send your request. Please try again.',
        );

      case DioExceptionType.receiveTimeout:
        return const ServerFailure(
          'The server is taking too long to respond. Please try again.',
        );

      case DioExceptionType.badCertificate:
        return const ServerFailure(
          'Secure connection could not be established.',
        );

      case DioExceptionType.badResponse:
        return _handleStatusCode(e.response?.statusCode);

      case DioExceptionType.cancel:
        return const ServerFailure(
          'The request was cancelled.',
        );

      case DioExceptionType.connectionError:
        return const ServerFailure(
          'Please check your internet connection and try again.',
        );

      case DioExceptionType.transformTimeout:
        return const ServerFailure(
          'Something went wrong while processing the data.',
        );

      case DioExceptionType.unknown:
        return const ServerFailure(
          'Something went wrong. Please try again.',
        );
    }
  }

  static Failure _handleStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return const ServerFailure(
          'The request could not be processed. Please check your information.',
        );

      case 401:
        return const ServerFailure(
          'Your session has expired. Please sign in again.',
        );

      case 403:
        return const ServerFailure(
          'You don’t have permission to perform this action.',
        );

      case 404:
        return const ServerFailure(
          'The requested information could not be found.',
        );

      case 408:
        return const ServerFailure(
          'The request took too long. Please try again.',
        );

      case 409:
        return const ServerFailure(
          'This action conflicts with existing data.',
        );

      case 422:
        return const ServerFailure(
          'Some of the information you entered is not valid.',
        );

      case 429:
        return const ServerFailure(
          'Too many requests. Please wait a moment and try again.',
        );

      case 500:
        return const ServerFailure(
          'Something went wrong on our server. Please try again later.',
        );

      case 502:
        return const ServerFailure(
          'The server is temporarily unavailable. Please try again later.',
        );

      case 503:
        return const ServerFailure(
          'The service is temporarily unavailable. Please try again later.',
        );

      case 504:
        return const ServerFailure(
          'The server took too long to respond. Please try again later.',
        );

      default:
        return const ServerFailure(
          'Something went wrong. Please try again later.',
        );
    }
  }
}