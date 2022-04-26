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
    var object: Cities.WeatherModel?
    var saveObject: [Cities.WeatherModel]?
    func saveObject(_ object: Cities.WeatherModel) {
        isObjectSaved = true
        self.object = object
    }
    func loadObject() -> [Cities.WeatherModel]? {
        isObjectLoaded = true
        return saveObject
    }
}
