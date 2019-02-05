//
//  NetworkManagerProtocol.swift
//  WeatherApp
//
//  Created by Vladislav Sosiuk on 2/4/19.
//  Copyright © 2019 Vladislav Sosiuk. All rights reserved.
//

import Foundation
import BrightFutures

enum NetworkManagerError: Error {
    case failedToFetchForecast
}

protocol NetworkManager {
    func fetchForecast(for location: Location) -> Future<[DailyForecast], NetworkManagerError>
}
