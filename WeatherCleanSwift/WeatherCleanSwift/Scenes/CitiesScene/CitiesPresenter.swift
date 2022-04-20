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
        let weatherModel = response.weatherModel.map { element in
            Cities.WeatherModel(
                coord: element.coord,
                weather: element.weather,
                main: element.main,
                visibility: element.visibility,
                wind: element.wind,
                clouds: element.clouds,
                date: element.date,
                timezone: element.timezone,
                id: element.id,
                name: element.name,
                cod: element.cod
            )
        }
        let viewModel = Cities.InitForm.ViewModel(weatherModel: weatherModel)
        viewController?.displayCityWeather(viewModel)
    }
    func presentStorageIsEmpty() {
        viewController?.displayStorageIsEmpty()
    }
}
extension Date {
    func prepareTheDate(dateFromServer: Int) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "MMM d, yyyy"
        let dateFromInterval = Date(timeIntervalSince1970: TimeInterval(dateFromServer))
        let date = dateFormatter.string(from: dateFromInterval)
        return date
    }
}
