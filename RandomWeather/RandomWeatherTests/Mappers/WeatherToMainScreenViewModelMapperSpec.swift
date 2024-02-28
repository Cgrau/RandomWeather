import XCTest
@testable import RandomWeather

class WeatherToMainScreenViewModelMapperSpec: XCTestCase {
   
   var mapper: WeatherToMainScreenViewModelMapper!
   
   override func setUp() {
      super.setUp()
      mapper = WeatherToMainScreenViewModelMapper()
   }
   
   override func tearDown() {
      mapper = nil
      super.tearDown()
   }
   
   func testMapReturnsCorrectViewModel() {
      // Given
      let weatherModel = WeatherModel.init(city: "Barcelona",
                                           country: "ES",
                                           coordinates: .init(longitude: 12.3, latitude: 45.6),
                                           weather: [WeatherInfoModel.init(main: "LoremIpsum", description: "LoremIpsum", icon: "03d")],
                                           extraInformation: .init(temperature: 20, feelsLike: 22, minTemperature: 15, maxTemperature: 25, pressure: 1009, humidity: 90, seaLevel: 1009, groundLevel: 1009),
                                           wind: .init(speed: 12, directionDegrees: 45, gust: 17),
                                           sunriseTime: "",
                                           sunsetTime: "")
      
      // When
      let viewModel = mapper.map(weatherModel)
      
      // Then
      XCTAssertEqual(viewModel.navigationTitle, "Random Weather")
      
      XCTAssertEqual(viewModel.information.location, "Barcelona, ES")
      XCTAssertEqual(viewModel.information.longitude, "Lot: 12.3")
      XCTAssertEqual(viewModel.information.latitude, "Lat: 45.6")
      XCTAssertEqual(viewModel.information.temperature, "20.0°C")
      XCTAssertEqual(viewModel.information.iconURL, URL(string: "https://openweathermap.org/img/wn/03d@2x.png"))
      XCTAssertEqual(viewModel.information.description, "LoremIpsum")
      XCTAssertEqual(viewModel.information.minTemperature, "L: 15.0°C")
      XCTAssertEqual(viewModel.information.maxTemperature, "H: 25.0°C")
      
      XCTAssertEqual(viewModel.sunInformation.title, "Sunrise and sunset times:")
      XCTAssertEqual(viewModel.sunInformation.sunrise, "Sunrise: ")
      XCTAssertEqual(viewModel.sunInformation.sunset, "Sunset: ")
      
      if let windInformation = viewModel.windInformation {
         XCTAssertEqual(windInformation.title, "Wind Information:")
         XCTAssertEqual(windInformation.speed, "Speed: 12.00")
         XCTAssertEqual(windInformation.gust, "Gust: 17.00")
      } else {
         XCTFail("WindInfo should be present")
      }
      
      XCTAssertEqual(viewModel.extraInformation.title, "Extra Information:")
      XCTAssertEqual(viewModel.extraInformation.pressure, "Pressure: 1009 hPa")
      XCTAssertEqual(viewModel.extraInformation.humidity, "Humidity: 90%")
      XCTAssertEqual(viewModel.extraInformation.seaLevel, "Pressure at sea level: 1009 hPa")
      XCTAssertEqual(viewModel.extraInformation.groundLevel, "Pressure at ground level: 1009 hPa")
   }
}
