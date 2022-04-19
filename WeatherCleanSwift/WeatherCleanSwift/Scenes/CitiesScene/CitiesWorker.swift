//
//  CitiesWorker.swift
//  WeatherCleanSwift
//
//  Created by Андрей Коноплёв on 13.04.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
import Foundation

final class CitiesWorker: CitiesWorkerLogic, NetworkSessionProtocol {
func getBaseWeather(
        _ request: Cities.InitForm.Request,
        completion: @escaping (Result<Cities.WeatherModel, NetworkError>) -> Void
    ) {
        let endPoint: EndpointProtocol = EndPoint(neededCity: request.city)
        let completionWrapper: (Result<Cities.WeatherModel, NetworkError>) -> Void = { result in
            switch result {
            case.success(let success): completion(.success(success))
            case.failure(_): completion(.failure(.badrequest))
            }
        }
        network(endpoint: endPoint, completion: completionWrapper)
    }
    var session: URLSession
    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
}
private struct EndPoint: EndpointProtocol {
    let neededCity: String
    var urlScheme: String = "https"
    var host: String = "api.openweathermap.org"
    var path: String = "/data/2.5/weather"
    var urlQueryItems: [URLQueryItem]
    init(neededCity: String) {
        self.neededCity = neededCity
        self.urlQueryItems = [URLQueryItem(name: "q", value: neededCity),
                              URLQueryItem(name: "appid", value: "60753fb700c1552fd355ec3461e206e3"),
                              URLQueryItem(name: "units", value: "metric")]
    }
    var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.host = host
        urlComponents.scheme = urlScheme
        urlComponents.path = path
        urlComponents.queryItems = urlQueryItems
        return urlComponents.url
}
}
