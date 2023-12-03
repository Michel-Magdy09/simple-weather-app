import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/Cubit/weather_cubit.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  TextEditingController cityName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather APP"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Current Weather of my Location",
              style: TextStyle(fontSize: 25),
            ),
            const SizedBox(
              height: 10,
            ),
            BlocConsumer<WeatherCubit, WeatherState>(
              listener: (context, state) {},
              builder: (context, state) {
                var cubit = WeatherCubit.get(context);
                if (state is GetWeatherByLatLongFail) {
                  return const Text(
                    "No location",
                  );
                } else if (state is GetWeatherByLatLongSucceed) {
                  return Text(
                      "weather city name: ${cubit.weatherModel?.cityName}, temp: ${cubit.weatherModel?.temp}");
                } else if (state is GetWeatherByLatLongLoading) {
                  return CircularProgressIndicator();
                } else {
                  return Text("");
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            BlocConsumer<WeatherCubit, WeatherState>(
              listener: (context, state) {},
              builder: (context, state) {
                print("Get weather of my Location: ${state}");
                var cubit = WeatherCubit.get(context);
                return ElevatedButton(
                    onPressed: () {
                      cubit.getWeatherDataByLongLat();
                    },
                    child: const Text("Get weather of my Location"));
              },
            ),
            TextFormField(
              controller: cityName,
            ),
            BlocConsumer<WeatherCubit, WeatherState>(
              listener: (context, state) {},
              builder: (context, state) {
                var cubit = WeatherCubit.get(context);
                return ElevatedButton(
                    onPressed: () {
                      cubit.getWeatherDataByCityName(cityName.text.toString());
                    },
                    child: const Text("Get weather of City"));
              },
            ),
            BlocConsumer<WeatherCubit, WeatherState>(
              listener: (context, state) {},
              builder: (context, state) {
                var cubit = WeatherCubit.get(context);
                if (state is GetWeatherByCityNameFail) {
                  return const Text("city name is wrong");
                } else if (state is GetWeatherByCityNameSucceed) {
                  return Text(cubit.weatherModel!.cityName);
                } else if (state is GetWeatherByCityNameLoading) {
                  return const CircularProgressIndicator();
                } else {
                  return const Text("");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
