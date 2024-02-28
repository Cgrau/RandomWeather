import Combine
import UIKit

typealias MainViewModelOutput = AnyPublisher<MainViewState, Never>

public struct MainViewModelInput {
   let onAppear: AnyPublisher<Void, Never>
}

protocol MainViewModelable: AnyObject {
   func transform(input: MainViewModelInput) -> MainViewModelOutput
}

public class MainViewModel: ObservableObject, MainViewModelable {
   @Published private(set) var state: MainViewState = .loading
   private let getInformation: GetInformation.UseCase
   private let scheduler: DispatchQueue
   
   private var cancellableBag = Set<AnyCancellable>()
   
   required init(getInformation: @escaping GetInformation.UseCase,
                 scheduler: DispatchQueue) {
      self.getInformation = getInformation
      self.scheduler = scheduler
   }
   
   static func buildDefault() -> Self {
      .init(getInformation: GetInformation.buildDefault().execute,
            scheduler: .main)
   }
   
   func transform(input: MainViewModelInput) -> MainViewModelOutput {
      cancellableBag.removeAll()
      
      let onAppearAction = input.onAppear
         .flatMap { [weak self] _ -> AnyPublisher<MainViewState, Never> in
            guard let self = self else { return Just(.error(.inconsistency)).eraseToAnyPublisher() }
            return self.getInformation()
               .receive(on: scheduler)
               .map { viewModel in
                  return .loaded(viewModel)
               }
               .catch { _ in
                  return Just(.error(.requestFailed)).eraseToAnyPublisher()
               }
               .handleEvents(receiveOutput: { [weak self] in self?.state = $0 })
               .eraseToAnyPublisher()
         }
         .handleEvents(receiveOutput: { [weak self] in self?.state = $0 })
         .removeDuplicates()
         .eraseToAnyPublisher()
      
      return onAppearAction
   }
}

