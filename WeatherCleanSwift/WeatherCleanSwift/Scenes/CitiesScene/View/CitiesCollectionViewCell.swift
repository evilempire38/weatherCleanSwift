//
//  CitiesCollectionViewCell.swift
//  WeatherCleanSwift
//
//  Created by Андрей Коноплёв on 14.04.2022.
//

import UIKit

class CitiesCollectionViewCell: UICollectionViewCell {
    private enum Constants {
        enum FontsName: String {
            case avenir = "Avenir"
            case basicFont
        }
    }
    private var locationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.FontsName.avenir.rawValue, size: 25)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.FontsName.avenir.rawValue, size: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.FontsName.avenir.rawValue, size: 16)
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.FontsName.avenir.rawValue, size: 53)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var lowTemperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.FontsName.avenir.rawValue, size: 15)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var highTemperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.FontsName.avenir.rawValue, size: 15)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var backgroundImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    func configure(object: Cities.WeatherModel, indexPath: Int) {
        locationLabel.text = object.name
        timeLabel.text = object.dateString
        descriptionLabel.text = object.weather[0].weatherDescription
        temperatureLabel.text = "\(Int(object.main.temp).description)˚"
        highTemperatureLabel.text = "H:\(Int(object.main.tempMax).description)"
        lowTemperatureLabel.text = "L:\(Int(object.main.tempMin).description)"
        backgroundImageView.image = UIImage(named: "Group")
    }
    private func addSubviews() {
        contentView.addSubview(backgroundImageView)
        backgroundImageView.addSubview(locationLabel)
        backgroundImageView.addSubview(timeLabel)
        backgroundImageView.addSubview(descriptionLabel)
        backgroundImageView.addSubview(temperatureLabel)
        backgroundImageView.addSubview(lowTemperatureLabel)
        backgroundImageView.addSubview(highTemperatureLabel)
    }
    private func buildConstraintsForBackgroundImageView() {
        backgroundImageView.topAnchor.constraint(
            equalTo: contentView.topAnchor,
            constant: 0
        ).isActive = true
        backgroundImageView.bottomAnchor.constraint(
            equalTo: contentView.bottomAnchor,
            constant: 0
        ).isActive = true
        backgroundImageView.leadingAnchor.constraint(
            equalTo: contentView.safeAreaLayoutGuide.leadingAnchor,
            constant: 2
        ).isActive = true
        backgroundImageView.trailingAnchor.constraint(
            equalTo: contentView.safeAreaLayoutGuide.trailingAnchor,
            constant: 2
        ).isActive = true
        locationLabel.leadingAnchor.constraint(
            equalTo: backgroundImageView.leadingAnchor,
            constant: 20
        ).isActive = true
    }
    private func buildConstraintsForLocationLabel() {
        locationLabel.topAnchor.constraint(equalTo: backgroundImageView.topAnchor, constant: 8).isActive = true
        locationLabel.heightAnchor.constraint(
            equalToConstant: 30
        ).isActive = true
        timeLabel.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor, constant: 20).isActive = true
        timeLabel.topAnchor.constraint(
            equalTo: locationLabel.bottomAnchor,
            constant: 4
        ).isActive = true
    }
    private func buildConstraintsForDescriptionLabel() {
        descriptionLabel.leadingAnchor.constraint(
            equalTo: backgroundImageView.leadingAnchor,
            constant: 20
        ).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 10).isActive = true
        descriptionLabel.widthAnchor.constraint(
            equalToConstant: 195
        ).isActive = true
    }
    private func buildConstraintsForTemperetureLabel() {
        temperatureLabel.topAnchor.constraint(
            equalTo: backgroundImageView.topAnchor,
            constant: 8
        ).isActive = true
        temperatureLabel.trailingAnchor.constraint(
            equalTo: backgroundImageView.trailingAnchor,
            constant: 5
        ).isActive = true
        temperatureLabel.widthAnchor.constraint(
            equalToConstant: 85
        ).isActive = true
    }
    private func buildConstraintsForLowAndHighTemperetureLabel() {
        lowTemperatureLabel.trailingAnchor.constraint(
            equalTo: backgroundImageView.trailingAnchor,
            constant: -20
        ).isActive = true
        lowTemperatureLabel.topAnchor.constraint(
            equalTo: temperatureLabel.bottomAnchor,
            constant: 15
        ).isActive = true
        highTemperatureLabel.trailingAnchor.constraint(
            equalTo: lowTemperatureLabel.leadingAnchor,
            constant: -5
        ).isActive = true
        highTemperatureLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 15).isActive = true
    }
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addSubviews()
        buildConstraintsForBackgroundImageView()
        buildConstraintsForLocationLabel()
        buildConstraintsForDescriptionLabel()
        buildConstraintsForTemperetureLabel()
        buildConstraintsForLowAndHighTemperetureLabel()
}
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
