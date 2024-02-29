import XCTest
import Combine
@testable import RandomWeather

class GetInformationSpec: XCTestCase {
   
   func testExecuteReturnsValidMainScreenViewModel() {
      // Given
      let getInformation = GetInformation(getCoordinates: { self.givenCoordinates() },
                                          getWeather: { _, _ in return Just(self.givenWeatherModel()).setFailureType(to: Error.self).eraseToAnyPublisher() },
                                          mapper: MockMapper())
      
      // When
      var receivedResult: Result<MainScreenViewModel, Error>?
      
      _ = getInformation.execute()
         .sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
               break // Success
            case .failure(let error):
               receivedResult = .failure(error)
            }
         }, receiveValue: { viewModel in
            receivedResult = .success(viewModel)
         })
      
      // Then
      switch receivedResult {
      case .success(let viewModel):
         XCTAssertNotNil(viewModel)
         XCTAssertEqual(viewModel.information.location, Constants.InformationViewModel.location)
         XCTAssertEqual(viewModel.information.latitude, Constants.InformationViewModel.latitude)
         XCTAssertEqual(viewModel.information.longitude, Constants.InformationViewModel.longitude)
         XCTAssertEqual(viewModel.information.temperature, Constants.InformationViewModel.temperature)
         XCTAssertEqual(viewModel.information.iconURL, URL(string: Constants.InformationViewModel.iconURL))
         XCTAssertEqual(viewModel.information.description, Constants.InformationViewModel.description)
         XCTAssertEqual(viewModel.information.minTemperature, Constants.InformationViewModel.minTemperature)
         XCTAssertEqual(viewModel.information.maxTemperature, Constants.InformationViewModel.maxTemperature)
         
         XCTAssertEqual(viewModel.sunInformation.title, Constants.SunInformationViewModel.title)
         XCTAssertEqual(viewModel.sunInformation.sunrise, Constants.SunInformationViewModel.sunrise)
         XCTAssertEqual(viewModel.sunInformation.sunset, Constants.SunInformationViewModel.sunset)
         
         XCTAssertEqual(viewModel.extraInformation.title, Constants.ExtraInformationViewModel.title)
         XCTAssertEqual(viewModel.extraInformation.pressure, Constants.ExtraInformationViewModel.pressure)
         XCTAssertEqual(viewModel.extraInformation.humidity, Constants.ExtraInformationViewModel.humidity)
         XCTAssertEqual(viewModel.extraInformation.seaLevel, Constants.ExtraInformationViewModel.seaLevel)
         XCTAssertEqual(viewModel.extraInformation.groundLevel, Constants.ExtraInformationViewModel.groundLevel)
      case .failure(let error):
         XCTFail("Unexpected error: \(error)")
      case .none:
         XCTFail("No result received")
      }
   }
   
   func testBuildDefaultReturnsInstance() {
      // When
      let getInformation = GetInformation.buildDefault()
      
      // Then
      XCTAssertNotNil(getInformation)
   }
   
   private func givenCoordinates() -> WeatherCoordinates {
      WeatherCoordinates(longitude: 10.0, latitude: 20.0)
   }
   
   private func givenWeatherModel() -> WeatherModel {
      WeatherModel(
         city: Constants.MainScreenViewModel.navigationTitle,
         country: Constants.InformationViewModel.location,
         coordinates: .init(
            longitude: givenCoordinates().longitude,
            latitude: givenCoordinates().latitude
         ),
         weather: [],
         extraInformation: ExtraInformationModel(
            temperature: 1,
            feelsLike: 1,
            minTemperature: 1,
            maxTemperature: 1,
            pressure: 1,
            humidity: 1,
            seaLevel: 1,
            groundLevel: 1
         ),
         wind: WindModel(speed: 1, directionDegrees: 1, gust: 1),
         sunriseTime: Constants.SunInformationViewModel.sunrise,
         sunsetTime: Constants.SunInformationViewModel.sunset
      )
   }
   
   class MockMapper: WeatherToMainScreenViewModelMapping {
      func map(_ input: WeatherModel) -> MainScreenViewModel {
         givenMainScreenViewModel()
      }
      
      private func givenMainScreenViewModel() -> MainScreenViewModel {
         .init(
            navigationTitle: Constants.MainScreenViewModel.navigationTitle,
            information: givenInformationViewModel(),
            sunInformation: givenSunInformationViewModel(),
            extraInformation: givenExtraInformationViewModel()
         )
      }
      
      private func givenInformationViewModel() -> MainInformationViewModel {
         .init(
            location: Constants.InformationViewModel.location,
            latitude: Constants.InformationViewModel.latitude,
            longitude: Constants.InformationViewModel.longitude,
            temperature: Constants.InformationViewModel.temperature,
            iconURL: URL(string: Constants.InformationViewModel.iconURL),
            description: Constants.InformationViewModel.description,
            minTemperature: Constants.InformationViewModel.minTemperature,
            maxTemperature: Constants.InformationViewModel.maxTemperature
         )
      }
      
      private func givenSunInformationViewModel() -> SunInformationViewModel {
         .init(
            title: Constants.SunInformationViewModel.title,
            sunrise: Constants.SunInformationViewModel.sunrise,
            sunset: Constants.SunInformationViewModel.sunset,
            icon: .clearSky
         )
      }
      
      private func givenExtraInformationViewModel() -> ExtraInformationViewModel {
         .init(
            title: Constants.ExtraInformationViewModel.title,
            pressure: Constants.ExtraInformationViewModel.pressure,
            humidity: Constants.ExtraInformationViewModel.humidity,
            seaLevel: Constants.ExtraInformationViewModel.seaLevel,
            groundLevel: Constants.ExtraInformationViewModel.groundLevel
         )
      }
   }
}

private enum Constants {
   enum MainScreenViewModel {
      static let navigationTitle = "Title"
   }
   
   enum InformationViewModel {
      static let location = "Mock Location"
      static let latitude = "Mock Latitude"
      static let longitude = "Mock Longitude"
      static let temperature = "Mock Temperature"
      static let iconURL = "https://example.com/mock-icon.png"
      static let description = "Mock Description"
      static let minTemperature = "Mock Min Temperature"
      static let maxTemperature = "Mock Max Temperature"
   }
   
   enum SunInformationViewModel {
      static let title = "Mock Title"
      static let sunrise = "Mock Sunrise"
      static let sunset = "Mock Sunset"
   }
   
   enum ExtraInformationViewModel {
      static let title = "Mock Title"
      static let pressure = "Mock Pressure"
      static let humidity = "Mock Humidity"
      static let seaLevel = "Mock Sea Level"
      static let groundLevel = "Mock Ground Level"
   }
}
