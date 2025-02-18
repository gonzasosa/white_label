import 'package:equatable/equatable.dart';

/// {@template course}
/// A course.
/// {@endtemplate}
class Course extends Equatable {
  /// {@macro course}
  const Course({
    required this.id,
    required this.name,
    required this.description,
  });

  /// The course's ID.
  final String id;

  /// The course's name.
  final String name;

  /// The course's description.
  final String description;

  @override
  List<Object?> get props => [id, name, description];
}
