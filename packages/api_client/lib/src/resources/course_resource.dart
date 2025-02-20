import 'package:equatable/equatable.dart';
import 'package:http/http.dart';

/// {@template course_exception}
/// Base class for all course exceptions.
/// {@endtemplate}
abstract class CourseException extends Equatable implements Exception {
  /// {@macro course_exception}
  const CourseException({
    required this.error,
    required this.stackTrace,
  });

  /// The underlying error.
  final Object error;

  /// The stack trace.
  final StackTrace stackTrace;

  @override
  List<Object?> get props => [error, stackTrace];
}

/// {@template post_comment_failure}
/// Exception thrown when a comment fails to post.
/// {@endtemplate}
class PostCommentFailure extends CourseException {
  /// {@macro post_comment_failure}
  const PostCommentFailure({
    required super.error,
    required super.stackTrace,
  });
}

/// {@template course_resource}
/// Course resource.
/// {@endtemplate}
class CourseResource {
  /// {@macro course_resource}
  CourseResource({required String baseUrl, required Client client})
      : _baseUrl = baseUrl,
        _client = client;

  final String _baseUrl;
  final Client _client;

  /// Post a comment to a course.
  ///
  /// Throws a [PostCommentFailure] if the comment fails to post.
  Future<void> postComment({
    required String courseId,
    required String comment,
  }) async {
    try {
      await _client.post(
        Uri.parse('$_baseUrl/course/$courseId/comments'),
        body: {
          'comment': comment,
        },
      );
    } catch (error, stackTrace) {
      throw PostCommentFailure(
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
}
