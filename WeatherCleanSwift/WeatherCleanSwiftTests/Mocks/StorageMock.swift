//
//  StorageMock.swift
//  WeatherCleanSwiftTests
//
//  Created by Андрей Коноплёв on 21.04.2022.
//

import Foundation
@testable import WeatherCleanSwift

final class StorageMock: CitiesStorageProtocol {
    var isObjectSaved = false
    var isObjectLoaded = false
    func saveObject(_ object: Cities.WeatherModel) {
        isObjectSaved = true
    }
    func loadObject() -> [Cities.WeatherModel]? {
        let object = [Cities.WeatherModel]()
        isObjectLoaded = true
        return object
    }
}
