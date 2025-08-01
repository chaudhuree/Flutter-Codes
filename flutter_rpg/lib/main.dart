import 'package:flutter/material.dart';
import 'package:flutter_rpg/screens/create/create.dart';
// import 'package:flutter_rpg/screens/home/home.dart';
import 'package:flutter_rpg/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          theme: primaryTheme,
          debugShowCheckedModeBanner: false,
          home: const Create(),
        );
      },
    ),
  );
}

class Sandbox extends StatelessWidget {
  const Sandbox({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sandbox"), centerTitle: true),
      body: const Center(child: Text("Sandbox")),
    );
  }
}

// stl = stateless widget
// stf = stateful widget
// flutter pub get
