import XCTest
@testable import RandomWeather

class WeatherDataModelMapperTests: XCTestCase {
   
   var mapper: WeatherDataModelMapper!
   
   override func setUp() {
      super.setUp()
      mapper = WeatherDataModelMapper()
   }
   
   override func tearDown() {
      mapper = nil
      super.tearDown()
   }
   
   func testMapReturnsCorrectWeatherModel() {
      // Given
      let weatherDataModel = WeatherDataModel(coordinates: .init(longitude: 12, latitude: 42),
                                              weather: [WeatherInfoDataModel.init(id: 1, main: "Main", description: "Description", icon: "03d")],
                                              base: "ES",
                                              main: .init(temperature: 420,
                                                          feelsLike: 450,
                                                          minTemperature: 270,
                                                          maxTemperature: 400,
                                                          pressure: 1009,
                                                          humidity: 98,
                                                          seaLevel: 1009,
                                                          groundLevel: 1009),
                                              visibility: 12,
                                              wind: .init(speed: 12, directionDegrees: 33, gust: 14),
                                              rain: nil,
                                              snow: nil,
                                              clouds: .init(percentage: 16),
                                              timeOfData: 123133,
                                              sys: .init(type: 1, id: 1, country: "ES", sunrise: 12345, sunset: 56789),
                                              timezone: 111222,
                                              id: 1,
                                              name: "Barcelona",
                                              cod: 1)
      
      // When
      let weatherModel = mapper.map(weatherDataModel)
      
      // Then
      XCTAssertEqual(weatherModel.city, "Barcelona")
      XCTAssertEqual(weatherModel.country, "ES")
      XCTAssertEqual(weatherModel.coordinates.latitude, 42)
      XCTAssertEqual(weatherModel.coordinates.longitude, 12)
      
      // Add assertions for the WeatherInfoModel
      XCTAssertEqual(weatherModel.weather.count, 1)
      XCTAssertEqual(weatherModel.weather.first?.main, "Main")
      XCTAssertEqual(weatherModel.weather.first?.description, "Description")
      XCTAssertEqual(weatherModel.weather.first?.icon, "03d")
      
      // Add assertions for the ExtraInformationModel
      XCTAssertEqual(weatherModel.extraInformation.temperature, 12.4)
      XCTAssertEqual(weatherModel.extraInformation.feelsLike, 13.3)
      XCTAssertEqual(weatherModel.extraInformation.minTemperature, 8.0)
      XCTAssertEqual(weatherModel.extraInformation.maxTemperature, 11.8)
      XCTAssertEqual(weatherModel.extraInformation.pressure, 1009)
      XCTAssertEqual(weatherModel.extraInformation.humidity, 98)
      XCTAssertEqual(weatherModel.extraInformation.seaLevel, 1009)
      XCTAssertEqual(weatherModel.extraInformation.groundLevel, 1009)
      
      // Add assertions for the WindModel
      XCTAssertEqual(weatherModel.wind.speed, 12)
      XCTAssertEqual(weatherModel.wind.directionDegrees, 33)
      XCTAssertEqual(weatherModel.wind.gust, 14)
      
      // Add assertions for other properties as needed
      XCTAssertEqual(weatherModel.sunriseTime, "04:25")
      XCTAssertEqual(weatherModel.sunsetTime, "16:46")
      
      XCTAssertEqual(weatherModel.city, "Barcelona")
   }
   
}
