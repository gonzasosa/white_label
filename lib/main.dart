import 'package:api_client/api_client.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:courses_repository/courses_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:white_label/add_course/add_course.dart';
import 'package:white_label/buy_course/view/buy_course_button.dart';
import 'package:white_label/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final functions = FirebaseFunctions.instance;
  functions.useFunctionsEmulator('localhost', 5001);

  final firestore = FirebaseFirestore.instance;
  firestore.settings = const Settings(
    persistenceEnabled: false,
    host: 'localhost:8080',
    sslEnabled: false,
  );
  firestore.useFirestoreEmulator('localhost', 8080);

  final apiClient = ApiClient(
    baseUrl: 'localhost:5001',
    client: Client(),
  );
  final coursesRepository = CoursesRepository(
    functions: functions,
    firestore: firestore,
    apiClient: apiClient,
  );

  runApp(
    App(
      coursesRepository: coursesRepository,
    ),
  );
}

class App extends StatelessWidget {
  const App({
    super.key,
    required this.coursesRepository,
  });

  final CoursesRepository coursesRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: coursesRepository,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: CoursesListView(
          title: 'Learnie',
          coursesRepository: coursesRepository,
        ),
      ),
    );
  }
}

class CoursesListView extends StatelessWidget {
  const CoursesListView({
    super.key,
    required this.title,
    required this.coursesRepository,
  });

  final String title;
  final CoursesRepository coursesRepository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: FutureBuilder<List<Course>>(
          future: coursesRepository.fetchCourses(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else {
              final courses = snapshot.data ?? <Course>[];
              return ListView.builder(
                itemCount: courses.length,
                itemBuilder: (context, index) {
                  final course = courses[index];
                  return ListTile(
                    title: Text(course.name),
                    subtitle: Text(course.description),
                    trailing: BuyCourseButton(
                      course: course,
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(AddCoursePage.route());
        },
        tooltip: 'Add Course',
        child: const Icon(Icons.add),
      ),
    );
  }
}
