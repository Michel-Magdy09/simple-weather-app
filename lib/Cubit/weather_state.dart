part of 'weather_cubit.dart';

@immutable
abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class GetLocationServiceSucceed extends WeatherState {}

class GetLocationServiceFail extends WeatherState {}

class GetWeatherByCityNameLoading extends WeatherState {}

class GetWeatherByCityNameFail extends WeatherState {}

class GetWeatherByCityNameSucceed extends WeatherState {}

class GetWeatherByLatLongLoading extends WeatherState {}

class GetWeatherByLatLongSucceed extends WeatherState {}

class GetWeatherByLatLongFail extends WeatherState {}
