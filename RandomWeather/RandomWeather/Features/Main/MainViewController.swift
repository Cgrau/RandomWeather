import UIKit
import Combine
import SVProgressHUD

final class MainViewController: UIViewController {
   private let mainView = MainView()
   private var viewModel: MainViewModelable
   private var onAppearPublisher = PassthroughSubject<Void, Never>()
   private var onReloadPublisher = PassthroughSubject<Void, Never>()
   private let scheduler: DispatchQueue
   private var cancellables: Set<AnyCancellable> = []
   
   required init(viewModel: MainViewModelable,
                 scheduler: DispatchQueue) {
      self.viewModel = viewModel
      self.scheduler = scheduler
      super.init(nibName: nil, bundle: nil)
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   static func buildDefault() -> Self {
      .init(viewModel: MainViewModel.buildDefault(), 
            scheduler: .main)
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
      let input = MainViewModelInput(onAppear: onAppearPublisher.eraseToAnyPublisher(), 
                                     onReloadTapped: onReloadPublisher.eraseToAnyPublisher())
      
      let output = viewModel.transform(input: input)
         .receive(on: scheduler)
      output.sink { [weak self] state in
         self?.handleState(state)
      }.store(in: &cancellables)
   }
   
   private func handleState(_ state: MainViewState) {
      switch state {
      case .idle:
         print("Idle")
      case .loading:
         Haptics.play(.light)
         SVProgressHUD.show()
      case .loaded(let screenViewModel):
         SVProgressHUD.dismiss()
         mainView.apply(viewModel: screenViewModel)
      case .error(let errorMessage):
         SVProgressHUD.dismiss()
         UIAlertController.show(message: errorMessage.rawValue,
                                on: self)
         print("Error: \(errorMessage.rawValue)")
      }
   }
}

extension MainViewController: MainViewDelegate {
   func didTapReloadButton() {
      onReloadPublisher.send(())
   }
}
