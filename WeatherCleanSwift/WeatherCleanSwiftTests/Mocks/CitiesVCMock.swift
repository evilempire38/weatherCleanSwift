//
//  CitiesVCMock.swift
//  WeatherCleanSwiftTests
//
//  Created by Андрей Коноплёв on 21.04.2022.
//

import Foundation
import XCTest
@testable import WeatherCleanSwift

final class CitiesVCMock: CitiesDisplayLogic {
    var displayCityWeatherWasCalled: Bool = false
    var displayAbsentAlertControllerWasCalled: Bool = false
    var displayStorageIsEmptyWasCalled: Bool = false
    var viewModel: Cities.InitForm.ViewModel?
    func displayCityWeather(_ viewModel: Cities.InitForm.ViewModel) {
        displayCityWeatherWasCalled = true
        self.viewModel = viewModel
    }
    func displayAbsentAlertController() {
        displayAbsentAlertControllerWasCalled = true
    }
    func displayStorageIsEmpty() {
        displayStorageIsEmptyWasCalled = true
    }
}
