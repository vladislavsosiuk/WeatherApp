//
//  LocationServiceProtocol.swift
//  WeatherApp
//
//  Created by Vladislav Sosiuk on 2/4/19.
//  Copyright © 2019 Vladislav Sosiuk. All rights reserved.
//

import Foundation
import BrightFutures

struct Location {
    let latitude: Double
    let longitude: Double
}

enum LocationServiceError: Error {
    case failedToGetLocation
}

protocol LocationService {
    func getLocation() -> Future<Location, LocationServiceError>
}
