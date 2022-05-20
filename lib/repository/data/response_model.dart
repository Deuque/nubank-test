import 'package:http/http.dart';

abstract class ResponseModel {}

class SuccessResponse<T> extends ResponseModel {
  final T value;

  SuccessResponse(this.value);
}

class ErrorResponse extends ResponseModel {
  final String error;

  ErrorResponse(this.error);
}

abstract class HttpCaller {
  static Future<ResponseModel> makeCall({
    required Future<Response> Function() call,
    required ResponseModel Function(String, int) onError,
    required ResponseModel Function(Response) onSuccess,
    int successCode = 200,
  }) async {
    try {
      Response response = await call();
      if (response.statusCode == successCode) {
        return onSuccess(response);
      } else {
        return onError(response.body, response.statusCode);
      }
    } catch (e) {
      return onError(e.toString(), 404);
    }
  }
}
