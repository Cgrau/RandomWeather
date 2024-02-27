import Combine
import Foundation

final class GetWeather {
   typealias UseCase = (_ latitude: Double, _ longitude: Double) -> AnyPublisher<WeatherModel, Error>
   
   private let apiClient: URLSessionAPIClient<WeatherEndpoint>
   private let mapper: WeatherDataModelMapping
   
   static func buildDefault() -> Self {
      self.init(apiClient: URLSessionAPIClient<WeatherEndpoint>.buildDefault(),
                mapper: WeatherDataModelMapper())
   }
   
   init(apiClient: URLSessionAPIClient<WeatherEndpoint>,
        mapper: WeatherDataModelMapping) {
      self.apiClient = apiClient
      self.mapper = mapper
   }
   
   func execute(latitude: Double, longitude: Double) -> AnyPublisher<WeatherModel, Error> {
      apiClient.request(WeatherEndpoint.getWeather(request: .init(latitude: latitude,
                                                                  longitude: longitude)))
      .tryMap { [weak self] (weatherDataModel: WeatherDataModel) throws -> WeatherModel in
         guard let self = self else {
            throw APIError.unexpectedError
         }
         return self.mapper.map(weatherDataModel)
      }
      .eraseToAnyPublisher()
   }
}
