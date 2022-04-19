//
//  CitiesPresenterMock.swift
//  WeatherCleanSwiftTests
//
//  Created by Андрей Коноплёв on 25.04.2022.
//

import Foundation
import XCTest
@testable import WeatherCleanSwift

final class CitiesPresenterMock: CitiesPresentationLogic {
    weak var viewController: CitiesDisplayLogic?
    var presentCityWeatherWasCalled: Bool = false
    var presentAbsentAlertControllerWasCalled: Bool = false
    var presentStorageIsEmptyWasCalled: Bool = false
    func presentCityWeather(_ response: Cities.InitForm.Response) {
        let viewModel = Cities.InitForm.ViewModel(weatherModel: response.weatherModel)
        viewController?.displayCityWeather(viewModel)
        presentCityWeatherWasCalled = true
    }
    func presentAbsentAlertController() {
        viewController?.displayAbsentAlertController()
        presentAbsentAlertControllerWasCalled = true
    }
    func presentStorageIsEmpty() {
        viewController?.displayStorageIsEmpty()
        presentStorageIsEmptyWasCalled = true
    }
}
