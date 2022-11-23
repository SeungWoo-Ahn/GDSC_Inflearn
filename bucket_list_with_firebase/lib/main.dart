import 'package:bucket_list_with_firebase/controller/auth_controller.dart';
import 'package:bucket_list_with_firebase/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // main 함수에서 async 사용하기 위함
  await firebaseInitialization.then((value) => {
        Get.put(AuthController()),
      });
  runApp(BucketApp());
}

class BucketApp extends StatelessWidget {
  const BucketApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
