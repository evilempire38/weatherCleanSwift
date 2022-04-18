//
//  CitiesRouter.swift
//  WeatherCleanSwift
//
//  Created by Андрей Коноплёв on 13.04.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class CitiesRouter: CitiesRoutingLogic, CitiesDataPassing {
    weak var viewController: UIViewController?
    let dataStore: CitiesDataStore

    init(dataStore: CitiesDataStore) {
        self.dataStore = dataStore
    }
}

private extension CitiesRouter {
}
