//
//  Networkmanager.swift
//  WeatherCleanSwift
//
//  Created by Андрей Коноплёв on 15.04.2022.
//

import Foundation

protocol EndpointProtocol {
    var url: URL? { get }
}
protocol NetworkSessionProtocol {
    var session: URLSession { get set }
    func network<Success: Decodable>(
        endpoint: EndpointProtocol,
        completion: @escaping (Result<Success, NetworkError>) -> Void
    )
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
                    let success = try JSONDecoder().decode(Success.self, from: data)
                    completion(.success(success))
                } catch {
                    print(error)
                    completion(.failure(.failureDecoding))
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
    case failureDecoding
}
