//
//  CitiesProtocols.swift
//  WeatherCleanSwift
//
//  Created by Андрей Коноплёв on 13.04.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
import Foundation

protocol CitiesDataPassing {
    var dataStore: CitiesDataStore { get }
}

protocol CitiesDataStore {}

protocol CitiesBusinessLogic {
    func requestWeather(_ request: Cities.InitForm.Request)
}

protocol CitiesWorkerLogic {
    func getBaseWeather(
        _ request: Cities.InitForm.Request,
        completion: @escaping (Result<Cities.WeatherModel, NetworkError>) -> Void
    )
}

protocol CitiesPresentationLogic {
    func presentCityWeather(_ response: Cities.InitForm.Response)
    func presentAbsentAlertController ()
}

protocol CitiesDisplayLogic: AnyObject {
    func displayCityWeather(_ viewModel: Cities.InitForm.ViewModel)
    func displayAbsentAlertController ()
}

protocol CitiesRoutingLogic {}
