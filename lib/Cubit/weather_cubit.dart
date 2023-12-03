import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:weatherapp/Shared/Local/constants.dart';
import 'package:weatherapp/Shared/Network/Dio_helper.dart';

import '../Models/weather_model.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherInitial());

  static WeatherCubit get(context) => BlocProvider.of(context);

  Position? finalCurrentPosition;

  Future<void> getCurrentLocation() async {
    emit(GetWeatherByLatLongLoading());
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      print("service is not enabled");
      emit(GetLocationServiceFail());
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied');
        emit(GetLocationServiceFail());
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print(
          'Location permissions are permanently denied, we cannot request permissions.');
      emit(GetLocationServiceFail());
    }
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      finalCurrentPosition = await Geolocator.getCurrentPosition();
      emit(GetLocationServiceSucceed());
    }
  }

  WeatherModel? weatherModel;

  void getWeatherDataByCityName(String cityName) async {
    emit(GetWeatherByCityNameLoading());
    DioHelper.getData(url: Constants.cityNameApiCall(cityName)).then((value) {
      weatherModel = WeatherModel.fromJson(value?.data);
      print("--------------------------------");
      print(weatherModel?.cityName);
      print(weatherModel?.countryName);
      print(weatherModel?.temp);
      print("--------------------------------");
      emit(GetWeatherByCityNameSucceed());
    }).catchError((error) {
      print("error in getWeatherDataByCityName (function in weather cubit)");
      print(error);
      emit(GetWeatherByCityNameFail());
    });
  }

  void getWeatherDataByLongLat() async {
    await getCurrentLocation();

    DioHelper.getData(
            url: Constants.latLongApiCall(
                finalCurrentPosition!.latitude.toString(),
                finalCurrentPosition!.longitude.toString()))
        .then((value) {
      weatherModel = WeatherModel.fromJson(value?.data);
      print("--------------------------------");
      print(weatherModel?.cityName);
      print(weatherModel?.temp);
      print("--------------------------------");
      emit(GetWeatherByLatLongSucceed());
    }).catchError((error) {
      print("error in getWeatherDataByLongLat (function in weather cubit)");
      print(error);
      emit(GetWeatherByLatLongFail());
    });
  }
}
