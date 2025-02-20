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
      final firestore = FirebaseFirestore.instance;
      final apiClient = ApiClient(
        baseUrl: 'https://us-central1-white-label-caa9b.cloudfunctions.net/api',
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
