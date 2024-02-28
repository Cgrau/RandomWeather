import UIKit
import Kingfisher
import SnapKit

final class ExtraInformationView: View {
   private enum Constants {
      enum Title {
         static let font = UIFont.boldSystemFont(ofSize: 20)
      }
      enum Text {
         static let font = UIFont.boldSystemFont(ofSize: 18)
      }
   }
   
   private var titleLabel: UILabel = {
      let label = UILabel()
      label.textColor = .black
      label.font = Constants.Title.font
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
   }()
   
   private var pressureLabel: UILabel = {
      let label = UILabel()
      label.textColor = .black
      label.font = Constants.Text.font
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
   }()
   
   private var humidityLabel: UILabel = {
      let label = UILabel()
      label.textColor = .black
      label.font = Constants.Text.font
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
   }()
   
   private var seaLevelLabel: UILabel = {
      let label = UILabel()
      label.textColor = .black
      label.font = Constants.Text.font
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
   }()
   
   private var groundLevelLabel: UILabel = {
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
      addSubviews()
   }
   
   private func addSubviews() {
      [pressureLabel, humidityLabel, seaLevelLabel, groundLevelLabel].forEach(informationStackView.addArrangedSubview)
      [titleLabel, informationStackView].forEach(addSubview)
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
         make.trailing.equalToSuperview().offset(-Spacing.s)
         make.bottom.equalToSuperview().offset(-Spacing.s)
      })
   }
}

extension ExtraInformationView {
   func apply(viewModel: ExtraInformationViewModel) {
      titleLabel.text = viewModel.title
      titleLabel.underline()
      pressureLabel.text = viewModel.pressure
      humidityLabel.text = viewModel.humidity
      seaLevelLabel.text = viewModel.seaLevel
      groundLevelLabel.text = viewModel.groundLevel
   }
}
