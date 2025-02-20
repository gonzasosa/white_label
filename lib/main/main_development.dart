import 'package:api_client/api_client.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:http/http.dart';
import 'package:white_label/firebase_options.dart';
import 'package:white_label/main/bootstrap.dart';
import 'package:white_label/main/main_common.dart';

void main() {
  bootstrap(
    () {
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
        baseUrl: 'http://127.0.0.1:5001/white-label-caa9b/us-central1',
        client: Client(),
      );

      return mainCommon(
        firestore: firestore,
        functions: functions,
        apiClient: apiClient,
      );
    },
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
