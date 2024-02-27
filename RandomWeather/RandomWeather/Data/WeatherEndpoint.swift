import Foundation

enum WeatherEndpoint: APIEndpoint {
   private enum Constants {
      static let appId = "ae103060692fe13422deb98285505dc6"
   }
   
   case getWeather(request: WeatherModelRequest)
   
   var baseURL: URL {
      return URL(string: "https://api.openweathermap.org/")!
   }
   
   var path: String {
      switch self {
      case .getWeather:
         return "data/2.5/weather"
      }
   }
   
   var method: HTTPMethod {
      switch self {
      case .getWeather:
         return .get
      }
   }
   
   var headers: [String: String]? {
      switch self {
      case .getWeather:
         return ["Content-Type": "application/json"]
      }
   }
   
   var parameters: [String: Any]? {
      switch self {
      case .getWeather(let request):
         return ["lat": request.latitude,
                 "lon": request.longitude,
                 "appid": Constants.appId] //will save appid in other place
      }
   }
}
