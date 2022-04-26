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
        presentCityWeatherWasCalled = true
    }
    func presentAbsentAlertController() {
        presentAbsentAlertControllerWasCalled = true
    }
    func presentStorageIsEmpty() {
        presentStorageIsEmptyWasCalled = true
    }
}
