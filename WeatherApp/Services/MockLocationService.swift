//
//  MockLocationService.swift
//  WeatherApp
//
//  Created by Vladislav Sosiuk on 2/4/19.
//  Copyright © 2019 Vladislav Sosiuk. All rights reserved.
//

import Foundation
import BrightFutures

class MockLocationService: LocationService {
    func getLocation() -> Future<Location, LocationServiceError> {
        let promise = Promise<Location, LocationServiceError>()
        let mockLocation = Location(latitude: 50.45466 , longitude: 30.5238)
        promise.success(mockLocation)
        
        return promise.future
    }
}
