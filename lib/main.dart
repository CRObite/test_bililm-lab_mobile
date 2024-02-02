import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_upgrade_version/flutter_upgrade_version.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:test_bilimlab_project/config/dependency_injection.dart';
import 'package:test_bilimlab_project/config/network_controller.dart';
import 'package:test_bilimlab_project/domain/postItem.dart';
import 'package:test_bilimlab_project/domain/specialization.dart';
import 'package:test_bilimlab_project/domain/universityItem.dart';
import 'package:test_bilimlab_project/presentation/AuthorizationPages/LoginPage.dart';
import 'package:test_bilimlab_project/presentation/AuthorizationPages/PasswordRecoverPage.dart';
import 'package:test_bilimlab_project/presentation/AuthorizationPages/RegisterPage.dart';
import 'package:test_bilimlab_project/presentation/ErrorWorksPages/ErrorWorkTestPage.dart';
import 'package:test_bilimlab_project/presentation/PostPages/InnerPostPage.dart';
import 'package:test_bilimlab_project/presentation/ResoultPages/ResoultPage.dart';
import 'package:test_bilimlab_project/presentation/SubjectPickerPages/SubjectPickerPage.dart';
import 'package:test_bilimlab_project/presentation/TestPages/TestPage.dart';
import 'package:test_bilimlab_project/presentation/UniversityPages/SpecializationPage.dart';
import 'package:test_bilimlab_project/presentation/UniversityPages/UniversityInfoPage.dart';
import 'package:test_bilimlab_project/presentation/UserPages/UserPage.dart';
import 'package:test_bilimlab_project/presentation/application.dart';
import 'package:test_bilimlab_project/utils/TestFormatEnum.dart';

import 'domain/result.dart';
import 'domain/test.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ByteData data =
      await PlatformAssetBundle().load('certificates/oqutest_kz.crt');
  SecurityContext.defaultContext
      .setTrustedCertificatesBytes(data.buffer.asUint8List());
  ByteData secondCertData =
      await PlatformAssetBundle().load('certificates/_oquway_kz.crt');
  SecurityContext.defaultContext
      .setTrustedCertificatesBytes(secondCertData.buffer.asUint8List());

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());

  DependencyInjection.init();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  PackageInfo _packageInfo = PackageInfo();

  @override
  void initState() {
    super.initState();
    getPackageData();
  }

  Future<void> getPackageData() async {
    print('getPackageData started ');
    if (!mounted) return;
    _packageInfo = await PackageManager.getPackageInfo();
    setState(() {});
    print('getPackageData ended ');

    usePackageData();
  }

  Future<void> usePackageData() async {
    print('usePackageData started ');
    if (Platform.isAndroid) {
      InAppUpdateManager manager = InAppUpdateManager();
      AppUpdateInfo? appUpdateInfo = await manager.checkForUpdate();
      if (appUpdateInfo == null) return;
      if (appUpdateInfo.updateAvailability ==
          UpdateAvailability.developerTriggeredUpdateInProgress) {
        String? message =
            await manager.startAnUpdate(type: AppUpdateType.immediate);
        debugPrint(message ?? '');
      } else if (appUpdateInfo.updateAvailability ==
          UpdateAvailability.updateAvailable) {
        if (appUpdateInfo.immediateAllowed) {
          String? message =
              await manager.startAnUpdate(type: AppUpdateType.immediate);
          debugPrint(message ?? '');
        } else if (appUpdateInfo.flexibleAllowed) {
          String? message =
              await manager.startAnUpdate(type: AppUpdateType.flexible);
          debugPrint(message ?? '');
        } else {
          debugPrint(
              'Update available. Immediate & Flexible Update Flow not allow');
        }
      }
    } else if (Platform.isIOS) {
      VersionInfo? _versionInfo = await UpgradeVersion.getiOSStoreVersion(
          packageInfo: _packageInfo, regionCode: "US");
      debugPrint(_versionInfo.toJson().toString());
    }

    print('usePackageData end ');
  }

  final Map<String, WidgetBuilder> routes = {
    '/': (context) => const LoginPage(),
    '/app': (context) => const Application(),
    '/subject': (context) => const SubjectPickerPage(),
    '/test': (context) {
      final Map<String, dynamic>? arguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

      if (arguments != null) {
        final Test test = arguments['test'] as Test;
        final TestFormatEnum testFormatEnum =
            arguments['testFormatEnum'] as TestFormatEnum;

        return TestPage(test: test, format: testFormatEnum);
      } else {
        return Container();
      }
    },
    '/mistake': (context) {
      final Map<String, dynamic>? arguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

      if (arguments != null) {
        final Test test = arguments['test'] as Test;
        final TestFormatEnum testFormatEnum =
            arguments['testFormatEnum'] as TestFormatEnum;

        return ErrorWorkTestPage(test: test, format: testFormatEnum);
      } else {
        return Container();
      }
    },
    '/result': (context) {
      final Map<String, dynamic>? arguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

      if (arguments != null) {
        final Result result = arguments['result'] as Result;
        final TestFormatEnum testFormatEnum =
            arguments['testFormatEnum'] as TestFormatEnum;

        return ResultPage(result: result, format: testFormatEnum);
      } else {
        return Container();
      }
    },
    '/user': (context) => const UserPage(),
    '/recovery': (context) => const PasswordRecoveryPage(),
    '/register': (context) => const RegisterPage(),
    '/university_info': (context) {
      final university =
          ModalRoute.of(context)!.settings.arguments as UniversityItem;
      return UniversityInfoPage(
        university: university,
      );
    },
    '/specialization': (context) {
      final specialization =
          ModalRoute.of(context)!.settings.arguments as Specialization;
      return SpecializationPage(specialization: specialization);
    },
    '/inner_post': (context) {
      final post = ModalRoute.of(context)!.settings.arguments as PostItem;
      return InnerPostPage(post: post);
    },
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
