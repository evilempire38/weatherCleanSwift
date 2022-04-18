//
//  CitiesViewController.swift
//  WeatherCleanSwift
//
//  Created by Андрей Коноплёв on 13.04.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class CitiesViewController: UIViewController, CitiesDisplayLogic,
                                  UISearchBarDelegate, UISearchControllerDelegate,
                                  UISearchResultsUpdating, UITextViewDelegate {
    private let interactor: CitiesBusinessLogic
    private let router: CitiesRoutingLogic
    let collection: UICollectionView = {
        let collectionLayout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        return collection
    }()
    let searchBar = UISearchBar()
    let weatherLabel = UILabel()
    private var weatherDataModel: [Cities.InitForm.ViewModel] = []
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
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(tapGesture)
         let rightBarButton: UIBarButtonItem = {
            let button = UIButton(type: .custom)
            button.addTarget(self, action: #selector(callAlertController), for: .allTouchEvents)
            button.setBackgroundImage(UIImage(named: "points"), for: .normal)
            return UIBarButtonItem(customView: button)
        }()
        self.navigationItem.rightBarButtonItem = rightBarButton
        createUI()
    }
    @objc private func hideKeyboard() {
        self.view.endEditing(true)
    }

    // MARK: - CitiesDisplayLogic

    func displayInitForm(_ viewModel: Cities.InitForm.ViewModel) {
        weatherDataModel.append(viewModel)
        collection.reloadData()
    }

    // MARK: - Private

    private func initForm() {
    }

    // MARK: - Creating Interface
    private func createUI() {
        setupWeatherLabel()
        setupSearchController()
        setupWeatherCollection()
    }
    private func setupWeatherCollection() {
        self.view.addSubview(collection)
        collection.delegate = self
        collection.dataSource = self
        collection.register(CitiesCollectionViewCell.self, forCellWithReuseIdentifier: "citiesCell")
        collection.backgroundColor = .black
        collection.keyboardDismissMode = .onDrag
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0
        ).isActive = true
        collection.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0
        ).isActive = true
        collection.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10).isActive = true
        collection.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 240).isActive = true
        collection.widthAnchor.constraint(equalToConstant: 340).isActive = true
        collection.heightAnchor.constraint(equalToConstant: 410).isActive = true
    }

    private func setupWeatherLabel() {
        self.view.addSubview(weatherLabel)
        weatherLabel.textColor = .white
        weatherLabel.text = "Weather"
        weatherLabel.font = UIFont(name: "Avenir-Light", size: 37.0)
        weatherLabel.font = UIFont.systemFont(ofSize: 37, weight: .bold)
        weatherLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherLabel.heightAnchor.constraint(equalToConstant: 44).isActive = true
        weatherLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        weatherLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
    }

    private func setupSearchController() {
        self.view.addSubview(searchBar)
        searchBar.placeholder = "Search for a city or airport"
        searchBar.barTintColor = .black
        searchBar.searchTextField.textColor = .lightGray
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        searchBar.widthAnchor.constraint(equalToConstant: 320).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 40).isActive = true
        searchBar.topAnchor.constraint(equalTo: weatherLabel.bottomAnchor, constant: 8).isActive = true
    }

    @objc private func callAlertController() {
        let alertController = UIAlertController(title: "Add city", message: nil, preferredStyle: .alert)
        alertController.addTextField { myTextField in
            myTextField.placeholder = "Add city"
        }
        let findAction = UIAlertAction(title: "Find", style: .default) { [weak alertController] _ in
            guard let textFields = alertController?.textFields else { return }
            if let cityText = textFields[0].text {
                self.interactor.requestWeather(Cities.InitForm.Request(city: cityText))
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        alertController.addAction(findAction)
        present(alertController, animated: true)
    }
}
extension CitiesViewController: UICollectionViewDataSource,
                                UICollectionViewDelegate,
                                UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherDataModel.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "citiesCell",
            for: indexPath
        ) as? CitiesCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(object: weatherDataModel[indexPath.row])
        return cell
    }
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
            return CGSize(width: collectionView.frame.width - 20, height: 120)
        }
    func updateSearchResults(for searchController: UISearchController) {
    }
}
private enum Constants {
    var cellNames: String {
         "citiesCell"
    }
}
