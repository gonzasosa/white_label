part of 'add_course_bloc.dart';

enum AddCourseStatus {
  initial,
  loading,
  success,
  failure;

  bool get isInitial => this == initial;
  bool get isLoading => this == loading;
  bool get isSuccess => this == success;
  bool get isFailure => this == failure;
}

final class AddCourseState extends Equatable {
  const AddCourseState({
    required this.name,
    required this.description,
    required this.status,
  });

  const AddCourseState.initial()
      : this(
          name: '',
          description: '',
          status: AddCourseStatus.initial,
        );

  final String name;
  final String description;
  final AddCourseStatus status;

  @override
  List<Object?> get props => [name, description, status];

  AddCourseState copyWith({
    String? name,
    String? description,
    AddCourseStatus? status,
  }) {
    return AddCourseState(
      name: name ?? this.name,
      description: description ?? this.description,
      status: status ?? this.status,
    );
  }
}
