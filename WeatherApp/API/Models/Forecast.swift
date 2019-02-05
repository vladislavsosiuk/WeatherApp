//
//  Forecast.swift
//  WeatherApp
//
//  Created by Vladislav Sosiuk on 2/4/19.
//  Copyright © 2019 Vladislav Sosiuk. All rights reserved.
//

import Foundation

struct RootForecast: Decodable {
    let daily: DailyForecasts
}

struct DailyForecasts: Decodable {
    let data: [DailyForecast]
}

struct DailyForecast: Decodable {
    let icon: String
    let temperatureMax: Double
    let temperatureMin: Double
    let time: Double
}
