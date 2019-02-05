//
//  ForecastTableCell.swift
//  WeatherApp
//
//  Created by Vladislav Sosiuk on 2/4/19.
//  Copyright © 2019 Vladislav Sosiuk. All rights reserved.
//

import UIKit

class ForecastTableCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet private var weatherImage: UIImageView!
    @IBOutlet private var dayLabel: UILabel!
    @IBOutlet private var temperatureLabel: UILabel!
    
    // MARK: - Configuration
    
    func configure(with viewState: ForecastTableCellViewState) {
        weatherImage.image = viewState.image
        dayLabel.text = viewState.day
        temperatureLabel.text = viewState.temperature
    }
}
