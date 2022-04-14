//
//  CitiesProtocols.swift
//  WeatherCleanSwift
//
//  Created by Андрей Коноплёв on 13.04.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

protocol CitiesDataPassing {
    var dataStore: CitiesDataStore { get }
}

protocol CitiesDataStore {}

protocol CitiesBusinessLogic {
    func requestInitForm(_ request: Cities.InitForm.Request)
}

protocol CitiesWorkerLogic {}

protocol CitiesPresentationLogic {
    func presentInitForm(_ response: [Cities.InitForm.Response])
}

protocol CitiesDisplayLogic: AnyObject {
    func displayInitForm(_ viewModel: [Cities.InitForm.ViewModel])
}

protocol CitiesRoutingLogic {}
