import Combine
import UIKit

typealias MainViewModelOutput = AnyPublisher<MainViewState, Never>

public struct MainViewModelInput {
   let onAppear: AnyPublisher<Void, Never>
   let onReloadTapped: AnyPublisher<Void, Never>
}

protocol MainViewModelable: AnyObject {
   func transform(input: MainViewModelInput) -> MainViewModelOutput
}

public class MainViewModel: MainViewModelable {
   @Published private(set) var state: MainViewState = .loading
   private let getInformation: GetInformation.UseCase
   
   required init(getInformation: @escaping GetInformation.UseCase) {
      self.getInformation = getInformation
   }
   
   static func buildDefault() -> Self {
      .init(getInformation: GetInformation.buildDefault().execute)
   }
   
   func transform(input: MainViewModelInput) -> MainViewModelOutput {
      let onAppearAction = input.onAppear
         .flatMap { [weak self] _ -> AnyPublisher<MainViewState, Never> in
            guard let self = self else { return Just(.error(.inconsistency)).eraseToAnyPublisher() }
            return self.getNewData()
         }
         .eraseToAnyPublisher()
      
      let onReloadAction = input.onReloadTapped
         .flatMap { [weak self] _ -> AnyPublisher<MainViewState, Never> in
            guard let self = self else { return Just(.error(.inconsistency)).eraseToAnyPublisher() }
            return self.getNewData()
         }
         .eraseToAnyPublisher()
      
      let loadingActions = Publishers.Merge(input.onAppear, input.onReloadTapped)
         .print("Should ShowLoading")
         .map { _ in return MainViewState.loading }
         .eraseToAnyPublisher()
      
      return Publishers.Merge3(loadingActions, onAppearAction, onReloadAction)
         .removeDuplicates()
         .handleEvents(receiveOutput: { [weak self] in self?.state = $0 })
         .eraseToAnyPublisher()
   }
   
   private func getNewData() -> MainViewModelOutput {
      self.getInformation()
         .map { viewModel in
            return .loaded(viewModel)
         }
         .catch { _ in
            return Just(.error(.requestFailed)).eraseToAnyPublisher()
         }
         .handleEvents(receiveOutput: { [weak self] in self?.state = $0 })
         .eraseToAnyPublisher()
   }
}

