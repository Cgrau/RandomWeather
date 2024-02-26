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
   
   private var cancellableBag = Set<AnyCancellable>()
   
   required init() {}
   
   static func buildDefault() -> Self {
      .init()
   }
   
   func transform(input: MainViewModelInput) -> MainViewModelOutput {
      cancellableBag.removeAll()
      
      // MARK: - on View Appear
      let onAppearAction = input.onAppear.map { [weak self] result -> MainViewState in
         guard let self else { return .error(.inconsistency) }
         return .loaded(.init(result: "Call a use case to perform the action and return a ViewModel"))
      }.removeDuplicates()
         .handleEvents(receiveOutput: { [weak self] in self?.state = $0 })
         .eraseToAnyPublisher()
      
      return onAppearAction
   }
}

