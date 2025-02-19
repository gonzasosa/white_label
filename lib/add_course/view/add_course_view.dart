import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:white_label/add_course/bloc/add_course_bloc.dart';

class AddCourseView extends StatelessWidget {
  const AddCourseView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddCourseBloc, AddCourseState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isSuccess) {
          Navigator.of(context).pop();
        }
      },
      child: const Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              _CourseNameTextField(),
              SizedBox(height: 24),
              _CourseDescriptionTextField(),
              SizedBox(height: 48),
              _AddCourseSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _CourseNameTextField extends StatelessWidget {
  const _CourseNameTextField();

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (name) {
        context.read<AddCourseBloc>().add(AddCourseNameChanged(name));
      },
    );
  }
}

class _CourseDescriptionTextField extends StatelessWidget {
  const _CourseDescriptionTextField();

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (description) {
        context
            .read<AddCourseBloc>()
            .add(AddCourseDescripionChanged(description));
      },
    );
  }
}

class _AddCourseSubmitButton extends StatelessWidget {
  const _AddCourseSubmitButton();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<AddCourseBloc>().add(const AddCourseSubmitted());
      },
      child: const Text('Submit'),
    );
  }
}
