//
//  WeatherManagerDelegate.swift
//  Clima
//
//  Created by Jade Myers on 15/01/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(weather: WeatherModel);
}
