class Weather {
  final String cityName;
  final double temparatuer;
  final String mainConditions;

  Weather({
    required this.cityName,
    required this.temparatuer,
    required this.mainConditions,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temparatuer: json['main']['temp'].toDouble(),
      mainConditions: json['weather'][0]['main'],
    );
  }
}
