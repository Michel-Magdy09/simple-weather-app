import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/Cubit/weather_cubit.dart';
import 'package:weatherapp/Shared/Network/Dio_helper.dart';

import 'Screens/home_screen_design.dart';

void main() {
  DioHelper.init();
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherCubit()..getWeatherDataByLongLat(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen1(),
      ),
    );
  }
}
