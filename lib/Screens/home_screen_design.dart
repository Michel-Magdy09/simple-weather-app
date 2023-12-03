import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/Cubit/weather_cubit.dart';

class HomeScreen1 extends StatelessWidget {
  HomeScreen1({Key? key}) : super(key: key);
  TextEditingController cityName = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WeatherCubit, WeatherState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = WeatherCubit.get(context);
        return Scaffold(
          backgroundColor: const Color.fromRGBO(92, 148, 206, 1.0),
          appBar: AppBar(
            title: const Text("Weather App"),
            centerTitle: true,
            leading: const Icon(Icons.menu),
            actions: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.settings),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                    onTap: () {
                      cubit.getWeatherDataByLongLat();
                    },
                    child: const Icon(Icons.location_on)),
              ),
            ],
            elevation: 0.0,
            backgroundColor: const Color.fromRGBO(99, 146, 244, 1.0),
          ),
          body: Stack(
            children: [
              Container(
                height: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/sunny (1).jpg"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, top: 20),
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: cityName,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 3,
                                      color: Color.fromRGBO(99, 146, 244, 1.0)),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 3,
                                      color: Color.fromRGBO(99, 146, 244, 1.0)),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 3,
                                      color: Color.fromRGBO(99, 146, 244, 1.0)),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                suffixIcon: InkWell(
                                  onTap: () {
                                    cubit.getWeatherDataByCityName(
                                        cityName.text.toString());
                                    cityName.text = "";
                                  },
                                  child: const Icon(
                                    Icons.send,
                                    color: Colors.black,
                                  ),
                                )),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Center(
                              child: cubit.weatherModel != null &&
                                      cubit.weatherModel != null
                                  ? Text(
                                      "${cubit.weatherModel?.cityName} , ${cubit.weatherModel?.countryName}",
                                      style: const TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    )
                                  : const Text("Location is Not Specified",
                                      style: TextStyle(fontSize: 25))),
                          Center(
                            child: cubit.weatherModel != null
                                ? Text(
                                    "${cubit.weatherModel?.temp}",
                                    style: const TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  )
                                : const Text("Enter Location",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold)),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          cubit.weatherModel != null
                              ? Container(
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(120, 208, 248, 1.0),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    children: [
                                      Text(
                                        "temp: ${cubit.weatherModel?.temp}",
                                        style: const TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "main: ${cubit.weatherModel?.main}",
                                        style: const TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "description: ${cubit.weatherModel?.description}",
                                        style: const TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "feelsLike: ${cubit.weatherModel?.feelsLike}",
                                        style: const TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "tempMin: ${cubit.weatherModel?.tempMin}",
                                        style: const TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "tempMax: ${cubit.weatherModel?.tempMax}",
                                        style: const TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "pressure: ${cubit.weatherModel?.pressure}",
                                        style: const TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "humidity: ${cubit.weatherModel?.humidity}",
                                        style: const TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                )
                              : const Column(
                                  children: [
                                    Center(child: CircularProgressIndicator())
                                  ],
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
