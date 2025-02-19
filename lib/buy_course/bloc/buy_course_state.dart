part of 'buy_course_bloc.dart';

enum BuyCourseStatus {
  initial,
  loading,
  success,
  failure;

  bool get isInitial => this == initial;
  bool get isLoading => this == loading;
  bool get isSuccess => this == success;
  bool get isFailure => this == failure;
}

final class BuyCourseState extends Equatable {
  const BuyCourseState({
    required this.course,
    required this.status,
  });

  final Course course;
  final BuyCourseStatus status;

  @override
  List<Object?> get props => [course, status];

  BuyCourseState copyWith({BuyCourseStatus? status}) {
    return BuyCourseState(
      course: course,
      status: status ?? this.status,
    );
  }
}
