part of 'buy_course_bloc.dart';

abstract class BuyCourseEvent extends Equatable {
  const BuyCourseEvent();
}

class BuyCourseSubmitted extends BuyCourseEvent {
  const BuyCourseSubmitted();

  @override
  List<Object?> get props => [];
}
