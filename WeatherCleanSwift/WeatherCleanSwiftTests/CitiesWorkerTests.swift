//
//  CitiesWorkerTest.swift
//  WeatherCleanSwiftTests
//
//  Created by Андрей Коноплёв on 21.04.2022.
//

import Foundation
import XCTest
@testable import WeatherCleanSwift

final class CitiesWorkerTests: XCTestCase {
    func testStorageSaveObject() {
        let jsonMock = JsonMock()
        let storageMock = StorageMock()
        let sessionMock = URLSessionMock(data: jsonMock.success, response: nil, error: nil)
        let worker = CitiesWorker(storage: storageMock, session: sessionMock)
        let request = Cities.InitForm.Request(firstLoad: false, city: "Moscow")
        let expectaionToSave = expectation(description: "\(#function)\(#line) try to save object")
        worker.getBaseWeather(request) { result in
            switch result {
            case .success(let success):
                let object = success.first
                XCTAssert(request.city == object?.name, "город запрошенный и сохраненный совпадают")
                expectaionToSave.fulfill()
            case .failure(let error):
                XCTFail("что-то пошло не так\(error)")
            }
        }
        wait(for: [expectaionToSave], timeout: 1)
    }
    func testIsDecodeFailure() {
        let jsonMock = JsonMock()
        let storageMock = StorageMock()
        let sessionMock = URLSessionMock(data: jsonMock.failure, response: nil, error: nil)
        let worker = CitiesWorker(storage: storageMock, session: sessionMock)
        let request = Cities.InitForm.Request(firstLoad: false, city: "Mocsow")
        let expeсtationFailureDecoding = expectation(description: "\(#function)\(#line) failure decoding")
        worker.getBaseWeather(request) { result in
            switch result {
            case .success(let success):
                XCTFail("Got \(success) instead of error")
            case .failure(let error):
                XCTAssert(error == .unknownError)
            }
            expeсtationFailureDecoding.fulfill()
        }
        wait(for: [expeсtationFailureDecoding], timeout: 1)
    }
    func testIsDecodeSuccess() {
        let jsonMock = JsonMock()
        let storageMock = StorageMock()
        let sessionMock = URLSessionMock(data: jsonMock.success, response: nil, error: nil)
        let worker = CitiesWorker(storage: storageMock, session: sessionMock)
        let request = Cities.InitForm.Request(firstLoad: false, city: "Mocsow")
        let expeсtationSuccessDecoding = expectation(description: "\(#function)\(#line) success decoding")
        worker.getBaseWeather(request) { result in
            switch result {
            case .success(let success):
                XCTAssert(success[0].name == "Moscow", "должны получать Moscow")
            case .failure(let error):
                XCTFail("got \(error) instead of success")
            }
            expeсtationSuccessDecoding.fulfill()
        }
        wait(for: [expeсtationSuccessDecoding], timeout: 1)
    }
    func testsIsRequestStorage() {
        let request = Cities.InitForm.Request(firstLoad: true)
        let mockStorage = StorageMock()
        let worker = CitiesWorker(storage: mockStorage)
        worker.getBaseWeather(request) { _ in }
        XCTAssertTrue(mockStorage.isObjectLoaded, "Должен вернуться флаг true")
    }
    func testsIsCityAdded() {
        let jsonSuccess = JsonMock()
        let sessionMock = URLSessionMock(data: jsonSuccess.success, response: nil, error: nil)
        let request = Cities.InitForm.Request(firstLoad: false, city: "Moscow")
        let mockStorage = StorageMock()
        let worker = CitiesWorker(storage: mockStorage, session: sessionMock)
        let addCityExpection = XCTestExpectation(description: "Добавление города")
        worker.getBaseWeather(request) { result in
            switch result {
            case .success(_):
                XCTAssertTrue(mockStorage.isObjectSaved, "Объект должен сохраниться, возвращая флаг true")
                addCityExpection.fulfill()
            case .failure(let error):
                XCTFail("\(error)")
            }
        }
        wait(for: [addCityExpection], timeout: 1)
    }
    func testsIsUnknownCity() {
        let sessionMock = URLSessionMock(data: nil, response: nil, error: nil)
        let request = Cities.InitForm.Request(firstLoad: false, city: "aWaefrgs")
        let mockStorage = StorageMock()
        let worker = CitiesWorker(storage: mockStorage, session: sessionMock)
        let addAbsentAllerExpection = XCTestExpectation(description: "Ожидание для absentAlertController")
        worker.getBaseWeather(request) { result in
            switch result {
            case .success(let success):
                XCTFail("found \(success) instead of fail")
            case .failure(let error):
                XCTAssertFalse(mockStorage.isObjectSaved, "Объект несохранен, тк \(error). Вернем false")
            }
            addAbsentAllerExpection.fulfill()
        }
        wait(for: [addAbsentAllerExpection], timeout: 1)
    }
}
private class URLSessionMock: URLSession {
    var data: Data?
    var response: URLResponse?
    var error: NetworkError?
    var mockTask: MockTask
    init(data: Data?, response: URLResponse?, error: Error?) {
        mockTask = MockTask(data: data, response: response, error: error)
    }
    override func dataTask(
        with url: URL,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask {
        mockTask.completionHandler = completionHandler
        return mockTask
    }
}

private class MockTask: URLSessionDataTask {
    private let data: Data?
    private let urlResponse: URLResponse?
    private let _error: Error?
    override var error: Error? {
        return _error
    }
    var completionHandler:(
        (Data?, URLResponse?, Error?) -> Void)?
    init(
        data: Data?, response: URLResponse?, error: Error?
    ) {
        self.data = data
        self.urlResponse = response
        self._error = error
    }
    override func resume() {
        DispatchQueue.main.async {
            guard let completionHandler = self.completionHandler else {
                return
            }
            completionHandler(self.data, self.urlResponse, self.error)
        }
    }
}
private struct JsonMock {
    var failure: Data? = {
        var json = """
        {
          "status": "OK",
          "content": {
            "deviceId": "123"
          }
        }
        """
return json.data(using: .utf8)
}()
    var success: Data? = {
       var json = """
        {
            "coord": {
                "lon": 37.6156,
                "lat": 55.7522
            },
            "weather": [
                {
                    "id": 804,
                    "main": "Clouds",
                    "description": "overcast clouds",
                    "icon": "04d"
                }
            ],
            "base": "stations",
            "main": {
                "temp": 8.98,
                "feels_like": 8.36,
                "temp_min": 8.13,
                "temp_max": 10.13,
                "pressure": 1022,
                "humidity": 91,
                "sea_level": 1022,
                "grnd_level": 1004
            },
            "visibility": 10000,
            "wind": {
                "speed": 1.62,
                "deg": 90,
                "gust": 4
            },
            "clouds": {
                "all": 100
            },
            "dt": 1650619490,
            "sys": {
                "type": 1,
                "id": 9027,
                "country": "RU",
                "sunrise": 1650593268,
                "sunset": 1650646080
            },
            "timezone": 10800,
            "id": 524901,
            "name": "Moscow",
            "cod": 200
        }
        """
        return json.data(using: .utf8)
    }()
}
