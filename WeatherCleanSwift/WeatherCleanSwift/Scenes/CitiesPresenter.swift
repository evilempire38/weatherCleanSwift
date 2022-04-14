//
//  CitiesPresenter.swift
//  WeatherCleanSwift
//
//  Created by Андрей Коноплёв on 13.04.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

final class CitiesPresenter: CitiesPresentationLogic {
    weak var viewController: CitiesDisplayLogic?

    func presentInitForm(_ response: Cities.InitForm.Response) {
        viewController?.displayInitForm(Cities.InitForm.ViewModel())
    }
}
