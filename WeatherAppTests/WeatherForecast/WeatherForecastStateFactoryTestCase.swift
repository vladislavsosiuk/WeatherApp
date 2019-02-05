//
//  WeatherForecastStateFactoryTestCase.swift
//  WeatherAppTests
//
//  Created by Vladislav Sosiuk on 2/4/19.
//  Copyright © 2019 Vladislav Sosiuk. All rights reserved.
//

import XCTest
@testable import WeatherApp

class WeatherForecastStateFactoryTestCase: XCTestCase {

    var viewStateFactory: WeatherForecastViewStateFactory!
    
    override func setUp() {
        viewStateFactory = WeatherForecastViewStateFactory()
    }

    override func tearDown() {
        viewStateFactory = nil
    }

    func testTemperatureConvert() {
        let forecast = DailyForecast(icon: "clear-day", temperatureMax: 59.19, temperatureMin: 34.98, time: 1549281600)
        let viewState = viewStateFactory.make(from: [forecast], isLoading: false, failedToLoadData: false).forecasts[0]
        
        XCTAssertEqual(viewState.temperature, "1 - 15 °C")
    }
    
    func testViewState_ClearDay_Monday() {
        let forecast = DailyForecast(icon: "clear-day", temperatureMax: 59.19, temperatureMin: 34.98, time: 1549281600)
        let viewState = viewStateFactory.make(from: [forecast], isLoading: false, failedToLoadData: false).forecasts[0]
        
        XCTAssertEqual(viewState.day, "Monday")
        XCTAssertNotNil(viewState.image)
    }
    
    func testViewState_ClearNight_Tuesday() {
        let forecast = DailyForecast(icon: "clear-night", temperatureMax: 59.19, temperatureMin: 34.98, time: 1549368000)
        let viewState = viewStateFactory.make(from: [forecast], isLoading: false, failedToLoadData: false).forecasts[0]
        
        XCTAssertEqual(viewState.day, "Tuesday")
        XCTAssertNotNil(viewState.image)
    }
    
    func testViewState_Rain_Wednesday() {
        let forecast = DailyForecast(icon: "rain", temperatureMax: 59.19, temperatureMin: 34.98, time: 1549454400)
        let viewState = viewStateFactory.make(from: [forecast], isLoading: false, failedToLoadData: false).forecasts[0]
        
        XCTAssertEqual(viewState.day, "Wednesday")
        XCTAssertNotNil(viewState.image)
    }
    
    func testViewState_Snow_Thursday() {
        let forecast = DailyForecast(icon: "snow", temperatureMax: 59.19, temperatureMin: 34.98, time: 1549540800)
        let viewState = viewStateFactory.make(from: [forecast], isLoading: false, failedToLoadData: false).forecasts[0]
        
        XCTAssertEqual(viewState.day, "Thursday")
        XCTAssertNotNil(viewState.image)
    }
    
    func testViewState_Sleet_Friday() {
        let forecast = DailyForecast(icon: "sleet", temperatureMax: 59.19, temperatureMin: 34.98, time: 1549627200)
        let viewstate = viewStateFactory.make(from: [forecast], isLoading: false, failedToLoadData: false).forecasts[0]
        
        XCTAssertEqual(viewstate.day, "Friday")
        XCTAssertNotNil(viewstate.image)
    }
    
    func testViewState_Wind_Saturday() {
        let forecast = DailyForecast(icon: "wind", temperatureMax: 59.19, temperatureMin: 34.98, time: 1549713600)
        let viewState = viewStateFactory.make(from: [forecast], isLoading: false, failedToLoadData: false).forecasts[0]
        
        XCTAssertEqual(viewState.day, "Saturday")
        XCTAssertNotNil(viewState.image)
    }
    
    func testViewState_Fog_Sunday() {
        let forecast = DailyForecast(icon: "fog", temperatureMax: 59.19, temperatureMin: 34.98, time: 1549800000)
        let viewState = viewStateFactory.make(from: [forecast], isLoading: false, failedToLoadData: false).forecasts[0]
        
        XCTAssertEqual(viewState.day, "Sunday")
        XCTAssertNotNil(viewState.image)
    }

    func testViewState_Cloudy() {
        let forecast = DailyForecast(icon: "cloudy", temperatureMax: 59.19, temperatureMin: 34.98, time: 1549256400)
        let viewState = viewStateFactory.make(from: [forecast], isLoading: false, failedToLoadData: false).forecasts[0]
        
        XCTAssertNotNil(viewState.image)
    }
    
    func testViewState_PartlyCloudyDay() {
        let forecast = DailyForecast(icon: "partly-cloudy-day", temperatureMax: 59.19, temperatureMin: 34.98, time: 1549256400)
        let viewState = viewStateFactory.make(from: [forecast], isLoading: false, failedToLoadData: false).forecasts[0]
        
        XCTAssertNotNil(viewState.image)
    }
    
    func testViewState_PartlyCloudyNight() {
        let forecast = DailyForecast(icon: "partly-cloudy-night", temperatureMax: 59.19, temperatureMin: 34.98, time: 1549256400)
        let viewState = viewStateFactory.make(from: [forecast], isLoading: false, failedToLoadData: false).forecasts[0]
        
        XCTAssertNotNil(viewState.image)
    }

}
