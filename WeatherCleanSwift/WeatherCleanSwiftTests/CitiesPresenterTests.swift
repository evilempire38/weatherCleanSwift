//
//  CitiesPresenterTests.swift
//  WeatherCleanSwiftTests
//
//  Created by Андрей Коноплёв on 21.04.2022.
//

import Foundation
import XCTest
@testable import WeatherCleanSwift

final class CitiesPresenterTests: XCTestCase {
    let presenter = CitiesPresenter()
    let mockViewController = CitiesViewControllerMock()
    func testPresentCityWeather() {
        presenter.viewController = mockViewController
        presenter.presentCityWeather(Cities.InitForm.Response(weatherModel: []))
        XCTAssertTrue(mockViewController.displayCityWeatherWasCalled, "Метод вызван. Ждем флаг true")
    }
    func testPresentAbsentAlertController() {
        presenter.viewController = mockViewController
        presenter.presentAbsentAlertController()
        XCTAssertTrue(mockViewController.displayAbsentAlertControllerWasCalled, "Метод вызван. Жлем флаг true")
    }
    func testPresentStorageIsEmpty() {
        presenter.viewController = mockViewController
        presenter.presentStorageIsEmpty()
        XCTAssertTrue(mockViewController.displayStorageIsEmptyWasCalled, "Метод вызван. Жлем флаг true")
    }
}
