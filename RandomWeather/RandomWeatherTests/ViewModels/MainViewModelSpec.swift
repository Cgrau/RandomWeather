import XCTest
import Combine
@testable import RandomWeather

final class MainViewModelSpec: XCTestCase {
   private var sut: MainViewModelable!
   private var getInformationCalled: Bool = false
   private var getInformationCalledCount: Int = 0
   private var cancellables: Set<AnyCancellable> = []
   
   override func tearDown() {
      sut = nil
      getInformationCalled = false
      getInformationCalledCount = 0
      cancellables = []
      super.tearDown()
   }
   
   func testTransform_onAppear() {
      givenSUT()
      let input = MainViewModelInput(onAppear: Just(()).eraseToAnyPublisher(),
                                     onReloadTapped:  Empty().eraseToAnyPublisher())
      var receivedStates: [MainViewState] = []
      
      sut.transform(input: input)
         .sink { state in
            receivedStates.append(state)
         }
         .store(in: &cancellables)
      
      XCTAssertEqual(receivedStates, 
                     [
                        .loading,
                        .loaded(givenViewModel())
                     ])
      XCTAssertTrue(getInformationCalled)
      XCTAssertEqual(getInformationCalledCount, 1)
   }
   
   func testTransform_onReloadTapped() {
      givenSUT()
      let input = MainViewModelInput(onAppear: Empty().eraseToAnyPublisher(),
                                     onReloadTapped: Just(()).eraseToAnyPublisher())
      var receivedStates: [MainViewState] = []
      
      sut.transform(input: input)
         .sink { state in
            receivedStates.append(state)
         }
         .store(in: &cancellables)
      
      XCTAssertEqual(receivedStates,
                     [
                        .loading,
                        .loaded(givenViewModel())
                     ])
      XCTAssertTrue(getInformationCalled)
      XCTAssertEqual(getInformationCalledCount, 1)
   }
   
   func testTransform_onReloadTapped2() {
      givenSUT()
      let input = MainViewModelInput(onAppear: Empty().eraseToAnyPublisher(),
                                     onReloadTapped: Just(()).eraseToAnyPublisher())
      var receivedStates: [MainViewState] = []
      
      let expectation = XCTestExpectation(description: "Wait for states to be received")
      
      sut.transform(input: input)
         .sink { state in
            receivedStates.append(state)
            
            switch state {
            case let .loaded(viewModel):
               XCTAssertEqual(viewModel, self.givenViewModel())
               expectation.fulfill()
            default:
               break
            }
         }
         .store(in: &cancellables)
      
      wait(for: [expectation], timeout: 5.0)
      
      XCTAssertEqual(receivedStates, [.loading, .loaded(self.givenViewModel())])
      XCTAssertTrue(getInformationCalled)
      XCTAssertEqual(getInformationCalledCount, 1)
   }
   
   
   private func givenSUT() {
      sut = MainViewModel(getInformation: {
         self.getInformationCalled = true
         self.getInformationCalledCount += 1
         return Just(self.givenViewModel())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
      })
   }
   
   private func givenViewModel() -> MainScreenViewModel {
      .init(navigationTitle: "Title",
            information: givenInformationViewModel(),
            sunInformation: givenSunInformationViewModel(),
            extraInformation: givenExtraInformationViewModel())
   }
   
   private func givenInformationViewModel() -> MainInformationViewModel {
      .init(
         location: "Mock Location",
         latitude: "Mock Latitude",
         longitude: "Mock Longitude",
         temperature: "Mock Temperature",
         iconURL: URL(string: "https://example.com/mock-icon.png"),
         description: "Mock Description",
         minTemperature: "Mock Min Temperature",
         maxTemperature: "Mock Max Temperature"
      )
   }
   
   private func givenSunInformationViewModel() -> SunInformationViewModel {
      .init(
         title: "Mock Title",
         sunrise: "Mock Sunrise",
         sunset: "Mock Sunset",
         icon: .clearSky
      )
   }
   
   private func givenExtraInformationViewModel() -> ExtraInformationViewModel {
      .init(
         title: "Mock Title",
         pressure: "Mock Pressure",
         humidity: "Mock Humidity",
         seaLevel: "Mock Sea Level",
         groundLevel: "Mock Ground Level"
      )
   }
}
