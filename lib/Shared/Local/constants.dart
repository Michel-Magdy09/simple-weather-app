class Constants {
  static String baseUrl = "https://api.openweathermap.org/data/2.5/weather";
  static String apiKey = "57a515b95e9d3c778eec42f3d22ede21";

  //https://api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}
  static String cityNameApiCall(String cityname) =>
      "$baseUrl?q=$cityname&appid=$apiKey&units=metric";

  //https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}
  static String latLongApiCall(String lat, String long) =>
      "$baseUrl?lat=$lat&lon=$long&appid=$apiKey&units=metric";
}
