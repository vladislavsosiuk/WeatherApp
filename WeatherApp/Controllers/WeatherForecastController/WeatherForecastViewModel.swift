//
//  WeatherForecastViewModel.swift
//  WeatherApp
//
//  Created by Vladislav Sosiuk on 2/4/19.
//  Copyright © 2019 Vladislav Sosiuk. All rights reserved.
//

import Foundation

// MARK: - View Events

enum WeatherForecastControllerViewEvent {
    case viewDidLoad
    case didTapTryAgainButton
}

// MARK: - Controller Commands

enum WeatherForecastControllerCommand {
    case didLoad(WeatherForecastViewState)
}

// MARK: - Delegate

protocol WeatherForecastViewModelDelegate: class {
    func perform(_ command: WeatherForecastControllerCommand)
}

// MARK: - ViewModel

class WeatherForecastViewModel {
    
    // MARK: - Properties
    
    weak var delegate: WeatherForecastViewModelDelegate?
    
    private let viewStateFactory: WeatherForecastViewStateFactory
    private let locationService: LocationService
    private let networkManager: NetworkManager
    
    // MARK: - Initialization
    
    init(viewStateFactory: WeatherForecastViewStateFactory, locationService: LocationService, networkManager: NetworkManager) {
        self.viewStateFactory = viewStateFactory
        self.locationService = locationService
        self.networkManager = networkManager
    }
    
    // MARK: - Implementation
    
    func receive(event: WeatherForecastControllerViewEvent) {
        switch event {
        case .viewDidLoad:
            handleViewDidLoad()
        case .didTapTryAgainButton:
            handleDidTapTryAgainButton()
        }
    }
    
    // MARK: - Helpers
    
    private func configureView(isLoading: Bool, forecasts: [DailyForecast], failedToLoadData: Bool) {
        let viewState = viewStateFactory.make(from: forecasts, isLoading: isLoading, failedToLoadData: failedToLoadData)
        delegate?.perform(.didLoad(viewState))
    }
    
    private func handleViewDidLoad() {
        fetchData()
    }
    
    private func handleFetchingError(_ error: Error) {
        configureView(isLoading: false, forecasts: [], failedToLoadData: true)
    }
    
    private func handleDidTapTryAgainButton() {
        fetchData()
    }
    
    private func fetchData() {
        configureView(isLoading: true, forecasts: [], failedToLoadData: false)
        locationService.getLocation()
            .onSuccess { [weak self] location in
                self?.fetchForecast(with: location)
            }
            .onFailure { [weak self] error in
                self?.handleFetchingError(error)
        }
    }
    
    private func fetchForecast(with location: Location) {
        networkManager.fetchForecast(for: location)
            .onSuccess(callback: { [weak self] forecasts in
                self?.configureView(isLoading: false, forecasts: forecasts, failedToLoadData: false)
            })
            .onFailure(callback: { [weak self] error in
                self?.handleFetchingError(error)
            })
    }
}
