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
    var presenter: CitiesPresenter!
    var mockViewController: CitiesViewControllerMock!
    override func setUp() {
        presenter = CitiesPresenter()
        mockViewController = CitiesViewControllerMock()
        presenter.viewController = mockViewController
    }
    func testPresentCityWeather() {
        presenter.presentCityWeather(Cities.InitForm.Response(weatherModel: []))
        XCTAssertTrue(mockViewController.displayCityWeatherWasCalled, "Метод вызван. Ждем флаг true")
    }
    func testPresentAbsentAlertController() {
        presenter.presentAbsentAlertController()
        XCTAssertTrue(mockViewController.displayAbsentAlertControllerWasCalled, "Метод вызван. Жлем флаг true")
    }
    func testPresentStorageIsEmpty() {
        presenter.presentStorageIsEmpty()
        XCTAssertTrue(mockViewController.displayStorageIsEmptyWasCalled, "Метод вызван. Жлем флаг true")
    }
}
