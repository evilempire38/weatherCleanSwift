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
    func testPresentCityWeather() {
        let presenter = CitiesPresenter()
        let mockViewController = CitiesViewControllerMock()
        presenter.viewController = mockViewController
        presenter.presentCityWeather(Cities.InitForm.Response(weatherModel: []))
        XCTAssertTrue(mockViewController.displayCityWeatherWasCalled, "Метод вызван. Ждем флаг true")
    }
    func testPresentAbsentAlertController() {
        let presenter = CitiesPresenter()
        let mockViewController = CitiesViewControllerMock()
        presenter.viewController = mockViewController
        presenter.presentAbsentAlertController()
        XCTAssertTrue(mockViewController.displayAbsentAlertControllerWasCalled, "Метод вызван. Жлем флаг true")
    }
    func testPresentStorageIsEmpty() {
        let presenter = CitiesPresenter()
        let mockViewController = CitiesViewControllerMock()
        presenter.viewController = mockViewController
        presenter.presentStorageIsEmpty()
        XCTAssertTrue(mockViewController.displayStorageIsEmptyWasCalled, "Метод вызван. Жлем флаг true")
    }
}
