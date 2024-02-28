import UIKit
import Combine

final class MainViewController: UIViewController {
   private let mainView = MainView()
   private var viewModel: MainViewModelable
   private var onAppearPublisher = PassthroughSubject<Void, Never>()
   private var cancellables: Set<AnyCancellable> = []
   
   required init(viewModel: MainViewModelable) {
      self.viewModel = viewModel
      super.init(nibName: nil, bundle: nil)
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   static func buildDefault() -> Self {
      .init(viewModel: MainViewModel.buildDefault())
   }
   
   override func loadView() {
      view = mainView
      mainView.delegate = self
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      bundToViewModel()
   }
   
   override func viewDidAppear(_ animated: Bool) {
      onAppearPublisher.send(())
   }
   
   func bundToViewModel() {
      cancellables.removeAll()
      let input = MainViewModelInput(onAppear: onAppearPublisher.eraseToAnyPublisher())
      
      let output = viewModel.transform(input: input)
      output.sink { [weak self] state in
         self?.handleState(state)
      }.store(in: &cancellables)
   }
   
   private func handleState(_ state: MainViewState) {
      switch state {
      case .idle:
         print("Idle")
      case .loading:
         print("Loading...")
      case .loaded(let screenViewModel):
         mainView.apply(viewModel: screenViewModel)
      case .error(let errorMessage):
         print("Error: \(errorMessage.rawValue)")
      }
   }
}

extension MainViewController: MainViewDelegate {
   func didTapReloadButton() {
      //
   }
}
