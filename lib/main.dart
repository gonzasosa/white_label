import 'package:api_client/api_client.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:courses_repository/courses_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
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
    baseUrl: 'http://127.0.0.1:5001',
    client: Client(),
  );
  final coursesRepository = CoursesRepository(
    functions: functions,
    firestore: firestore,
    apiClient: apiClient,
  );
  // const course = Course(
  //   name: 'Name',
  //   description: 'Description',
  // );
  // final courseId = await coursesRepository.addCourse(course);
  // await coursesRepository.buyCourse(courseId);

  runApp(
    MyApp(
      coursesRepository: coursesRepository,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.coursesRepository,
  });

  final CoursesRepository coursesRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(
        title: 'Learnie',
        coursesRepository: coursesRepository,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
    required this.coursesRepository,
  });

  final String title;
  final CoursesRepository coursesRepository;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder<List<Course>>(
          future: widget.coursesRepository.fetchCourses(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final courses = snapshot.data ?? <Course>[];
              return ListView.builder(
                itemCount: courses.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(courses[index].name),
                    subtitle: Text(courses[index].description),
                  );
                },
              );
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'You have pushed the button this many times:',
                ),
                Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
