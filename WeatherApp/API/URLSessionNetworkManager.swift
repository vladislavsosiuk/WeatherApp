//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Vladislav Sosiuk on 2/4/19.
//  Copyright © 2019 Vladislav Sosiuk. All rights reserved.
//

import Foundation
import BrightFutures

class URLSessionNetworkManager: NetworkManager {
    
    // MARK: - Consts
    
    fileprivate enum Consts {
        static let endPoint = "https://api.darksky.net/forecast/7ec83e824eb7f8d90e3bb0e2d91fb9f8"
    }
    
    // MARK: - Private Properties
    
    private let session: Session
    
    private var baseUrl: URL {
        guard let url = URL(string: Consts.endPoint) else {
            fatalError("Url expected")
        }
        return url
    }
    
    // MARK: - Init
    
    init(session: Session) {
        self.session = session
    }
    
    // MARK: - Implementation
    
    func fetchForecast(for location: Location) -> Future<[DailyForecast], NetworkManagerError> {
        let promise = Promise<[DailyForecast], NetworkManagerError>()
        let locationPathComponent = "\(location.latitude), \(location.longitude)"
        
        let url = baseUrl.appendingPathComponent(locationPathComponent)
        
        session.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    let forecast = try JSONDecoder().decode(RootForecast.self, from: data)
                    promise.success(forecast.daily.data)
                }
                catch {
                    print(error)
                    promise.failure(NetworkManagerError.failedToFetchForecast)
                }
                
            }
            else if let error = error {
                print(error)
                promise.failure(NetworkManagerError.failedToFetchForecast)
            }
        }
        .resume()
        
        return promise.future
    }
}
