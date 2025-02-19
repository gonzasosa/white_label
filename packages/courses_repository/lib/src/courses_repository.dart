import 'package:api_client/api_client.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';

/// {@template courses_repository}
/// A repository for managing courses.
/// {@endtemplate}
class CoursesRepository {
  /// {@macro courses_repository}
  CoursesRepository({
    required ApiClient apiClient,
    required FirebaseFirestore firestore,
    required FirebaseFunctions functions,
  })  : _apiClient = apiClient,
        _firestore = firestore,
        _functions = functions;

  final ApiClient _apiClient;
  final FirebaseFirestore _firestore;
  final FirebaseFunctions _functions;

  /// Adds a new [course] and returns the ID.
  Future<String> addCourse(Course course) async {
    final ref = await _firestore.collection('courses').add({
      'id': '1',
      'name': course.name,
      'description': course.description,
    });
    await ref.update({'id': ref.id});
    return ref.id;
  }

  /// Returns a list of courses.
  Future<List<Course>> fetchCourses() async {
    final response = await _firestore.collection('courses').get();
    return response.docs.map<Course>((doc) {
      final data = doc.data();
      return Course(
        id: doc.id,
        name: data['name'] as String,
        description: data['description'] as String,
      );
    }).toList();
  }

  /// Adds a new [comment] to a course with the given [courseId].
  ///
  /// Throws a [PostCommentFailure] if the comment fails to post.
  Future<void> addComment({
    required String courseId,
    required String comment,
  }) {
    return _apiClient.courseResource.postComment(
      courseId: courseId,
      comment: comment,
    );
  }

  /// Buys a course with the given [courseId].
  Future<void> buyCourse(String courseId) async {
    await _functions
        .httpsCallable('buyCourse')
        .call<void>({'courseId': courseId});
  }
}
