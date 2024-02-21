import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'page/home_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                fontFamily: 'Sixtyfour',
                brightness: Brightness.dark,
                scaffoldBackgroundColor: Colors.grey.shade400,
                primaryColor: Colors.cyan.shade400,
                textTheme:
                    Typography.englishLike2018.apply(fontSizeFactor: 1.sp)),
            home: child);
      },
      child: const HomePage(),
    );
  }
}
