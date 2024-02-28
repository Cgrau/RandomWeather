import Foundation

// MARK: - WeatherDataModel
struct WeatherDataModel: Codable {
   let coordinates: CoordinatesDataModel
   let weather: [WeatherInfoDataModel]
   let base: String
   let main: MainDataModel
   let visibility: Int
   let wind: WindDataModel
   let rain: RainDataModel?
   let snow: SnowDataModel?
   let clouds: CloudsDataModel
   let timeOfData: Int
   let sys: SysDataModel
   let timezone, id: Int
   let name: String
   let cod: Int
   
   enum CodingKeys: String, CodingKey {
      case coordinates = "coord"
      case weather
      case base
      case main
      case visibility
      case wind
      case rain
      case snow
      case clouds
      case timeOfData = "dt"
      case sys
      case timezone
      case id
      case name
      case cod
   }
}

// MARK: - Clouds
struct CloudsDataModel: Codable {
   let percentage: Int
   enum CodingKeys: String, CodingKey {
      case percentage = "all"
   }
}

// MARK: - Coord
struct CoordinatesDataModel: Codable {
   let longitude, latitude: Double
   
   enum CodingKeys: String, CodingKey {
      case longitude = "lon"
      case latitude = "lat"
   }
}

// MARK: - Main
struct MainDataModel: Codable {
   let temperature, feelsLike, minTemperature, maxTemperature, pressure, humidity, seaLevel, groundLevel: Double
   enum CodingKeys: String, CodingKey {
      case temperature = "temp"
      case feelsLike = "feels_like"
      case minTemperature = "temp_min"
      case maxTemperature = "temp_max"
      case pressure
      case humidity
      case seaLevel = "sea_level"
      case groundLevel = "grnd_level"
   }
}

// MARK: - Rain
struct RainDataModel: Codable {
   let the1H: Double?
   let the3H: Double?
}

// MARK: - Snow
struct SnowDataModel: Codable {
   let the1H: Double?
   let the3H: Double?
}

// MARK: - Sys
struct SysDataModel: Codable {
   let type: Int?
   let id: Int?
   let country: String?
   let sunrise, sunset: Double
}

// MARK: - Weather
struct WeatherInfoDataModel: Codable {
   let id: Int
   let main, description, icon: String
}

// MARK: - Wind
struct WindDataModel: Codable {
   let speed: Double
   let directionDegrees: Int
   let gust: Double?
   
   enum CodingKeys: String, CodingKey {
      case speed
      case directionDegrees = "deg"
      case gust
   }
}
