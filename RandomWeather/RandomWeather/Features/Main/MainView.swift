import UIKit
import SnapKit

protocol MainViewDelegate: AnyObject {
   func didTapReloadButton()
}

final class MainView: View {
   private enum Constants {
      enum NavigationTitle {
         static let font = UIFont.boldSystemFont(ofSize: 32)
      }
   }
   
   weak var delegate: MainViewDelegate?
   
   let navigationItem: UINavigationItem = {
      let navigationItem = UINavigationItem()
      let navigationButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: nil, action: #selector(reloadAction))
      navigationItem.rightBarButtonItem = navigationButton
      return navigationItem
   }()
   
   let navigationBar: UINavigationBar = {
      let navBar = UINavigationBar()
      navBar.translatesAutoresizingMaskIntoConstraints = false
      navBar.setBackgroundImage(UIImage(), for: .default)
      navBar.titleTextAttributes = [NSAttributedString.Key.font: Constants.NavigationTitle.font]
      return navBar
   }()
   
   private var informationView = MainInformationView()
   
   override func setupView() {
      backgroundColor = .white
      navigationBar.setItems([navigationItem], animated: false)
      addSubviews()
   }
   
   private func addSubviews() {
      [navigationBar, informationView].forEach(addSubview)
   }
   
   override func setupConstraints() {
      navigationBar.snp.makeConstraints { make in
         make.top.equalTo(safeAreaLayoutGuide)
         make.horizontalEdges.equalToSuperview()
      }
      informationView.snp.makeConstraints { make in
         make.top.equalTo(navigationBar.snp.bottom).offset(Spacing.m)
         make.horizontalEdges.equalToSuperview()
      }
   }
   
   @objc private func reloadAction() {
      delegate?.didTapReloadButton()
   }
}

extension MainView {
   func apply(viewModel: MainScreenViewModel) {
      navigationItem.title = viewModel.navigationTitle
      informationView.apply(viewModel: viewModel.information)
   }
}
