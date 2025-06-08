class ApiResponseModel<T> {
  final T data;
  final dynamic status; 
  ApiResponseModel({required this.data, required this.status});

  factory ApiResponseModel.fromJson(Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonT) {
    return ApiResponseModel(
      data: fromJsonT(json['data']),
      status: json['status'],
    );
  }
}