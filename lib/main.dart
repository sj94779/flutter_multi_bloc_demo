import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_bloc_demo/repo/repositories.dart';
import 'package:flutter_multi_bloc_demo/screens/home_screen.dart';
import 'package:flutter_multi_bloc_demo/screens/homepage.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Multi Bloc Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: RepositoryProvider(

          create: (context) => UserRepository(),
          child: const HomeScreen()),
    );
  }
}


