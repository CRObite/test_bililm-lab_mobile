import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:test_bilimlab_project/presentation/AuthorizationPages/LoginPage.dart';
import 'package:test_bilimlab_project/presentation/ResoultPages/ResoultPage.dart';
import 'package:test_bilimlab_project/presentation/SubjectPickerPages/SubjectPickerPage.dart';
import 'package:test_bilimlab_project/presentation/TestPages/TestPage.dart';

import 'domain/testSubject.dart';



Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  ByteData data = await PlatformAssetBundle().load('certificates/bilim-lab_kz.crt');
  SecurityContext.defaultContext.setTrustedCertificatesBytes(data.buffer.asUint8List());
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final Map<String, WidgetBuilder> routes = {
    '/': (context) => const LoginPage(),
    '/subject': (context) => const SubjectPickerPage(),
    '/test': (context){
      final testSubjects = ModalRoute.of(context)!.settings.arguments as List<TestSubject>;
      return TestPage(testSubjects: testSubjects);
    },
    '/result': (context) {
      final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

      if (arguments != null) {
        final subjects = arguments['subjects'] as List<String>? ?? [];
        final scores = arguments['scores'] as List<int>? ?? [];
        return ResultPage(subjects: subjects, scores: scores);
      } else {
        return Container();
      }
    }

  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: routes,
    );
  }
}

