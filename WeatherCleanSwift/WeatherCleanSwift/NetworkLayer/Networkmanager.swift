//
//  Networkmanager.swift
//  WeatherCleanSwift
//
//  Created by Андрей Коноплёв on 15.04.2022.
//

import Foundation

protocol EndpointProtocol {
    var urlScheme: String { get set }
    var host: String { get set }
    var path: String { get set }
    var urlQueryItems: [URLQueryItem] { get set }
}
protocol NetworkSessionProtocol {
    var session: URLSession { get set }
    func network<Success: Decodable>(
        endpoint: EndpointProtocol,
        completion: @escaping (Result<Success, NetworkError>) -> Void
    )
}
extension EndpointProtocol {
    var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.host = host
        urlComponents.scheme = urlScheme
        urlComponents.path = path
        urlComponents.queryItems = urlQueryItems
        return urlComponents.url
}
}
extension NetworkSessionProtocol {
    func network<Success: Decodable>(
        endpoint: EndpointProtocol,
        completion: @escaping (Result<Success, NetworkError>) -> Void
    ) {
        guard let url = endpoint.url else {
            completion(.failure(.badrequest))
            return
        }
        let task = session.dataTask(with: url) { data, _, _ in
            if let data = data {
                do {
                    let myData = try JSONDecoder().decode(Success.self, from: data)
                    completion(.success(myData))
                } catch {
                    print(error)
                    completion(.failure(.badrequest))
                    return
                }
            } else {
                completion(.failure(.badrequest))
                return
            }
        }
        task.resume()
    }
}
enum NetworkError: Error {
    case badrequest
}
