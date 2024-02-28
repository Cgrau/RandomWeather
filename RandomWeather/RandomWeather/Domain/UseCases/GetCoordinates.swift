import Combine
import Foundation

final class GetCoordinates {
   typealias UseCase = () -> WeatherCoordinates
   
   static func buildDefault() -> Self {
      .init()
   }
   
   init(){}
   
   func execute() -> WeatherCoordinates {
      .init(longitude: getRandomLongitude(),
            latitude: getRandomLatitude())
   }
   
   private func getRandomLatitude() -> Double {
      Double.random(in: -90...90)
   }
   
   private func getRandomLongitude() -> Double {
      Double.random(in: -180...180)
   }
}
