class ApiResponse {
  dynamic status;
  dynamic statusCode;
  String? message;
  dynamic error;
  dynamic data;

  ApiResponse(
      {this.status, this.message, this.data, this.error, this.statusCode});
}
