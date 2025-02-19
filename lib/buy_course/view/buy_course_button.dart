import 'package:api_client/api_client.dart';
import 'package:courses_repository/courses_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:white_label/buy_course/buy_course.dart';

class BuyCourseButton extends StatelessWidget {
  const BuyCourseButton({
    super.key,
    required this.course,
  });

  final Course course;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return BuyCourseBloc(
          course: course,
          coursesRepository: context.read<CoursesRepository>(),
        );
      },
      child: Builder(builder: (context) {
        return TextButton(
          onPressed: () {
            context.read<BuyCourseBloc>().add(const BuyCourseSubmitted());
          },
          child: const Text('BUY'),
        );
      }),
    );
  }
}
