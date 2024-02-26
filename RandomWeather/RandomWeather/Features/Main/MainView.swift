import UIKit

protocol MainViewDelegate: AnyObject {
}

final class MainView: View {
   private enum Constant {
   }
   weak var delegate: MainViewDelegate?
   
   override func setupView() {
      backgroundColor = .white
      addSubviews()
   }
   
   private func addSubviews() {
      [].forEach(addSubview)
   }
   
   override func setupConstraints() {
      //
   }
}

extension MainView {
   func apply(viewModel: MainScreenViewModel) {
   }
}
