//
//  WeatherForecastController.swift
//  WeatherApp
//
//  Created by Vladislav Sosiuk on 2/4/19.
//  Copyright © 2019 Vladislav Sosiuk. All rights reserved.
//

import UIKit

class WeatherForecastController: UIViewController {
    
    // MARK: - View
    
    func view() -> WeatherForecastView {
        guard let view = view as? WeatherForecastView else {
            fatalError("View expected to be of type WeatherForecastView")
        }
        return view
    }
    
    // MARK: - Properties
    
    private var viewModel: WeatherForecastViewModel!
    
    // MARK: - Dependency Injection
    
    func inject(viewModel: WeatherForecastViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view().delegate = self
        
        viewModel.receive(event: .viewDidLoad)
    }
}

// MARK: - ViewModel Delegate

extension WeatherForecastController: WeatherForecastViewModelDelegate {
    
    func perform(_ command: WeatherForecastControllerCommand) {
        switch command {
        case .didLoad(let viewState):
            view().configure(with: viewState)
            break
        }
    }
}

// MARK: - WeatherForecastView Delegate {

extension WeatherForecastController: WeatherForecastViewDelegate {
    func didTapTryAgainButton() {
        viewModel.receive(event: .didTapTryAgainButton)
    }
}
