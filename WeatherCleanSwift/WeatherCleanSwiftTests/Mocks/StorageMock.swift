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
    var savedMockObject: Cities.WeatherModel?
    var loadedMockObject: [Cities.WeatherModel]?
    func saveObject(_ object: Cities.WeatherModel) {
        isObjectSaved = true
        self.savedMockObject = object
    }
    func loadObject() -> [Cities.WeatherModel]? {
        isObjectLoaded = true
        return loadedMockObject
    }
}
