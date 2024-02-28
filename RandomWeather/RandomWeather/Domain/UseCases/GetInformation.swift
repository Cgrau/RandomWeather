import Combine
import Foundation

final class GetInformation {
   typealias UseCase = (_ latitude: Double, _ longitude: Double) -> AnyPublisher<MainScreenViewModel, Error>
   
   private let getWeather: GetWeather.UseCase
   private let mapper: WeatherToMainScreenViewModelMapping
   
   static func buildDefault() -> Self {
      self.init(getWeather: GetWeather.buildDefault().execute,
                mapper: WeatherToMainScreenViewModelMapper())
   }
   
   init(getWeather: @escaping GetWeather.UseCase,
        mapper: WeatherToMainScreenViewModelMapping) {
      self.getWeather = getWeather
      self.mapper = mapper
   }
   
   func execute(latitude: Double, longitude: Double) -> AnyPublisher<MainScreenViewModel, Error> {
      getWeather(latitude, longitude)
         .tryMap({ [weak self] model in
            guard let self = self else {
               throw APIError.unexpectedError
            }
            return self.mapper.map(model)
         })
         .eraseToAnyPublisher()
   }
}
