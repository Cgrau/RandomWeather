import Foundation

protocol WeatherDataModelMapping {
   func map(_ input: WeatherDataModel) -> WeatherModel
}

final class WeatherDataModelMapper: WeatherDataModelMapping {
   func map(_ input: WeatherDataModel) -> WeatherModel {
      .init(city: input.name,
            coutry: input.sys.country ?? "DummyCountry",
            coordinates: .init(longitude: input.coordinates.longitude,
                               latitude: input.coordinates.latitude),
            weather: mapWeather(input.weather),
            extraInformation: mapExtraInfo(input.main),
            wind: mapWind(input.wind),
            sunriseTime: mapTime(input.sys.sunrise),
            sunsetTime: mapTime(input.sys.sunset))
   }
   
   private func mapWeather(_ input: [WeatherInfoDataModel]) -> [WeatherInfoModel] {
      [.init(main: "", description: "", icon: "")]
   }
   
   private func mapExtraInfo(_ input: MainDataModel) -> ExtraInformationModel {
      .init(temperature: 1, feelsLike: 1, minTemperature: 1, maxTemperature: 1, pressure: 1, humidity: 1, seaLevel: 1, groundLevel: 1)
   }
   
   private func mapWind(_ input: WindDataModel) -> WindModel {
      .init(speed: 1, directionDegrees: 1, gust: 1)
   }
   
   private func mapTime(_ input: Double) -> String {
      "\(NSDate(timeIntervalSince1970: input))"
   }
}
