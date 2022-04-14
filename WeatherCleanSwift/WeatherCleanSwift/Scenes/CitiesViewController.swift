//
//  CitiesViewController.swift
//  WeatherCleanSwift
//
//  Created by Андрей Коноплёв on 13.04.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class CitiesViewController: ViewController, CitiesDisplayLogic {
    private let interactor: CitiesBusinessLogic
    private let router: CitiesRoutingLogic

    init(
        interactor: CitiesBusinessLogic,
        router: CitiesRoutingLogic
    ) {
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initForm()
    }

    // MARK: - CitiesDisplayLogic

    func displayInitForm(_ viewModel: Cities.InitForm.ViewModel) {}

    // MARK: - Private

    private func initForm() {
        interactor.requestInitForm(Cities.InitForm.Request())
    }
}
