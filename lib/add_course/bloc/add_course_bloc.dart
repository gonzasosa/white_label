import 'dart:async';

import 'package:api_client/api_client.dart';
import 'package:courses_repository/courses_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_course_event.dart';
part 'add_course_state.dart';

class AddCourseBloc extends Bloc<AddCourseEvent, AddCourseState> {
  AddCourseBloc({required CoursesRepository coursesRepository})
      : _coursesRepository = coursesRepository,
        super(const AddCourseState.initial()) {
    on<AddCourseNameChanged>(_onAddCourseNameChanged);
    on<AddCourseDescripionChanged>(_onAddCourseDescripionChanged);
    on<AddCourseSubmitted>(_onAddCourseSubmitted);
  }

  final CoursesRepository _coursesRepository;

  void _onAddCourseNameChanged(
    AddCourseNameChanged event,
    Emitter<AddCourseState> emit,
  ) {
    emit(state.copyWith(name: event.name));
  }

  void _onAddCourseDescripionChanged(
    AddCourseDescripionChanged event,
    Emitter<AddCourseState> emit,
  ) {
    emit(state.copyWith(description: event.description));
  }

  Future<void> _onAddCourseSubmitted(
    AddCourseSubmitted event,
    Emitter<AddCourseState> emit,
  ) async {
    try {
      emit(state.copyWith(status: AddCourseStatus.loading));
      await _coursesRepository.addCourse(
        Course(
          name: state.name,
          description: state.description,
        ),
      );
      emit(state.copyWith(status: AddCourseStatus.success));
    } catch (_) {
      emit(state.copyWith(status: AddCourseStatus.failure));
    }
  }
}
