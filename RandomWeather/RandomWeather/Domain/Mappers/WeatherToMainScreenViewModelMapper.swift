import UIKit

protocol WeatherToMainScreenViewModelMapping {
   func map(_ input: WeatherModel) -> MainScreenViewModel
}

final class WeatherToMainScreenViewModelMapper: WeatherToMainScreenViewModelMapping {
   enum Constants {
      static let screenTitle = "Random Weather"
      static let latitude = "Lat: %.1f"
      static let longitude = "Lot: %.1f"
      static let imageURL = "https://openweathermap.org/img/wn/%@@2x.png"
      static let temperature = "%.1f°C"
      static let minTemperature = "L: %.1f°C"
      static let maxTemperature = "H: %.1f°C"
      enum Wind {
         static let speed = "Speed: %.2f"
         static let gust = "Gust: %.2f"
      }
   }
   
   func map(_ input: WeatherModel) -> MainScreenViewModel {
      .init(
         navigationTitle: Constants.screenTitle,
         information: .init(
            location: map(city: input.city, country: input.country),
            latitude: String(format: Constants.latitude, input.coordinates.latitude),
            longitude: String(format: Constants.longitude, input.coordinates.longitude),
            temperature: map(temperature: input.extraInformation.temperature),
            iconURL: map(iconURLString: input.weather.first?.icon),
            description: input.weather.first?.description ?? "",
            minTemperature: map(minTemperature: input.extraInformation.minTemperature),
            maxTemperature: map(maxTemperature: input.extraInformation.maxTemperature)
         ), 
         windInformation: map(wind: input.wind)
      )
   }
   
   private func map(city: String, country: String?) -> String {
      if let country {
         return "\(city), \(country)"
      } else if !city.isEmpty {
         return "\(city)"
      } else {
         return "Unknown Location"
      }
   }
   
   private func map(temperature: Double?) -> String {
      guard let temperature else { return "-" }
      return String(format: Constants.temperature, temperature)
   }
   
   private func map(iconURLString: String?) -> URL? {
      guard let iconURLString else { return nil }
      let iconURL = String(format: Constants.imageURL, iconURLString)
      return URL(string: iconURL)
   }
   
   private func map(minTemperature: Double?) -> String {
      guard let minTemperature else { return "-" }
      return String(format: Constants.minTemperature, minTemperature)
   }
   
   private func map(maxTemperature: Double?) -> String {
      guard let maxTemperature else { return "-" }
      return String(format: Constants.maxTemperature, maxTemperature)
   }
   
   private func map(wind: WindModel) -> WindInformationViewModel? {
      var arrow: UIImage?
      if let windDirection = wind.directionDegrees {
         arrow = .upArrow.rotated(byDegrees: CGFloat(windDirection))
      }
      guard let speed = wind.speed, let gust = wind.gust else { return nil }
      return .init(title: "Wind Information:",
                   speed: String(format: Constants.Wind.speed, speed),
                   gust: String(format: Constants.Wind.gust, gust),
                   directionImage: arrow)
   }
}
