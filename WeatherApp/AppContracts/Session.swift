//
//  Session.swift
//  WeatherApp
//
//  Created by Vladislav Sosiuk on 2/5/19.
//  Copyright © 2019 Vladislav Sosiuk. All rights reserved.
//

import Foundation

protocol Session {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: Session {}
