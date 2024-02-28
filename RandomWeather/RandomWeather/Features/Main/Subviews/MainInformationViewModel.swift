import Foundation

struct MainInformationViewModel: Equatable {
   let location: String
   let latitude: String
   let longitude: String
   let temperature: String
   let iconURL: URL?
   let description: String
   let minTemperature: String
   let maxTemperature: String
}
