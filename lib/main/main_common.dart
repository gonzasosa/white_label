import 'package:api_client/api_client.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:courses_repository/courses_repository.dart';
import 'package:flutter/material.dart';
import 'package:white_label/app/app.dart';

Future<Widget> mainCommon({
  required FirebaseFirestore firestore,
  required FirebaseFunctions functions,
  required ApiClient apiClient,
}) async {
  final courseRepository = CoursesRepository(
    apiClient: apiClient,
    firestore: firestore,
    functions: functions,
  );
  return App(
    coursesRepository: courseRepository,
  );
}
