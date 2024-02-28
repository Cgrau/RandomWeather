import Foundation

struct WeatherModel {
   let city: String
   let country: String?
   let coordinates: CoordinatesModel
   let weather: [WeatherInfoModel]
   let extraInformation: ExtraInformationModel
   let wind: WindModel
   let sunriseTime: String
   let sunsetTime: String
}

// MARK: - Coordinates
struct CoordinatesModel {
   let longitude, latitude: Double
}

// MARK: - WeatherInfo
struct WeatherInfoModel {
   let main, description, icon: String
}

// MARK: - ExtraInformation
struct ExtraInformationModel {
   let temperature, feelsLike, minTemperature, maxTemperature, pressure, humidity, seaLevel, groundLevel: Double
}

// MARK: - Wind
struct WindModel {
   let speed: Double?
   let directionDegrees: Int?
   let gust: Double?
}
