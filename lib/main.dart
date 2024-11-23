import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'utils/app_colors.dart';
import 'utils/global.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    Root(),
  );
}

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    Constants.width = MediaQuery.sizeOf(context).width;
    Constants.height = MediaQuery.sizeOf(context).height;
    return GetMaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.backgroundColor,
        splashColor: AppColors.transparent,
        highlightColor: AppColors.transparent,
        hoverColor: AppColors.transparent,
      ),
      debugShowCheckedModeBanner: false,
      title: "Study Material",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
