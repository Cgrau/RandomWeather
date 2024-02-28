import Foundation

protocol WeatherDataModelMapping {
   func map(_ input: WeatherDataModel) -> WeatherModel
}

final class WeatherDataModelMapper: WeatherDataModelMapping {
   func map(_ input: WeatherDataModel) -> WeatherModel {
      .init(city: input.name,
            country: input.sys.country,
            coordinates: .init(longitude: input.coordinates.longitude,
                               latitude: input.coordinates.latitude),
            weather: mapWeather(input.weather),
            extraInformation: mapExtraInfo(input.main),
            wind: mapWind(input.wind),
            sunriseTime: input.sys.sunrise.toTimeFormat(timeZoneOffsetInSeconds: input.timezone),
            sunsetTime: input.sys.sunset.toTimeFormat(timeZoneOffsetInSeconds: input.timezone))
   }
   
   private func mapWeather(_ input: [WeatherInfoDataModel]) -> [WeatherInfoModel] {
      input.map {
         WeatherInfoModel(main: $0.main, description: $0.description, icon: $0.icon)
      }
   }
   
   private func mapExtraInfo(_ input: MainDataModel) -> ExtraInformationModel {
      .init(temperature: input.temperature.toCelcius(),
            feelsLike: input.feelsLike.toCelcius(),
            minTemperature: input.minTemperature.toCelcius(),
            maxTemperature: input.maxTemperature.toCelcius(),
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
}
