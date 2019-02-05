//
//  UITableView+Extensions.swift
//  WeatherApp
//
//  Created by Vladislav Sosiuk on 2/4/19.
//  Copyright © 2019 Vladislav Sosiuk. All rights reserved.
//

import UIKit

extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
