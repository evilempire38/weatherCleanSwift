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
        struct Request {}
        struct Response {}
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
}
