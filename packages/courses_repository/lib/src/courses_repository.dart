import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courses_repository/src/models/course.dart';

/// {@template courses_repository}
/// A repository for managing courses.
/// {@endtemplate}
class CoursesRepository {
  /// {@macro courses_repository}
  CoursesRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Course> get _courses {
    return _firestore.collection('courses').withConverter(
      fromFirestore: (snapshot, options) {
        final data = snapshot.data()!;
        return Course(
          id: snapshot.id,
          name: data['name'] as String,
          description: data['description'] as String,
        );
      },
      toFirestore: (course, options) {
        return {
          'name': course.name,
          'description': course.description,
        };
      },
    );
  }

  /// Adds a new [course].
  Future<void> addCourse(Course course) {
    return _courses.add(course);
  }

  /// Returns a list of courses.
  Future<List<Course>> fetchCourses() {
    return _courses.get().then(
          (snapshot) => snapshot.docs.map((doc) => doc.data()).toList(),
        );
  }
}
