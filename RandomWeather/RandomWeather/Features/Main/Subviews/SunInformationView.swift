import UIKit
import Kingfisher
import SnapKit

final class SunInformationView: View {
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
   
   private var iconImageView: UIImageView = {
      let imageView = UIImageView()
      imageView.contentMode = .scaleAspectFit
      return imageView
   }()
   
   private var sunriseTimeLabel: UILabel = {
      let label = UILabel()
      label.textColor = .black
      label.font = Constants.Text.font
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
   }()
   
   private var sunsetTimeLabel: UILabel = {
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
      stackView.distribution = .equalSpacing
      stackView.translatesAutoresizingMaskIntoConstraints = false
      return stackView
   }()
   
   override func setupView() {
      backgroundColor = .white
      sunriseTimeLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
      sunriseTimeLabel.setContentCompressionResistancePriority(.required, for: .vertical)
      sunsetTimeLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
      sunsetTimeLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
      addSubviews()
   }
   
   private func addSubviews() {
      [sunriseTimeLabel, sunsetTimeLabel].forEach(informationStackView.addArrangedSubview)
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
//         make.leading.equalToSuperview().offset(Spacing.s)
//         make.trailing.equalToSuperview().offset(-Spacing.s)
         make.bottom.equalToSuperview().offset(-Spacing.s)
      })
      iconImageView.snp.makeConstraints { make in
         make.size.equalTo(Constants.Icon.size)
      }
   }
}

extension SunInformationView {
   func apply(viewModel: SunInformationViewModel) {
      titleLabel.text = viewModel.title
      titleLabel.underline()
      sunriseTimeLabel.text = viewModel.sunrise
      sunsetTimeLabel.text = viewModel.sunset
      iconImageView.image = viewModel.icon
   }
}
