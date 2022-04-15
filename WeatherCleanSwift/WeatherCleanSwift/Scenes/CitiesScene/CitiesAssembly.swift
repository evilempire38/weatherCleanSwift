//
//  CitiesAssembly.swift
//  WeatherCleanSwift
//
//  Created by Андрей Коноплёв on 13.04.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum CitiesAssembly {
    static func build() -> UIViewController {
        let presenter = CitiesPresenter()
        let worker = CitiesWorker()
        let interactor = CitiesInteractor(presenter: presenter, worker: worker)
        let router = CitiesRouter(dataStore: interactor)
        let viewController = CitiesViewController(interactor: interactor, router: router)

        presenter.viewController = viewController
        router.viewController = viewController

        return viewController
    }
}
