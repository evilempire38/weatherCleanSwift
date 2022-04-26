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
        let responseMock = makeMockResponse()
        presenter.presentCityWeather(Cities.InitForm.Response(weatherModel: responseMock))
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
        let storageExpection = XCTestExpectation(description: "ожидание storage")
        presenter.presentStorageIsEmpty()
        storageExpection.fulfill()
        wait(for: [storageExpection], timeout: 2)
        XCTAssertTrue(mockViewController.displayStorageIsEmptyWasCalled, "Метод вызван. Жлем флаг true")
    }
    private func makeMockResponse() -> [Cities.WeatherModel] {
        let cityWeather = Cities.WeatherModel(
            coord: Cities.Coord(lon: 213123, lat: 123123),
            weather: [Cities.Weather(id: 3, main: "Main", weatherDescription: "Very Cold", icon: "bad icon")],
            main: Cities.Main(
                temp: 32,
                feelsLike: 23,
                tempMin: 23,
                tempMax: 2345,
                pressure: 123,
                humidity: 23
            ),
            visibility: 3,
            wind: Cities.Wind(speed: 32, deg: 23),
            clouds: Cities.Clouds(all: 32),
            date: Date(),
            timezone: 23,
            id: 23,
            name: "City",
            cod: 3
        )
        return Array(repeating: cityWeather, count: 5)
    }
}
