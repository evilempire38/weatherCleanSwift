//
//  CitiesInteractorTests.swift
//  WeatherCleanSwiftTests
//
//  Created by Андрей Коноплёв on 25.04.2022.
//

import Foundation
import XCTest
@testable import WeatherCleanSwift

final class CitiesInteractorTests: XCTestCase {
    let presenter = CitiesPresenterMock()
    let worker = CitiesWorkerMock()
    func testPresentCityWeatherWasCalled() {
        worker.result = .success(success)
        let interactor = CitiesInteractor(presenter: presenter, worker: worker)
        let request = Cities.InitForm.Request(firstLoad: false, city: "Moscow")
        let expectation = XCTestExpectation(description: "wait city")
        interactor.requestWeather(request)
        DispatchQueue.main.async {
            XCTAssertTrue(
                self.worker.getBaseWeatherWasCalled,
                "Метод получения погоды должен быть вызыван, ждем флаг true"
            )
            XCTAssertTrue(self.presenter.presentCityWeatherWasCalled, "Получили город. Ждем флаг true")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    func testPresentAbsentAlertControllerWasCalled() {
        worker.result = .failure(.failureDecoding)
        let interactor = CitiesInteractor(presenter: presenter, worker: worker)
        let request = Cities.InitForm.Request(firstLoad: true)
        let expectation = XCTestExpectation(description: "first load, bad city")
        interactor.requestWeather(request)
        DispatchQueue.main.async {
            XCTAssertTrue(
                self.presenter.presentAbsentAlertControllerWasCalled,
                "Ответ failure decoding, идем в presentAbsentAlertController"
            )
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    func testPresentStorageIsEmptyWasCalled() {
        worker.result = .failure(.storageIsEmpty)
        let interactor = CitiesInteractor(presenter: presenter, worker: worker)
        let request = Cities.InitForm.Request(firstLoad: true)
        let expectation = XCTestExpectation(description: "first load, bad city")
        interactor.requestWeather(request)
        DispatchQueue.main.async {
            XCTAssertTrue(
                self.presenter.presentStorageIsEmptyWasCalled,
                "вернулся failure - storageIsEmpty, вызываем метод"
            )
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    private var success: [Cities.WeatherModel] = [Cities.WeatherModel(
        coord: Cities.Coord(
            lon: 32,
            lat: 23
        ),
        weather: [Cities.Weather(
            id: 32,
            main: "we",
            weatherDescription: "awd",
            icon: "dw"
        )
                 ],
        main: Cities.Main(
            temp: 23,
            feelsLike: 23,
            tempMin: 23,
            tempMax: 23,
            pressure: 2332,
            humidity: 2323
        ),
        visibility: 2323,
        wind: Cities.Wind(speed: 32, deg: 23),
        clouds: Cities.Clouds(all: 33),
        date: Date(),
        timezone: 3,
        id: 2,
        name: "Moscow",
        cod: 23
    )
    ]
}
