import 'package:get/get.dart';
import 'package:go_weather/data/models/api_response.dart';

class HttpProvider extends GetConnect {
  Future<ApiResponse> getRequest(
      {required url, Map<String, dynamic>? params}) async {
    Response response;

    try {
      response = await get(
        url,
      );

      if (response.body != null) {
        return ApiResponse(
          status: response.status,
          message: response.statusText,
          data: response.body,
          statusCode: response.statusCode,
        );
      } else {
        return ApiResponse(
          status: response.status,
          message: response.statusText,
          data: {},
          error: response.statusText,
          statusCode: response.statusCode,
        );
      }
    } on Exception {
      return ApiResponse(
          status: "error",
          message: "Something went wrong",
          data: {},
          error: 400,
          statusCode: 400);
    }
  }
}
