//
//  CitiesWorkerMock.swift
//  WeatherCleanSwiftTests
//
//  Created by Андрей Коноплёв on 25.04.2022.
//
import Foundation
import XCTest
@testable import WeatherCleanSwift

final class CitiesWorkerMock: CitiesWorkerLogic {
    var result: Result<[Cities.WeatherModel], NetworkError>?
    var error: NetworkError?
    var getBaseWeatherWasCalled: Bool = false
    func getBaseWeather(
        _ request: Cities.InitForm.Request, completion: @escaping (Result<[Cities.WeatherModel], NetworkError>) -> Void
    ) {
        getBaseWeatherWasCalled = true
        guard let result = result else {
            completion(.failure(.jsonError))
            return
        }
        completion(result)
    }
}
