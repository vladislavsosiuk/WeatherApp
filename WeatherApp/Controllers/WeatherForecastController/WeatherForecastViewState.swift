//
//  WeatherForecastViewState.swift
//  WeatherApp
//
//  Created by Vladislav Sosiuk on 2/4/19.
//  Copyright © 2019 Vladislav Sosiuk. All rights reserved.
//

import Foundation

struct WeatherForecastViewState {
    let isLoading: Bool
    let forecasts: [ForecastTableCellViewState]
    let failedToLoadData: Bool
}
