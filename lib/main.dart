import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:test_bilimlab_project/config/dependency_injection.dart';

import 'package:test_bilimlab_project/presentation/AuthorizationPages/LoginPage.dart';
import 'package:test_bilimlab_project/presentation/ResoultPages/ResoultPage.dart';
import 'package:test_bilimlab_project/presentation/SubjectPickerPages/SubjectPickerPage.dart';
import 'package:test_bilimlab_project/presentation/TestPages/TestPage.dart';
import 'package:test_bilimlab_project/utils/TestFormatEnum.dart';

import 'domain/result.dart';
import 'domain/test.dart';




Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  ByteData data = await PlatformAssetBundle().load('certificates/bilim-lab_kz.crt');
  SecurityContext.defaultContext.setTrustedCertificatesBytes(data.buffer.asUint8List());
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
    '/result': (context) {
      final result = ModalRoute.of(context)!.settings.arguments as Result;
      return ResultPage(result: result);
    }

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

