import UIKit
import SnapKit

final class MainInformationView: View {
   private enum Constants {
      enum Location {
         static let font = UIFont.boldSystemFont(ofSize: 32)
      }
      enum Subtitle {
         static let font = UIFont.boldSystemFont(ofSize: 18)
      }
      enum Temperature {
         static let font = UIFont.boldSystemFont(ofSize: 80)
      }
      enum Description {
         static let font = UIFont.boldSystemFont(ofSize: 20)
      }
      enum MinMax {
         static let font = UIFont.boldSystemFont(ofSize: 18)
      }
   }
   
   private var locationLabel: UILabel = {
      let label = UILabel()
      label.textColor = .black
      label.textAlignment = .center
      label.font = Constants.Location.font
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
   }()
   
   private var coordinatesStackView: UIStackView = {
      let stackView = UIStackView()
      stackView.axis = .horizontal
      stackView.alignment = .fill
      stackView.spacing = Spacing.m
      stackView.distribution = .equalSpacing
      stackView.translatesAutoresizingMaskIntoConstraints = false
      return stackView
   }()
   
   private var latitudeLabel: UILabel = {
      let label = UILabel()
      label.textColor = .black
      label.textAlignment = .center
      label.font = Constants.Subtitle.font
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
   }()
   
   private var longitudeLabel: UILabel = {
      let label = UILabel()
      label.textColor = .black
      label.textAlignment = .center
      label.font = Constants.Subtitle.font
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
   }()
   
   private var temperatureLabel: UILabel = {
      let label = UILabel()
      label.textColor = .black
      label.textAlignment = .center
      label.font = Constants.Temperature.font
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
   }()
   
   private var descriptionLabel: UILabel = {
      let label = UILabel()
      label.textColor = .black
      label.textAlignment = .center
      label.font = Constants.Description.font
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
   }()
   
   private var minmaxStackView: UIStackView = {
      let stackView = UIStackView()
      stackView.axis = .horizontal
      stackView.alignment = .fill
      stackView.spacing = Spacing.m
      stackView.distribution = .equalSpacing
      stackView.translatesAutoresizingMaskIntoConstraints = false
      return stackView
   }()
   
   private var minTemperatureLabel: UILabel = {
      let label = UILabel()
      label.textColor = .black
      label.textAlignment = .center
      label.font = Constants.MinMax.font
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
   }()
   
   private var maxTemperatureLabel: UILabel = {
      let label = UILabel()
      label.textColor = .black
      label.textAlignment = .center
      label.font = Constants.MinMax.font
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
   }()
   
   override func setupView() {
      backgroundColor = .white
      locationLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
      locationLabel.setContentCompressionResistancePriority(.required, for: .vertical)
      temperatureLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
      temperatureLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
      addSubviews()
   }
   
   private func addSubviews() {
      [latitudeLabel, longitudeLabel].forEach(coordinatesStackView.addArrangedSubview)
      [minTemperatureLabel, maxTemperatureLabel].forEach(minmaxStackView.addArrangedSubview)
      [locationLabel, coordinatesStackView, temperatureLabel, descriptionLabel, minmaxStackView].forEach(addSubview)
   }
   
   override func setupConstraints() {
      locationLabel.snp.makeConstraints { make in
         make.top.equalToSuperview().offset(Spacing.s)
         make.leading.equalToSuperview().offset(Spacing.m)
         make.trailing.equalToSuperview().offset(-Spacing.m)
      }
      coordinatesStackView.snp.makeConstraints { make in
         make.top.equalTo(locationLabel.snp.bottom).offset(Spacing.xs)
         make.centerX.equalToSuperview()
      }
      temperatureLabel.snp.makeConstraints { make in
         make.top.equalTo(coordinatesStackView.snp.bottom).offset(Spacing.xs)
         make.leading.equalToSuperview().offset(Spacing.m)
         make.trailing.equalToSuperview().offset(-Spacing.m)
      }
      descriptionLabel.snp.makeConstraints { make in
         make.top.equalTo(temperatureLabel.snp.bottom).offset(Spacing.xs)
         make.leading.equalToSuperview().offset(Spacing.m)
         make.trailing.equalToSuperview().offset(-Spacing.m)
      }
      minmaxStackView.snp.makeConstraints { make in
         make.top.equalTo(descriptionLabel.snp.bottom).offset(Spacing.xs)
         make.centerX.equalToSuperview()
         make.bottom.equalToSuperview().offset(-Spacing.s)
      }
   }
}

extension MainInformationView {
   func apply(viewModel: MainInformationViewModel) {
      locationLabel.text = viewModel.location
      latitudeLabel.text = viewModel.latitude
      longitudeLabel.text = viewModel.longitude
      temperatureLabel.text = viewModel.temperature
      descriptionLabel.text = viewModel.description
      minTemperatureLabel.text = viewModel.minTemperature
      maxTemperatureLabel.text = viewModel.maxTemperature
   }
}
