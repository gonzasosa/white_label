part of 'add_course_bloc.dart';

abstract class AddCourseEvent extends Equatable {
  const AddCourseEvent();
}

class AddCourseNameChanged extends AddCourseEvent {
  const AddCourseNameChanged(this.name);

  final String name;

  @override
  List<Object?> get props => [name];
}

class AddCourseDescripionChanged extends AddCourseEvent {
  const AddCourseDescripionChanged(this.description);

  final String description;

  @override
  List<Object?> get props => [description];
}

class AddCourseSubmitted extends AddCourseEvent {
  const AddCourseSubmitted();

  @override
  List<Object?> get props => [];
}
