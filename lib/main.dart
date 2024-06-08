// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:evaluvation_application/navigations/side_bar.dart';
import 'package:evaluvation_application/pages/home_page.dart';
import 'package:evaluvation_application/pages/login_page.dart';
import 'package:evaluvation_application/pages/settings.dart';
import 'package:evaluvation_application/pages/split_page.dart';
import 'package:evaluvation_application/pages/support_chat.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

void main() async {
  initLocalStorage();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const HomePage(),
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/login': (context) => const LoginPage(),
        '/settings': (context) => const SettingsPage(),
        '/home': (context) => const HomePage(),
        '/chat': (context) => const SupportChatPage(),
        '/side_bar': (context) => const SideBarNavigation(),
        '/split_page': (context) => SplitPage(
              selectedPath: '/',
              requirments: [],
            ),
        // When navigating to the "/second" route, build the SecondScreen widget.
      },
    );
  }
}
