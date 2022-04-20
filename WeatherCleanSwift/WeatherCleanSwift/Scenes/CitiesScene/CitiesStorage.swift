//
//  CitiesStorage.swift
//  WeatherCleanSwift
//
//  Created by Андрей Коноплёв on 19.04.2022.
//

import Foundation
protocol CitiesStorageProtocol {
    func saveObject(_ object: Cities.WeatherModel)
    func loadObject() -> [Cities.WeatherModel]?
}
class CitiesStorage: CitiesStorageProtocol {
    private enum StorageError: Error {
        case unavailableData
        case failureToSaveData
    }
    private let key = "weather"
    private let userDefaultsManager: UserDefaults
    init(userDefaultsManager: UserDefaults = .standard) {
        self.userDefaultsManager = userDefaultsManager
    }
    func saveObject(_ object: Cities.WeatherModel) {
        let data: Data?
        if var loadedObject = loadObject() {
            loadedObject.append(object)
            data = try? JSONEncoder().encode(loadedObject)
        } else {
            data = try? JSONEncoder().encode([object])
        }
        guard let data = data else { return }
        userDefaultsManager.set(data, forKey: key)
    }
    func loadObject() -> [Cities.WeatherModel]? {
        guard let data = userDefaultsManager.value(forKey: key) as? Data else { return nil }
        let weather = try? JSONDecoder().decode([Cities.WeatherModel].self, from: data)
        return weather
    }
}
