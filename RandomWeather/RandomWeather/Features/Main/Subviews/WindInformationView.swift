import UIKit
import Kingfisher
import SnapKit

final class WindInformationView: View {
   private enum Constants {
      enum Title {
         static let font = UIFont.boldSystemFont(ofSize: 20)
      }
      enum Text {
         static let font = UIFont.boldSystemFont(ofSize: 18)
      }
      enum Icon {
         static let size = CGSize(width: 50, height: 50)
      }
   }
   
   private var titleLabel: UILabel = {
      let label = UILabel()
      label.textColor = .black
      label.font = Constants.Title.font
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
   }()
   
   private var mainStackView: UIStackView = {
      let stackView = UIStackView()
      stackView.axis = .horizontal
      stackView.alignment = .fill
      stackView.distribution = .equalSpacing
      stackView.spacing = Spacing.xxl
      stackView.translatesAutoresizingMaskIntoConstraints = false
      return stackView
   }()
   
   private var speedLabel: UILabel = {
      let label = UILabel()
      label.textColor = .black
      label.font = Constants.Text.font
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
   }()
   
   private var gustLabel: UILabel = {
      let label = UILabel()
      label.textColor = .black
      label.font = Constants.Text.font
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
   }()
   
   private var informationStackView: UIStackView = {
      let stackView = UIStackView()
      stackView.axis = .vertical
      stackView.alignment = .fill
      stackView.spacing = Spacing.xs
      stackView.distribution = .equalSpacing
      stackView.translatesAutoresizingMaskIntoConstraints = false
      return stackView
   }()
   
   private var iconImageView: UIImageView = {
      let imageView = UIImageView()
      imageView.contentMode = .scaleAspectFit
      return imageView
   }()
   
   override func setupView() {
      backgroundColor = .white
      speedLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
      speedLabel.setContentCompressionResistancePriority(.required, for: .vertical)
      gustLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
      gustLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
      addSubviews()
   }
   
   private func addSubviews() {
      [speedLabel, gustLabel].forEach(informationStackView.addArrangedSubview)
      [iconImageView, informationStackView].forEach(mainStackView.addArrangedSubview)
      [titleLabel, mainStackView].forEach(addSubview)
   }
   
   override func setupConstraints() {
      titleLabel.snp.makeConstraints { make in
         make.top.equalToSuperview()
         make.leading.equalToSuperview()
         make.trailing.equalToSuperview().offset(-Spacing.s)
      }
      mainStackView.snp.makeConstraints({ make in
         make.top.equalTo(titleLabel.snp.bottom).offset(Spacing.s)
         make.centerX.equalToSuperview()
         make.bottom.equalToSuperview().offset(-Spacing.s)
      })
      iconImageView.snp.makeConstraints { make in
         make.size.equalTo(Constants.Icon.size)
      }
   }
}

extension WindInformationView {
   func apply(viewModel: WindInformationViewModel) {
      titleLabel.text = viewModel.title
      titleLabel.underline()
      speedLabel.text = viewModel.speed
      gustLabel.text = viewModel.gust
      guard let direction = viewModel.directionImage else {
         iconImageView.removeFromSuperview()
         return
      }
      iconImageView.image = direction
   }
}
