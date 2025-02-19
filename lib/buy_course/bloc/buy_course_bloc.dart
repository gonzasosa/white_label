import 'dart:async';

import 'package:api_client/api_client.dart';
import 'package:courses_repository/courses_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'buy_course_event.dart';
part 'buy_course_state.dart';

class BuyCourseBloc extends Bloc<BuyCourseEvent, BuyCourseState> {
  BuyCourseBloc({
    required Course course,
    required CoursesRepository coursesRepository,
  })  : _coursesRepository = coursesRepository,
        super(
          BuyCourseState(
            course: course,
            status: BuyCourseStatus.initial,
          ),
        ) {
    on<BuyCourseSubmitted>(_onBuyCourseSubmitted);
  }

  final CoursesRepository _coursesRepository;

  Future<void> _onBuyCourseSubmitted(
    BuyCourseSubmitted event,
    Emitter<BuyCourseState> emit,
  ) async {
    try {
      final course = state.course;
      if (course.id == null) return;
      emit(state.copyWith(status: BuyCourseStatus.loading));
      await _coursesRepository.buyCourse(course.id!);
      emit(state.copyWith(status: BuyCourseStatus.success));
    } catch (_) {
      emit(state.copyWith(status: BuyCourseStatus.failure));
    }
  }
}
