//
//  CitiesPresenter.swift
//  WeatherCleanSwift
//
//  Created by Андрей Коноплёв on 13.04.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit

final class CitiesPresenter: CitiesPresentationLogic {
    func presentAbsentAlertController() {
        viewController?.displayAbsentAlertController()
    }
    weak var viewController: CitiesDisplayLogic?

    func presentCityWeather(_ response: Cities.InitForm.Response) {
        let viewWeatherModel = Cities.InitForm.ViewModel(weatherModel: response.weatherModel)
        viewController?.displayCityWeather(viewWeatherModel)
    }
    func presentStorageIsEmpty() {
        viewController?.displayStorageIsEmpty()
    }
}
