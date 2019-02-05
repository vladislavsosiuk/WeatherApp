//
//  WeatherForecastViewStateFactory.swift
//  WeatherApp
//
//  Created by Vladislav Sosiuk on 2/4/19.
//  Copyright © 2019 Vladislav Sosiuk. All rights reserved.
//

import UIKit

class WeatherForecastViewStateFactory {
    
    // MARK: - Consts
    
    fileprivate enum Consts {
        enum WeatherTypes {
            static let cloudy = "cloudy"
            static let clearDay = "clear-day"
            static let clearNight = "clear-night"
            static let rain = "rain"
            static let snow = "snow"
            static let sleet = "sleet"
            static let wind = "wind"
            static let fog = "fog"
            static let partlyCloudyDay = "partly-cloudy-day"
            static let partlyCloudyNight = "partly-cloudy-night"
        }
    }
    
    // MARK: - Helpers
    
    private func getDayName(from unixTime: Double) -> String {
        let date = Date(timeIntervalSince1970: unixTime)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date)
    }
    
    private func getWeatherIcon(_ name: String) -> UIImage? {
        switch name {
        case Consts.WeatherTypes.clearDay, Consts.WeatherTypes.clearNight:
            return UIImage.sunnyIcon
        case Consts.WeatherTypes.rain:
            return UIImage.rainIcon
        case Consts.WeatherTypes.snow, Consts.WeatherTypes.sleet:
            return UIImage.snowIcon
        case Consts.WeatherTypes.wind:
            return UIImage.windIcon
        case Consts.WeatherTypes.cloudy, Consts.WeatherTypes.fog:
            return UIImage.cloudyIcon
        case Consts.WeatherTypes.partlyCloudyDay, Consts.WeatherTypes.partlyCloudyNight:
            return UIImage.partlyCloudyIcon
        default:
            return nil
        }
    }
    
    private func getCelsiumTemperature(from fahrenheitTemp: Double) -> Int {
        return Int((fahrenheitTemp - 32) / 1.8)
    }
    
    // MARK: - Implelemtation
    
    func make(from forecasts: [DailyForecast], isLoading: Bool, failedToLoadData: Bool) -> WeatherForecastViewState {
        let cellsViewState = forecasts.map { forecast -> ForecastTableCellViewState in
            let minTemperature = getCelsiumTemperature(from: forecast.temperatureMin)
            let maxTemperature = getCelsiumTemperature(from: forecast.temperatureMax)
            let temperature = "\(minTemperature) - \(maxTemperature) °C"
            return ForecastTableCellViewState(
                image: getWeatherIcon(forecast.icon),
                day: getDayName(from: forecast.time),
                temperature: temperature)
        }
        return WeatherForecastViewState(isLoading: isLoading, forecasts: cellsViewState, failedToLoadData: failedToLoadData)
    }
}
