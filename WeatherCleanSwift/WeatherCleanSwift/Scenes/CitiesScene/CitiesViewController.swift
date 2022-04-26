//
//  CitiesViewController.swift
//  WeatherCleanSwift
//
//  Created by Андрей Коноплёв on 13.04.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class CitiesViewController: UIViewController, CitiesDisplayLogic {
    private let interactor: CitiesBusinessLogic
    private let router: CitiesRoutingLogic
    private let searchBar = UISearchBar()
    private let weatherLabel = UILabel()
    private var weatherDataModel: Cities.InitForm.ViewModel?
    private var filteredDataModel: Cities.InitForm.ViewModel?
    private var isSearchingInSearchBar: Bool = false
    private enum Constants {
       static var cellNames: String {
             "citiesCell"
        }
    }
    private let collection: UICollectionView = {
        let collectionLayout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        return collection
    }()
    private let rightBarButton: UIBarButtonItem = {
       let button = UIButton(type: .custom)
       button.setBackgroundImage(UIImage(named: "points"), for: .normal)
       return UIBarButtonItem(customView: button)
   }()
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
        createUI()
        initForm()
    }
    // MARK: - CitiesDisplayLogic

        func displayCityWeather(_ viewModel: Cities.InitForm.ViewModel) {
        if weatherDataModel == nil {
            self.weatherDataModel = .init(weatherModel: viewModel.weatherModel)
        } else {
            guard var neededArray = self.weatherDataModel?.weatherModel else { return }
            neededArray.append(contentsOf: viewModel.weatherModel ?? [])
        }
        collection.reloadData()
    }
    func displayStorageIsEmpty() {
        callAlertController()
    }
    func displayAbsentAlertController () {
        let absentAC = UIAlertController(title: "Oops!", message: "No such city", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        absentAC.addAction(okAction)
        present(absentAC, animated: true, completion: nil)
    }

    // MARK: - Private

    private func initForm() {
        interactor.requestWeather(Cities.InitForm.Request(firstLoad: true))
    }

    // MARK: - Creating Interface
    private func createUI() {
        setupWeatherLabel()
        setupSearchController()
        setupWeatherCollection()
        addGestureForHidingKeyboard()
        addGestureForRightBarButton()
    }
    private func addGestureForHidingKeyboard() {
        let gestureHidingKeyboard = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(gestureHidingKeyboard)
    }
    private func addGestureForRightBarButton() {
        let buttonGesture = UITapGestureRecognizer(target: self, action: #selector(callAlertController))
        rightBarButton.customView?.addGestureRecognizer(buttonGesture)
    }

    private func setupWeatherCollection() {
        self.view.addSubview(collection)
        collection.delegate = self
        collection.dataSource = self
        self.navigationItem.rightBarButtonItem = rightBarButton
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
        searchBar.delegate = self
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
            if let cityText = textFields.first?.text {
                self.interactor.requestWeather(Cities.InitForm.Request(firstLoad: false, city: cityText))
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        alertController.addAction(findAction)
        present(alertController, animated: true)
    }
    @objc private func hideKeyboard() {
        self.view.endEditing(true)
    }
}
extension CitiesViewController: UICollectionViewDataSource,
                                UICollectionViewDelegate {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch isSearchingInSearchBar {
        case true : return filteredDataModel?.weatherModel?.count ?? 1
        case false : return weatherDataModel?.weatherModel?.count ?? 1
        }
    }

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.cellNames,
            for: indexPath
        ) as? CitiesCollectionViewCell else { return UICollectionViewCell() }
let object =
    isSearchingInSearchBar ?
    filteredDataModel?.weatherModel?[indexPath.row] :
    weatherDataModel?.weatherModel?[indexPath.row]
    if let object = object {
        cell.configure(object: object, indexPath: indexPath.row)
    }
        return cell
    }
extension CitiesViewController: UISearchBarDelegate {
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            guard var neededArray = filteredDataModel?.weatherModel else { return }
            neededArray.removeAll()
            isSearchingInSearchBar = false
        } else {
            isSearchingInSearchBar = true
            filteredDataModel?.weatherModel = weatherDataModel?.weatherModel?.filter {
                $0.name.hasPrefix(searchText)
            } ?? []
        }
        collection.reloadData()
    }
extension CitiesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: collectionView.frame.width - 20, height: 120)
    }
}
