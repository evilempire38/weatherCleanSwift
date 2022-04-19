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
            let city: String
        }
        struct Response: Decodable {
            let weatherModel: WeatherModel
        }
        struct ViewModel {
            let location: String
            let time: String
            let description: String
            let temperature: String
            let lowTemperature: String
            let highTemperature: String
            let booleanForImage: Bool?
            var cellImage: UIImage? {
                if booleanForImage ?? false {
                    return UIImage(named: "Mask Group")
                } else {
                    return UIImage(named: "Group")
                }
            }
            init(
                location: String,
                description: String,
                time: String,
                lowTemperature: String,
                highTemperature: String,
                temperature: String,
                index: Int
            ) {
                self.lowTemperature = lowTemperature
                self.location = location
                self.description = description
                self.highTemperature = highTemperature
                self.temperature = temperature
                self.time = time
                if index.isMultiple(of: 2) {
                    self.booleanForImage = true
                } else {
                    self.booleanForImage = false
                }
            }
        }
    }
    struct WeatherModel: Decodable {
        let coord: Coord?
        let weather: [Weather]?
        let main: Main
        let visibility: Int
        let wind: Wind
        let clouds: Clouds
        let date: Int
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
    struct Clouds: Decodable {
        let all: Int
    }
    struct Coord: Decodable {
        let lon: Double?
        let lat: Double?
    }
    struct Main: Decodable {
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
    struct Weather: Decodable {
        let id: Int?
        let main, weatherDescription, icon: String
        enum CodingKeys: String, CodingKey {
            case id, main
            case weatherDescription = "description"
            case icon
        }
    }
    struct Wind: Decodable {
        let speed: Double
        let deg: Int
    }
}
