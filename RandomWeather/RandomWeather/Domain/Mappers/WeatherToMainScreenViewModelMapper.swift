import Foundation

protocol WeatherToMainScreenViewModelMapping {
   func map(_ input: WeatherModel) -> MainScreenViewModel
}

final class WeatherToMainScreenViewModelMapper: WeatherToMainScreenViewModelMapping {
   func map(_ input: WeatherModel) -> MainScreenViewModel {
      .init(
         navigationTitle: "Random Weather",
         information: .init(
            location: "\(input.city), \(input.coutry)",
            latitude: "Lat: \(input.coordinates.latitude)",
            longitude: "Lon: \(input.coordinates.longitude)",
            temperature: "\(input.extraInformation.temperature!)°C",
            iconURL: URL(string: "https://openweathermap.org/img/wn/\(input.weather.first?.icon ?? "")@2x.png"),
            description: input.weather.first?.description ?? "",
            minTemperature: "L: \(input.extraInformation.minTemperature!)°C",
            maxTemperature: "H: \(input.extraInformation.maxTemperature!)°C"
         )
      )
   }
}
