import Combine
import Foundation

final class GetInformation {
   typealias UseCase = () -> AnyPublisher<MainScreenViewModel, Error>
   
   private let getCoordinates: GetCoordinates.UseCase
   private let getWeather: GetWeather.UseCase
   private let mapper: WeatherToMainScreenViewModelMapping
   
   static func buildDefault() -> Self {
      self.init(getCoordinates: GetCoordinates.buildDefault().execute,
                getWeather: GetWeather.buildDefault().execute,
                mapper: WeatherToMainScreenViewModelMapper())
   }
   
   init(getCoordinates: @escaping GetCoordinates.UseCase,
        getWeather: @escaping GetWeather.UseCase,
        mapper: WeatherToMainScreenViewModelMapping) {
      self.getCoordinates = getCoordinates
      self.getWeather = getWeather
      self.mapper = mapper
   }
   
   func execute() -> AnyPublisher<MainScreenViewModel, Error> {
      let coordinates = getCoordinates()
      return getWeather(coordinates.latitude, coordinates.longitude)
         .tryMap({ [weak self] model in
            guard let self = self else { throw APIError.unexpectedError }
            return self.mapper.map(model)
         })
         .eraseToAnyPublisher()
   }
}
