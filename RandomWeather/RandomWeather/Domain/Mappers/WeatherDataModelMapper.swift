import Foundation

protocol WeatherDataModelMapping {
   func map(_ input: WeatherDataModel) -> WeatherModel
}

final class WeatherDataModelMapper: WeatherDataModelMapping {
   func map(_ input: WeatherDataModel) -> WeatherModel {
      .init(city: input.name,
            coutry: input.sys.country ?? "Unknown",
            coordinates: .init(longitude: input.coordinates.longitude,
                               latitude: input.coordinates.latitude),
            weather: mapWeather(input.weather),
            extraInformation: mapExtraInfo(input.main),
            wind: mapWind(input.wind),
            sunriseTime: mapTime(input.sys.sunrise),
            sunsetTime: mapTime(input.sys.sunset))
   }
   
   private func mapWeather(_ input: [WeatherInfoDataModel]) -> [WeatherInfoModel] {
      input.map {
         WeatherInfoModel(main: $0.main, description: $0.description, icon: $0.icon)
      }
   }
   
   private func mapExtraInfo(_ input: MainDataModel) -> ExtraInformationModel {
      .init(temperature: convert(farenheit: input.temperature),
            feelsLike: convert(farenheit: input.feelsLike),
            minTemperature: convert(farenheit: input.minTemperature),
            maxTemperature: convert(farenheit: input.maxTemperature),
            pressure: input.pressure,
            humidity: input.humidity,
            seaLevel: input.seaLevel,
            groundLevel: input.groundLevel)
   }
   
   private func mapWind(_ input: WindDataModel) -> WindModel {
      .init(speed: input.speed,
            directionDegrees: input.directionDegrees,
            gust: input.gust)
   }
   
   private func mapTime(_ input: Double) -> String {
      let date = Date(timeIntervalSince1970: input)
      let formatter = DateFormatter()
      formatter.dateFormat = "HH:mm"
      let time = formatter.string(from: date)
      return time
   }
   
   private func convert(farenheit: Double?) -> Double {
      guard let farenheit else { return 0 }
      return (farenheit / 33.8).rounded(to: 1)
   }
}
