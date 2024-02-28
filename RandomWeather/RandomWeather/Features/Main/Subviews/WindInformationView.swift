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
      [titleLabel, informationStackView, iconImageView].forEach(addSubview)
   }
   
   override func setupConstraints() {
      titleLabel.snp.makeConstraints { make in
         make.top.equalToSuperview()
         make.leading.equalToSuperview()
         make.trailing.equalToSuperview().offset(-Spacing.s)
      }
      informationStackView.snp.makeConstraints({ make in
         make.top.equalTo(titleLabel.snp.bottom).offset(Spacing.s)
         make.leading.equalToSuperview().offset(Spacing.s)
         make.bottom.equalToSuperview().offset(-Spacing.s)
      })
      iconImageView.snp.makeConstraints { make in
         make.centerY.equalTo(informationStackView)
         make.size.equalTo(Constants.Icon.size)
         make.leading.equalTo(informationStackView.snp.trailing)
         make.trailing.equalToSuperview().offset(-Spacing.s)
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
