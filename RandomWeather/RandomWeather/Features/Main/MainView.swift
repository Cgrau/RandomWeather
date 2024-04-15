import UIKit
import SnapKit

protocol MainViewDelegate: AnyObject {
   func didTapReloadButton()
}

final class MainView: View {
   private enum Constants {
      enum NavigationTitle {
         static let font = UIFont.boldSystemFont(ofSize: 25)
      }
   }
   
   weak var delegate: MainViewDelegate?
   
   private let navigationItem: UINavigationItem = {
      let navigationItem = UINavigationItem()
      let navigationButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: nil, action: #selector(reloadAction))
      navigationItem.rightBarButtonItem = navigationButton
      return navigationItem
   }()
   
   private let navigationBar: UINavigationBar = {
      let navBar = UINavigationBar()
      navBar.translatesAutoresizingMaskIntoConstraints = false
      navBar.setBackgroundImage(UIImage(), for: .default)
      navBar.titleTextAttributes = [NSAttributedString.Key.font: Constants.NavigationTitle.font]
      return navBar
   }()
   
   private let scrollView = UIScrollView()
   
   private let stackView: UIStackView = {
      let stackView = UIStackView()
      stackView.axis = .vertical
      stackView.alignment = .fill
      stackView.spacing = Spacing.m
      stackView.distribution = .equalSpacing
      stackView.translatesAutoresizingMaskIntoConstraints = false
      return stackView
   }()
   
   private let informationView = MainInformationView()
   private let sunInformationView = SunInformationView()
   private let windInformationView = WindInformationView()
   private let extraInformationView = ExtraInformationView()
   
   override func setupView() {
      backgroundColor = .white
      navigationBar.setItems([navigationItem], animated: false)
      addSubviews()
   }
   
   private func addSubviews() {
      [informationView, sunInformationView, windInformationView, extraInformationView].forEach(stackView.addArrangedSubview)
      scrollView.addSubview(stackView)
      [navigationBar, scrollView].forEach(addSubview)
   }
   
   override func setupConstraints() {
      navigationBar.snp.makeConstraints { make in
         make.top.equalTo(safeAreaLayoutGuide)
         make.horizontalEdges.equalToSuperview()
      }
      scrollView.snp.makeConstraints { make in
         make.top.equalTo(navigationBar.snp.bottom)
         make.horizontalEdges.equalTo(safeAreaLayoutGuide)
         make.bottom.equalToSuperview()
      }
      stackView.snp.makeConstraints { make in
         make.top.equalToSuperview().offset(Spacing.m)
         make.centerX.equalToSuperview()
         make.leading.equalToSuperview().offset(Spacing.m)
         make.trailing.equalToSuperview().offset(-Spacing.m)
         make.bottom.equalToSuperview().offset(-Spacing.m)
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
      sunInformationView.apply(viewModel: viewModel.sunInformation)
      extraInformationView.apply(viewModel: viewModel.extraInformation)
      guard let windInformation = viewModel.windInformation else {
         windInformationView.removeFromSuperview()
         return
      }
      windInformationView.apply(viewModel: windInformation)
   }
}
