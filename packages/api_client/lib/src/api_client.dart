import 'package:api_client/api_client.dart';
import 'package:http/http.dart';

/// {@template api_client}
/// Client for making API requests.
/// {@endtemplate}
class ApiClient {
  /// {@macro api_client}
  ApiClient({
    required String baseUrl,
    required Client client,
  }) : _courseResource = CourseResource(
          baseUrl: baseUrl,
          client: client,
        );

  final CourseResource _courseResource;

  /// {@macro course_resource}
  CourseResource get courseResource {
    return _courseResource;
  }
}
