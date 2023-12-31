import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:test_bilimlab_project/config/dependency_injection.dart';

import 'package:test_bilimlab_project/presentation/AuthorizationPages/LoginPage.dart';
import 'package:test_bilimlab_project/presentation/ErrorWorksPages/ErrorWorkTestPage.dart';
import 'package:test_bilimlab_project/presentation/ResoultPages/ResoultPage.dart';
import 'package:test_bilimlab_project/presentation/SubjectPickerPages/SubjectPickerPage.dart';
import 'package:test_bilimlab_project/presentation/TestPages/TestPage.dart';
import 'package:test_bilimlab_project/presentation/UserPages/UserPage.dart';
import 'package:test_bilimlab_project/presentation/application.dart';
import 'package:test_bilimlab_project/utils/TestFormatEnum.dart';

import 'domain/result.dart';
import 'domain/test.dart';




Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  ByteData data = await PlatformAssetBundle().load('certificates/oqutest_kz.crt');
  SecurityContext.defaultContext.setTrustedCertificatesBytes(data.buffer.asUint8List());
  ByteData secondCertData = await PlatformAssetBundle().load('certificates/_oquway_kz.crt');
  SecurityContext.defaultContext.setTrustedCertificatesBytes(secondCertData.buffer.asUint8List());


  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,]);
  runApp(const MyApp());

  DependencyInjection.init();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final Map<String, WidgetBuilder> routes = {

    '/': (context) => const LoginPage(),
    '/app': (context) => const Application(),
    '/subject': (context) => const SubjectPickerPage(),
    '/test': (context) {
      final Map<String, dynamic>? arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

      if (arguments != null) {
        final Test test = arguments['test'] as Test;
        final TestFormatEnum testFormatEnum = arguments['testFormatEnum'] as TestFormatEnum;

        return TestPage(test: test, format: testFormatEnum);
      } else {
        return Container();
      }
    },
    '/mistake': (context) {
      final Map<String, dynamic>? arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

      if (arguments != null) {
        final Test test = arguments['test'] as Test;
        final TestFormatEnum testFormatEnum = arguments['testFormatEnum'] as TestFormatEnum;

        return ErrorWorkTestPage(test: test, format: testFormatEnum);
      } else {
        return Container();
      }
    },

    '/result': (context) {
      final Map<String, dynamic>? arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

      if (arguments != null) {
        final Result result = arguments['result'] as Result;
        final TestFormatEnum testFormatEnum = arguments['testFormatEnum'] as TestFormatEnum;

        return ResultPage(result: result, format: testFormatEnum);
      } else {
        return Container();
      }
    },
    '/user': (context) => const UserPage(),

  };

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: routes,
    );
  }
}

