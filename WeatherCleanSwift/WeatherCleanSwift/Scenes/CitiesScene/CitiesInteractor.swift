//
//  CitiesInteractor.swift
//  WeatherCleanSwift
//
//  Created by Андрей Коноплёв on 13.04.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
import Foundation

final class CitiesInteractor: CitiesBusinessLogic, CitiesDataStore {
    private let presenter: CitiesPresentationLogic
    private let worker: CitiesWorkerLogic

    init(
        presenter: CitiesPresentationLogic,
        worker: CitiesWorkerLogic
    ) {
        self.presenter = presenter
        self.worker = worker
    }

    func requestInitForm(_ request: Cities.InitForm.Request) {
    }
}
