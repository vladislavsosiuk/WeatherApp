//
//  MainAssembly.swift
//  WeatherApp
//
//  Created by Vladislav Sosiuk on 2/4/19.
//  Copyright © 2019 Vladislav Sosiuk. All rights reserved.
//

import Swinject
import SwinjectStoryboard

class MainAssembly: Assembly {
    func assemble(container: Container) {
        
        // MARK: - Services
        
        container.register(LocationService.self) { _ in
            return MockLocationService()
        }
        
        // MARK: - Managers
        
        container.register(NetworkManager.self) { _ in
            let session = URLSession(configuration: .default)
            return URLSessionNetworkManager(session: session)
        }
        
        // MARK: - ViewState Factories
        
        container.register(WeatherForecastViewStateFactory.self) { _ in
            return WeatherForecastViewStateFactory()
        }
        
        // MARK: - ViewModels
        
        container.register(WeatherForecastViewModel.self) { resolver in
            guard let viewStateFactory = resolver.resolve(WeatherForecastViewStateFactory.self),
                let locationService = resolver.resolve(LocationService.self),
                let networkManager = resolver.resolve(NetworkManager.self) else {
                    fatalError("Dependencies should be initialized")
            }
            
            return WeatherForecastViewModel(viewStateFactory: viewStateFactory, locationService: locationService, networkManager: networkManager)
        }
        
        // MARK: - Storyboards
        
        container.storyboardInitCompleted(WeatherForecastController.self) { resolver, controller in
            guard let viewModel = container.resolve(WeatherForecastViewModel.self) else {
                fatalError("Dependency should be initialized")
            }
            controller.inject(viewModel: viewModel)
            
            viewModel.delegate = controller
        }
    }
}
