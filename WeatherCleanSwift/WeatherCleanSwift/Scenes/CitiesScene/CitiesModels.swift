//
//  CitiesModels.swift
//  WeatherCleanSwift
//
//  Created by Андрей Коноплёв on 13.04.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum Cities {
    enum InitForm {
        struct Request {
            let city: String?
            let firstLoad: Bool
            init(
                firstLoad: Bool,
                city: String? = nil
            ) {
                    self.firstLoad = firstLoad
                    self.city = city
                }
        }
        struct Response: Codable {
            let weatherModel: [WeatherModel]
        }
        struct ViewModel {
            var weatherModel: [WeatherModel]
        }
    }
    struct WeatherModel: Codable {
        let coord: Coord?
        let weather: [Weather]
        let main: Main
        let visibility: Int
        let wind: Wind
        let clouds: Clouds
        let date: Date
        var dateString: String {
            date.prepareTheDate()
        }
        let timezone, id: Int
        let name: String
        let cod: Int
        enum CodingKeys: String, CodingKey {
            case coord
            case weather
            case main
            case visibility
            case wind
            case clouds
            case date = "dt"
            case timezone
            case id
            case name
            case cod
        }
    }
    struct Clouds: Codable {
        let all: Int
    }
    struct Coord: Codable {
        let lon: Double?
        let lat: Double?
    }
    struct Main: Codable {
        let temp, feelsLike, tempMin, tempMax: Double
        let pressure, humidity: Int
        enum CodingKeys: String, CodingKey {
            case temp
            case feelsLike = "feels_like"
            case tempMin = "temp_min"
            case tempMax = "temp_max"
            case pressure, humidity
        }
    }
    struct Weather: Codable {
        let id: Int?
        let main, weatherDescription, icon: String
        enum CodingKeys: String, CodingKey {
            case id, main
            case weatherDescription = "description"
            case icon
        }
    }
    struct Wind: Codable {
        let speed: Double
        let deg: Int
    }
}
private extension Date {
    func prepareTheDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        return dateFormatter.string(from: self)
    }
}
