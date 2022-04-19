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

    func presentCityWeather(_ response: Cities.InitForm.Response) {
        viewController?.displayCityWeather(
            Cities.InitForm.ViewModel(
                location: response.weatherModel.name,
                description: response.weatherModel.weather?[0].weatherDescription ?? "",
                time: Date().prepareTheDate(dataFromServer: response.weatherModel.date),
                lowTemperature: "L:\(Int(response.weatherModel.main.tempMin).description)",
                highTemperature: "H:\(Int(response.weatherModel.main.tempMax).description)",
                temperature: "\(Int(response.weatherModel.main.temp).description)˚",
                index: 0
            )
        )
    }
}
extension Date {
    func prepareTheDate(dataFromServer: Int) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "MMM d, yyyy"
        let dateFromInterval = Date(timeIntervalSince1970: TimeInterval(dataFromServer))
        let date = dateFormatter.string(from: dateFromInterval)
        return date
    }
}
