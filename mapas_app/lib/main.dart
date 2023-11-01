import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapas_app/blocs/gps/gps_bloc.dart';
import 'package:mapas_app/screens/gps_access_screen.dart';
import 'package:mapas_app/screens/screens.dart';

void main() {
  runApp(MultiBlocProvider(
      providers: [BlocProvider(create: (context) => GpsBloc())],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Maps App',
      home: LoadingScreen(),
    );
  }
}
