import 'package:courses_repository/courses_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:white_label/add_course/add_course.dart';

class AddCoursePage extends StatelessWidget {
  const AddCoursePage({super.key});

  static Route<void> route() {
    return MaterialPageRoute(
      builder: (context) {
        return const AddCoursePage();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddCourseBloc(
        coursesRepository: context.read<CoursesRepository>(),
      ),
      child: const AddCourseView(),
    );
  }
}
