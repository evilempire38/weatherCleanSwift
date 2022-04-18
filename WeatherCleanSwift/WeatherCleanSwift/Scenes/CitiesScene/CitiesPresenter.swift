//
//  CitiesPresenter.swift
//  WeatherCleanSwift
//
//  Created by Андрей Коноплёв on 13.04.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

final class CitiesPresenter: CitiesPresentationLogic {
    func presentAbsentAlertController() {
        viewController?.displayAbsentAlertController()
    }
    weak var viewController: CitiesDisplayLogic?

    func presentCityWeather(_ response: Cities.WeatherModel) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "MMM d, yyyy"
        let dateString = Date(timeIntervalSince1970: TimeInterval(response.date))
        let date = dateFormatter.string(from: dateString)
        viewController?.displayCityWeather(
            Cities.InitForm.ViewModel(
                location: response.name,
                description: response.weather?[0].weatherDescription ?? "",
                time: date,
                lowTemperature: "L:\(Int(response.main.tempMin).description)",
                highTemperature: "H:\(Int(response.main.tempMax).description)",
                temperature: "\(Int(response.main.temp).description)˚",
                index: 0
            )
        )
    }
}
